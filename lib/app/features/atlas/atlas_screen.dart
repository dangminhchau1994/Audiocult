import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_user.dart';
import 'package:audio_cult/app/features/atlas/atlas_bloc.dart';
import 'package:audio_cult/app/features/atlas/atlas_user_widget.dart';
import 'package:audio_cult/app/features/profile/profile_screen.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/debouncer.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/view/no_data_widget.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tuple/tuple.dart';

class AtlasScreen extends StatefulWidget {
  final String? userId;
  final String? getSubscribed;
  const AtlasScreen({Key? key, this.userId, this.getSubscribed}) : super(key: key);

  @override
  State<AtlasScreen> createState() => _AtlasScreenState();
}

class _AtlasScreenState extends State<AtlasScreen> with AutomaticKeepAliveClientMixin {
  final _debouncer = Debouncer(milliseconds: 1000);
  final _searchTextController = TextEditingController();
  final _scrollController = ScrollController();
  final _pagingController = PagingController<int, AtlasUser>(firstPageKey: 1);
  late AtlasBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt.get<AtlasBloc>();
    _bloc.getAtlasUsersStream.listen(_listenData);
    _bloc.getAtlasUsers(1, widget.userId, widget.getSubscribed);
    _pagingController.addPageRequestListener((page) {
      if (page > 1) {
        _bloc.getAtlasUsers(page, widget.userId, widget.getSubscribed);
      }
    });
    _searchTextController.addListener(_listenKeywordChange);
    _scrollController.addListener(_listenScrollView);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.loaderOverlay.show(
      widget: const LoadingWidget(backgroundColor: Colors.black12),
    );
  }

  void _listenKeywordChange() {
    _bloc.keywordOnChanged(_searchTextController.text);
    _debouncer.run(() {
      _pagingController.refresh();
      _bloc.getAtlasUsers(1, widget.userId, widget.getSubscribed);
    });
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
          if (users.length < _bloc.maximumNumberOfItems) {
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
    super.build(context);
    return BlocHandle(
      bloc: _bloc,
      child: GestureDetector(
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _searchWrapper(),
              ),
              Expanded(child: _refreshableListView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchWrapper() {
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 6, child: _searchTextField()),
          const SizedBox(width: 8),
          Expanded(child: _filterButton()),
        ],
      ),
    );
  }

  Widget _refreshableListView() {
    return RefreshIndicator(
      onRefresh: () async {
        await _pullRefresh();
        return _bloc.getAtlasUsers(1, widget.userId, widget.getSubscribed);
      },
      child: StreamBuilder<BlocState<Tuple2<List<AtlasUser>, Exception?>>>(
        stream: _bloc.getAtlasUsersStream,
        builder: (_, snapshot) {
          if (_bloc.allUsers == null) {
            return Container();
          } else if (_bloc.allUsers!.isEmpty) {
            const NoDataWidget();
          }
          return _atlasListWidget();
        },
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
              child: TextField(
                controller: _searchTextController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: context.l10n.t_search,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.ebonyClay,
        borderRadius: BorderRadius.circular(19),
      ),
      child: IconButton(
        color: AppColors.lightBlue,
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.routeAtlasFilter);
        },
        icon: SvgPicture.asset(AppAssets.whiteFilterIcon),
      ),
    );
  }

  Widget _atlasListWidget() {
    return StreamBuilder(
      stream: _bloc.updatedUserSubscriptionStream,
      builder: (context, data) {
        context.loaderOverlay.hide();
        List<AtlasUser>? updatedSubscriptionData;
        UserSubscriptionDataType? subscriptionInProcess;
        if (data.hasData) {
          final tupleData = data.data! as Tuple2<List<AtlasUser>, UserSubscriptionDataType>;
          updatedSubscriptionData = tupleData.item1;
          subscriptionInProcess = tupleData.item2;
        }
        return Scrollbar(
          child: PagedListView<int, AtlasUser>(
            padding: const EdgeInsets.only(bottom: 24),
            scrollController: _scrollController,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<AtlasUser>(
              newPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
              itemBuilder: (context, user, index) {
                final latestSubscriptionCount =
                    updatedSubscriptionData?.firstWhereOrNull((e) => e.userId == user.userId)?.subscriptionCount;
                final latestSubscriptionValue =
                    updatedSubscriptionData?.firstWhereOrNull((e) => e.userId == user.userId)?.isSubscribed;
                return AtlasUserWidget(
                  user,
                  updatedSubscriptionCount: latestSubscriptionCount,
                  updatedSubscriptionStatus: latestSubscriptionValue,
                  userSubscriptionInProcess: subscriptionInProcess?[user.userId] ?? false,
                  subscriptionOnChanged: () {
                    _bloc.subscribeUser(user);
                  },
                  onTap: () async {
                    if (user.userId?.isNotEmpty == true) {
                      await Navigator.pushNamed(
                        context,
                        AppRoute.routeProfile,
                        arguments: ProfileScreen.createArguments(id: user.userId ?? ''),
                      );
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _pullRefresh() async {
    await _bloc.refreshAtlasUserData();
    _pagingController.refresh();
  }

  @override
  bool get wantKeepAlive => true;
}
