import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_user.dart';
import 'package:audio_cult/app/features/atlas/atlas_user_widget.dart';
import 'package:audio_cult/app/features/atlas_filter_result/atlas_filter_result_bloc.dart';
import 'package:audio_cult/app/features/profile/profile_screen.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/view/no_data_widget.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tuple/tuple.dart';

class AtlasFilterResultScreen extends StatefulWidget {
  final FilterUsersRequest dataRequest;

  const AtlasFilterResultScreen(this.dataRequest, {Key? key}) : super(key: key);

  @override
  State<AtlasFilterResultScreen> createState() => _AtlasFilterResultScreenState();
}

class _AtlasFilterResultScreenState extends State<AtlasFilterResultScreen> {
  final _pagingController = PagingController<int, AtlasUser>(firstPageKey: 1);
  late AtlasFilterResultBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt.get<AtlasFilterResultBloc>();
    _bloc.getUsers(widget.dataRequest);
    _bloc.getAtlasUsersStream.listen((event) {
      if (event.item1.isEmpty) {
        _pagingController.appendLastPage([]);
      } else {
        _pagingController.appendPage(event.item1, (_pagingController.nextPageKey ?? 0) + 1);
      }
    });
    _pagingController.addPageRequestListener((pageNumber) async {
      final request = FilterUsersRequest(
        groupId: widget.dataRequest.groupId,
        categoryId: widget.dataRequest.categoryId,
        countryISO: widget.dataRequest.countryISO,
        genreIds: widget.dataRequest.genreIds,
        page: pageNumber,
      );
      _bloc.getUsers(request);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.loaderOverlay.show(
      widget: const LoadingWidget(backgroundColor: Colors.black12),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: const CommonAppBar(title: 'Results'),
      body: BlocHandle(
        bloc: _bloc,
        child: _refreshableListView(),
      ),
    );
  }

  Widget _usersListWidget() {
    return StreamBuilder(
      stream: _bloc.updatedUserSubscriptionStream,
      builder: (context, data) {
        List<AtlasUser>? updatedSubscriptionData;
        UserSubscriptionDataType? subscriptionsInProcess;
        if (data.hasData) {
          final tupleData = data.data! as Tuple2<List<AtlasUser>, UserSubscriptionDataType>;
          updatedSubscriptionData = tupleData.item1;
          subscriptionsInProcess = tupleData.item2;
        }
        return Scrollbar(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: PagedListView<int, AtlasUser>(
              padding: const EdgeInsets.only(bottom: 100),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<AtlasUser>(
                itemBuilder: (context, user, index) {
                  final latestSubscriptionCount =
                      updatedSubscriptionData?.firstWhereOrNull((e) => e.userId == user.userId)?.subscriptionCount;
                  final latestSubscriptionValue =
                      updatedSubscriptionData?.firstWhereOrNull((e) => e.userId == user.userId)?.isSubscribed;
                  return AtlasUserWidget(
                    user,
                    updatedSubscriptionCount: latestSubscriptionCount,
                    updatedSubscriptionStatus: latestSubscriptionValue,
                    userSubscriptionInProcess: subscriptionsInProcess?[user.userId] ?? false,
                    subscriptionOnChanged: () => _bloc.subscribeUser(user),
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
          ),
        );
      },
    );
  }

  Widget _refreshableListView() {
    return StreamBuilder<Tuple2<List<AtlasUser>, Exception?>>(
      stream: _bloc.getAtlasUsersStream,
      builder: (_, __) {
        if (_bloc.allUsers == null) {
          return Container();
        } else if (_bloc.allUsers!.isEmpty) {
          return const NoDataWidget();
        }
        return _usersListWidget();
      },
    );
  }
}
