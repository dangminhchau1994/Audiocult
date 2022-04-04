import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_user.dart';
import 'package:audio_cult/app/features/atlas/atlas_bloc.dart';
import 'package:audio_cult/app/features/atlas/atlas_user_widget.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tuple/tuple.dart';

class AtlasScreen extends StatefulWidget {
  const AtlasScreen({Key? key}) : super(key: key);

  @override
  State<AtlasScreen> createState() => _AtlasScreenState();
}

class _AtlasScreenState extends State<AtlasScreen> {
  late AtlasBloc _bloc;
  final _searchTextController = TextEditingController();
  final _scrollController = ScrollController();
  final PagingController<int, AtlasUser> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _bloc = getIt.get<AtlasBloc>();
    _bloc.getAtlasUsersStream.listen(_listenData);
    _pagingController.addPageRequestListener((number) {
      _bloc.getAtlasUsers(number);
    });
    _scrollController.addListener(_listenScrollView);
  }

  void _listenData(BlocState<Tuple2<List<AtlasUser>, Exception?>> event) {
    event.whenOrNull(
      success: (data) {
        final tupleData = data as Tuple2<List<AtlasUser>, Exception?>;
        final users = tupleData.item1;
        final error = tupleData.item2;
        if (error != null) {
          _pagingController.error = error;
        } else {
          if (users.isEmpty) {
            _pagingController.appendLastPage(users);
          } else {
            _pagingController.appendPage(
              users,
              (_pagingController.nextPageKey ?? 0) + 1,
            );
          }
        }
      },
    );
  }

  void _listenScrollView() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _scrollController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex: 6, child: _searchTextField()),
                    const SizedBox(width: 8),
                    Expanded(child: _filterButon()),
                  ],
                ),
              ),
            ),
            Expanded(child: _atlasListWidget()),
          ],
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.ebonyClay,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.whiteSearchIcon),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 1),
              // color: Colors.green,
              child: TextField(
                controller: _searchTextController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterButon() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.ebonyClay,
        borderRadius: BorderRadius.circular(19),
      ),
      child: IconButton(
        color: AppColors.lightBlue,
        onPressed: () {
          // TODO: handle filter button
        },
        icon: SvgPicture.asset(AppAssets.whiteFilterIcon),
      ),
    );
  }

  Widget _atlasListWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: StreamBuilder(
          stream: _bloc.updatedUserSubscriptionStream,
          builder: (context, data) {
            List<AtlasUser>? updatedSubscriptionData;
            UserSubscriptionDataType? subscriptionInProcess;
            if (data.hasData) {
              final tupleData = data.data! as Tuple2<List<AtlasUser>, UserSubscriptionDataType>;
              updatedSubscriptionData = tupleData.item1;
              subscriptionInProcess = tupleData.item2;
            }
            return PagedListView<int, AtlasUser>(
              padding: const EdgeInsets.only(bottom: 100),
              scrollController: _scrollController,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<AtlasUser>(
                itemBuilder: (context, user, index) {
                  final isUpdatedSubscriptionAvailable = (updatedSubscriptionData?.length ?? 0) > index;
                  return AtlasUserWidget(
                    user,
                    updatedSubscriptionCount:
                        isUpdatedSubscriptionAvailable ? updatedSubscriptionData![index].subscriptionCount : null,
                    updatedSubscriptionStatus:
                        isUpdatedSubscriptionAvailable ? updatedSubscriptionData![index].isSubcribed : null,
                    userSubscriptionInProcess: subscriptionInProcess?[user.userId] ?? false,
                    subscriptionOnChanged: () {
                      _bloc.subcribeUser(user);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    _pagingController.refresh();
  }
}
