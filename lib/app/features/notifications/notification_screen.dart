import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/requests/notification_request.dart';
import 'package:audio_cult/app/data_source/models/responses/notifications/notification_response.dart';
import 'package:audio_cult/app/features/notifications/notification_bloc.dart';
import 'package:audio_cult/app/features/notifications/widgets/notification_item.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/view/no_data_widget.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/loading/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../di/bloc_locator.dart';
import '../../../w_components/loading/loading_widget.dart';
import '../../data_source/local/pref_provider.dart';
import '../../fcm/fcm_bloc.dart';
import '../../injections.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_dimens.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final PagingController<int, NotificationResponse> _pagingController = PagingController(firstPageKey: 1);
  late NotificationBloc _notificationBloc;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _notificationBloc = getIt.get<NotificationBloc>();
    _notificationBloc.requestData(
      params: NotificationRequest(
        page: 1,
        limit: GlobalConstants.loadMoreItem,
        groupByDate: 1,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _notificationBloc.loadData(
        NotificationRequest(
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
          groupByDate: 1,
        ),
      );
      newItems.fold(
        (l) {
          final isLastPage = l.length < GlobalConstants.loadMoreItem;
          if (isLastPage) {
            _pagingController.appendLastPage(l);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(l, nextPageKey);
          }
        },
        (r) => _notificationBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void _clearNotificationBadge() async {
    if (locator<PrefProvider>().countBadge! > 0) {
      await locator<PrefProvider>().clearBadge();
      getIt<FCMBloc>().countBadge(locator<PrefProvider>().countBadge ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.localize.t_notifications,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 12,
              bottom: 12,
            ),
            child: WButtonInkwell(
              onPressed: () {
                _clearNotificationBadge();
                _notificationBloc.markAllRead();
                _pagingController.refresh();
                _notificationBloc.requestData(
                  params: NotificationRequest(
                    page: 1,
                    limit: GlobalConstants.loadMoreItem,
                    groupByDate: 1,
                  ),
                );
              },
              child: Text(
                context.localize.t_mark_all_read,
                style: context.body2TextStyle()?.copyWith(
                      color: AppColors.lightBlue,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHorizontalSpacing,
          vertical: kVerticalSpacing,
        ),
        child: RefreshIndicator(
          color: AppColors.primaryButtonColor,
          backgroundColor: AppColors.secondaryButtonColor,
          onRefresh: () async {
            _pagingController.refresh();
            _notificationBloc.requestData(
              params: NotificationRequest(
                page: 1,
                limit: GlobalConstants.loadMoreItem,
                groupByDate: 1,
              ),
            );
          },
          child: LoadingBuilder<NotificationBloc, List<NotificationResponse>>(
            noDataBuilder: (state) => const NoDataWidget(),
            builder: (data, _) {
              // only first page
              final isLastPage = data.length <= GlobalConstants.loadMoreItem - 1;
              if (isLastPage) {
                _pagingController.appendLastPage(data);
              } else {
                _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
              }

              return RawScrollbar(
                child: PagedListView<int, NotificationResponse>.separated(
                  pagingController: _pagingController,
                  separatorBuilder: (context, index) => const Divider(height: 24),
                  builderDelegate: PagedChildBuilderDelegate<NotificationResponse>(
                    firstPageProgressIndicatorBuilder: (context) => Container(),
                    newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                    animateTransitions: true,
                    itemBuilder: (context, item, index) {
                      return NotificationItem(
                        data: item,
                      );
                    },
                  ),
                ),
              );
            },
            reloadAction: (_) {
              _pagingController.refresh();
              _notificationBloc.requestData(
                params: NotificationRequest(
                  page: 1,
                  limit: GlobalConstants.loadMoreItem,
                  groupByDate: 1,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
