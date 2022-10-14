import 'dart:typed_data';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/detail/event_detail_bloc.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_attending.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_feed.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_festival.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_info.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_navbar.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_photo.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_title.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_main_info.dart';
import 'package:audio_cult/app/features/ticket/w_bottom_dialog.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../../w_components/tabbars/common_tabbar_item.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/file/file_utils.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({
    Key? key,
    this.id,
    this.fromNotificatiton = false,
  }) : super(key: key);

  final int? id;
  final bool? fromNotificatiton;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  var _currentIndex = 0;
  final _tabController = CustomTabBarController();
  final _pageController = PageController();
  final _scrollController = ScrollController();
  final _pageCount = 2;
  late Uint8List _iconMarker;

  @override
  void initState() {
    super.initState();
    getIt<EventDetailBloc>().getEventDetail(widget.id ?? 0);
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        _iconMarker = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: RefreshIndicator(
        color: AppColors.primaryButtonColor,
        backgroundColor: AppColors.secondaryButtonColor,
        onRefresh: () async {
          getIt<EventDetailBloc>().getEventDetail(widget.id ?? 0);
        },
        child: StreamBuilder<BlocState<EventResponse>>(
          initialData: const BlocState.loading(),
          stream: getIt<EventDetailBloc>().getEventDetailStream,
          builder: (context, snapshot) {
            final state = snapshot.data!;

            return state.when(
              success: (success) {
                final data = success as EventResponse;
                final isMyEvent = data.userId == getIt<EventDetailBloc>().userId;
                return CustomScrollView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          EventDetailPhoto(imagePath: data.imagePath ?? ''),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 50,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const EventDetailNavBar(),
                                _editButton(
                                  isHidden: !isMyEvent,
                                  eventResponse: data,
                                ),
                              ],
                            ),
                          ),
                          EventDetailTitle(title: data.title ?? ''),
                          EventDetailFestiVal(
                            category: data.categories?.first.first,
                          ),
                        ],
                      ),
                    ),
                    EventDetaiInfo(data: data),
                    EventDetailAttending(
                      eventId: widget.id ?? 0,
                      rsvpId: data.rsvpId,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalSpacing,
                          vertical: kVerticalSpacing,
                        ),
                        child: data.tickets!.isNotEmpty &&
                                DateTime.now().isBefore(
                                    DateTime.fromMicrosecondsSinceEpoch(int.tryParse(data.startTime ?? '0')! * 1000000))
                            ? CommonButton(
                                color: AppColors.primaryButtonColor,
                                text: context.localize.t_buy,
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    enableDrag: true,
                                    isScrollControlled: false,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    context: context,
                                    builder: (_) => WBottomTicket(
                                      eventName: data.title,
                                      eventId: data.eventId,
                                      imageEvent: data.imagePath,
                                      userName: data.cultixUri?.split('/')[3] ?? '',
                                    ),
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: CommonTabbar(
                          pageCount: _pageCount,
                          backgroundColor: Colors.transparent,
                          pageController: _pageController,
                          tabBarController: _tabController,
                          currentIndex: _currentIndex,
                          tabbarItemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return CommonTabbarItem(
                                  index: index,
                                  currentIndex: _currentIndex,
                                  title: context.localize.t_main_info,
                                  hasIcon: false,
                                );
                              case 1:
                                return CommonTabbarItem(
                                  index: index,
                                  currentIndex: _currentIndex,
                                  title: context.localize.t_news_feed,
                                  hasIcon: false,
                                );
                              default:
                                return const SizedBox();
                            }
                          },
                          pageViewBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return EventMainInfo(
                                  data: data,
                                  iconMarker: _iconMarker,
                                );
                              case 1:
                                return EventDetailFeed(
                                  eventId: widget.id ?? 0,
                                  scrollController: _scrollController,
                                );
                              default:
                                return const SizedBox();
                            }
                          },
                          onTapItem: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () {
                return const Center(
                  child: LoadingWidget(),
                );
              },
              error: (error) {
                return ErrorSectionWidget(
                  errorMessage: error,
                  onRetryTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _editButton({
    required bool isHidden,
    required EventResponse eventResponse,
  }) {
    if (isHidden) return Container();
    return TextButton(
      onPressed: () async {
        final result = await Navigator.of(context).pushNamed(
          AppRoute.routeCreateEvent,
          arguments: eventResponse,
        );
        if (result != null) {
          getIt<EventDetailBloc>().displayEventDetail(result as EventResponse);
        }
      },
      child: Text(context.localize.t_edit),
    );
  }
}
