import 'package:audio_cult/app/data_source/models/responses/atlas_user.dart';
import 'package:audio_cult/app/features/profile/subscriptions/subscriptions_bloc.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../injections.dart';
import '../../../utils/constants/app_dimens.dart';

class SubscriptionsScreen extends StatefulWidget {
  final String? userId;
  const SubscriptionsScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  final PagingController<int, AtlasUser> _pagingController = PagingController(firstPageKey: 1);
  final ScrollController _scrollController = ScrollController();
  final SubscriptionsBloc _bloc = SubscriptionsBloc(locator.get());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: context.l10n.t_subscriptions,
      ),
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(kVerticalSpacing),
          child: PagedListView<int, AtlasUser>(
            scrollController: _scrollController,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<AtlasUser>(
              firstPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
              firstPageErrorIndicatorBuilder: (_) {
                return ErrorSectionWidget(
                  errorMessage: _pagingController.error as String,
                  onRetryTap: () {
                    _pagingController.refresh();
                  },
                );
              },
              itemBuilder: (context, user, index) {
                return Container();
                // final latestSubscriptionCount =
                //     updatedSubscriptionData?.firstWhereOrNull((e) => e.userId == user.userId)?.subscriptionCount;
                // final latestSubscriptionValue =
                //     updatedSubscriptionData?.firstWhereOrNull((e) => e.userId == user.userId)?.isSubscribed;
                // return AtlasUserWidget(
                //   user,
                //   updatedSubscriptionCount: latestSubscriptionCount,
                //   updatedSubscriptionStatus: latestSubscriptionValue,
                //   userSubscriptionInProcess: subscriptionInProcess?[user.userId] ?? false,
                //   subscriptionOnChanged: () {
                //     _bloc.subscribeUser(user);
                //   },
                // );
              },
            ),
          ),
        ),
      ),
    );
  }
}
