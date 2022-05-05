import 'package:audio_cult/app/data_source/models/requests/feed_request.dart';
import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/features/home/widgets/announcement_post.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/loading/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../constants/global_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PagingController<int, FeedResponse> _pagingFeedController = PagingController(firstPageKey: 1);
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = getIt<HomeBloc>();
    _homeBloc.requestData(
      params: FeedRequest(
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _homeBloc.loadData(
        FeedRequest(
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
        ),
      );
      newItems.fold(
        (l) {
          final isLastPage = l.length < GlobalConstants.loadMoreItem;
          if (isLastPage) {
            _pagingFeedController.appendLastPage(l);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingFeedController.appendPage(l, nextPageKey);
          }
        },
        (r) => _homeBloc.showError,
      );
    } catch (error) {
      _pagingFeedController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHorizontalSpacing,
          vertical: kVerticalSpacing,
        ),
        child: LoadingBuilder<HomeBloc, List<FeedResponse>>(
          noDataBuilder: (state) {
            return const CustomScrollView(
              slivers: [
                AnnouncementPost(),
              ],
            );
          },
          builder: (data, _) {
            // only first page
            final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
            if (isLastPage) {
              _pagingFeedController.appendLastPage(data);
            } else {
              _pagingFeedController.appendPage(data, _pagingFeedController.firstPageKey + 1);
            }

            return const CustomScrollView(
              slivers: [
                AnnouncementPost(),
              ],
            );
          },
        ),
      ),
    );
  }
}
