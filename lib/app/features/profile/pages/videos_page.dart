import 'package:audio_cult/app/data_source/models/requests/video_request.dart';
import 'package:audio_cult/app/data_source/models/responses/video_data.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/error_empty/widget_state.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/responses/profile_data.dart';
import '../bloc/profile_video_bloc.dart';

class VideosPage extends StatefulWidget {
  final ProfileData profile;
  final ScrollController scrollController;

  const VideosPage({Key? key, required this.scrollController, required this.profile}) : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final ProfileVideoBloc _profileVideoBloc = ProfileVideoBloc(locator.get());
  final PagingController<int, Video> _pagingController = PagingController(firstPageKey: 1);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      widget.scrollController
          .animateTo(_scrollController.offset, duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
    });
    _fetchPage(1);
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _profileVideoBloc.loadData(
        VideoRequest(
          userId: widget.profile.userId,
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
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
        (r) => _profileVideoBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: PagedGridView(
          scrollController: _scrollController,
          physics: const ClampingScrollPhysics(),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Video>(
            newPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
            firstPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
            noItemsFoundIndicatorBuilder: (_) => const EmptyDataStateWidget(null),
            firstPageErrorIndicatorBuilder: (_) {
              return ErrorSectionWidget(
                errorMessage: _pagingController.error as String,
                onRetryTap: () {
                  _pagingController.refresh();
                  _fetchPage(1);
                },
              );
            },
            itemBuilder: (context, item, index) => WButtonInkwell(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.routeVideoPlayer, arguments: {'data': item});
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CommonImageNetWork(
                      imagePath: item.imagePath,
                    ),
                  ),
                  Container(
                    color: AppColors.mainColor.withOpacity(0.1),
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.mainColor.withOpacity(0.7)),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
          ),
        ),
      ),
    );
  }
}
