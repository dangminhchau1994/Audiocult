import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_icon_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

import '../../../w_components/dialogs/app_dialog.dart';
import '../../base/pair.dart';
import '../../data_source/models/responses/profile_data.dart';
import '../../utils/constants/app_colors.dart';
import 'profile_bloc.dart';

class MySliverAppBar extends StatefulWidget {
  final ScrollController? controller;
  final TabController? tabController;
  final ProfileData? profile;
  final Function(XFile image)? onPicKImage;
  const MySliverAppBar({Key? key, this.controller, this.tabController, this.profile, this.onPicKImage})
      : super(key: key);

  @override
  State<MySliverAppBar> createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar> {
  bool isEnd = false;
  double offset = 0;
  double bottomPadding = 24;
  ScrollController? _scrollController;
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _scrollController = widget.controller;
    } else {
      _scrollController = ScrollController();
    }
    _scrollController!.addListener(() {
      if (_scrollController!.offset >= 0 || _scrollController!.offset <= 312) {
        setState(() {
          offset = _scrollController!.offset;
        });
      }
      if (_scrollController!.offset > 350) {
        setState(() {
          isEnd = true;
        });
      } else {
        setState(() {
          isEnd = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FlexibleHeaderDelegate(
        backgroundColor: Colors.transparent,
        statusBarHeight: MediaQuery.of(context).padding.top,
        expandedHeight: 500,
        collapsedElevation: 0,
        collapsedHeight: 200,
        background: Container(
            color: AppColors.ebonyClay,
            padding: EdgeInsets.only(bottom: 312 - (offset * 0.7) >= 102 ? 312 - (offset * 0.7) : 102),
            child: CommonImageNetWork(
              imagePath: widget.profile?.coverPhoto ?? '',
            )),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppColors.activeLabelItem, borderRadius: BorderRadius.circular(32)),
            child: Text(
              widget.profile?.title ?? '',
              style: context.bodyTextStyle()?.copyWith(color: AppColors.mainColor, fontWeight: FontWeight.w700),
            ),
          )
        ],
        children: [
          FlexibleHeaderItem(
            expandedPadding: const EdgeInsets.only(
              bottom: 206,
            ),
            collapsedMargin: const EdgeInsets.only(top: 16),
            collapsedPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 64),
            expandedAlignment: Alignment.bottomCenter,
            collapsedAlignment: Alignment.bottomLeft,
            expandedMargin: const EdgeInsets.only(bottom: 24),
            child: Stack(
              children: [
                SizedBox(
                    width: (200 - offset * 0.5) > 90 ? 200 - offset * 0.5 : 90,
                    height: (200 - offset * 0.5) > 90 ? 200 - offset * 0.5 : 90,
                    child:
                        //   ClipRRect(
                        //     borderRadius: BorderRadius.circular(1000),
                        //     child: CommonImageNetWork(
                        //       imagePath: widget.profile?.userImage ?? '',
                        //     ),
                        //   ),
                        // ),
                        StreamBuilder<String>(
                            initialData: widget.profile?.userImage,
                            stream: Provider.of<ProfileBloc>(context, listen: false).uploadAvatarStream,
                            builder: (context, snapshot) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: AppColors.mainColor,
                                    backgroundImage: NetworkImage(snapshot.data ?? ''),
                                  ));
                            })),
                if (_scrollController!.offset == 0)
                  if (widget.profile?.userId == locator.get<PrefProvider>().currentUserId)
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: WButtonInkwell(
                        onPressed: () {
                          AppDialog.showSelectionBottomSheet(
                            context,
                            listSelection: [
                              Pair(
                                Pair(
                                  0,
                                  Container(),
                                ),
                                context.l10n.t_take_picture,
                              ),
                              Pair(
                                Pair(
                                  1,
                                  Container(),
                                ),
                                context.l10n.t_choose_gallery,
                              ),
                            ],
                            onTap: (index) async {
                              Navigator.pop(context);
                              final _picker = ImagePicker();
                              // Pick an image
                              final image = await _picker.pickImage(
                                  source: index == 0 ? ImageSource.camera : ImageSource.gallery);
                              if (image != null) {
                                widget.onPicKImage?.call(image);
                              }
                            },
                          );
                        },
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.inputFillColor),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(AppAssets.iconCamera),
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink()
              ],
            ),
          ),
          FlexibleTextItem(
            expandedPadding: EdgeInsets.symmetric(vertical: 169 + bottomPadding),
            collapsedPadding: const EdgeInsets.symmetric(horizontal: 108, vertical: 72),
            collapsedStyle: const TextStyle(color: Colors.white, fontSize: 16),
            expandedStyle: const TextStyle(color: Colors.white, fontSize: 26),
            text: widget.profile?.fullName ?? '',
            expandedAlignment: Alignment.bottomCenter,
            collapsedAlignment: Alignment.bottomLeft,
          ),
          FlexibleHeaderItem(
            options: const [HeaderItemOptions.hide],
            expandedPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 146 + bottomPadding),
            collapsedPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            expandedAlignment: Alignment.bottomCenter,
            collapsedAlignment: Alignment.bottomLeft,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center, children: [Text(widget.profile?.locationString ?? '')]),
          ),
          FlexibleHeaderItem(
            options: const [HeaderItemOptions.hide],
            expandedPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 102 + bottomPadding),
            collapsedPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            expandedAlignment: Alignment.bottomCenter,
            collapsedAlignment: Alignment.bottomLeft,
            expandedMargin: const EdgeInsets.only(bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${widget.profile?.totalSubscribers ?? 0} subscribers'),
                const SizedBox(
                  width: kHorizontalSpacing,
                ),
                Text('${widget.profile?.totalSubscriptions ?? 0} subscribed'),
              ],
            ),
          ),
          FlexibleHeaderItem(
            options: const [HeaderItemOptions.hide],
            expandedPadding: EdgeInsets.only(bottom: 56 + bottomPadding),
            expandedAlignment: Alignment.bottomCenter,
            collapsedAlignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonIconButton(
                  icon: SvgPicture.asset(
                    AppAssets.unsubscribedUserIcon,
                    color: Colors.white,
                  ),
                  width: 169,
                  text: context.l10n.t_subscribed,
                  color: AppColors.inputFillColor,
                  onTap: () {},
                ),
                const SizedBox(
                  width: 16,
                ),
                if (widget.profile?.userId == locator.get<PrefProvider>().currentUserId)
                  CommonIconButton(
                    icon: SvgPicture.asset(
                      AppAssets.edit,
                      color: Colors.white,
                    ),
                    text: context.l10n.t_edit_page,
                    width: 169,
                    color: AppColors.inputFillColor,
                    onTap: () {},
                  )
                else
                  CommonIconButton(
                    icon: SvgPicture.asset(
                      AppAssets.messageIcon,
                      color: Colors.white,
                    ),
                    text: context.l10n.t_message,
                    width: 169,
                    color: AppColors.inputFillColor,
                    onTap: () {},
                  )
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                  color: AppColors.inputFillColor,
                  height: 1,
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 8,
                ),
                TabBar(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: widget.tabController,
                  isScrollable: true,
                  onTap: (i) {
                    setState(() {
                      _currentIndex = i;
                    });
                  },
                  tabs: <Widget>[
                    Tab(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              AppAssets.postIcon,
                              color: _currentIndex == 0 ? AppColors.activeLabelItem : Colors.white,
                            ),
                          ),
                          Text(context.l10n.t_post)
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              AppAssets.iconInfo,
                              width: 24,
                              color: _currentIndex == 1 ? AppColors.activeLabelItem : Colors.white,
                            ),
                          ),
                          Text(context.l10n.t_about)
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              AppAssets.photo,
                              width: 20,
                              color: _currentIndex == 2 ? AppColors.activeLabelItem : Colors.white,
                            ),
                          ),
                          Text(context.l10n.t_videos)
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              AppAssets.musicIcon,
                              color: _currentIndex == 3 ? AppColors.activeLabelItem : Colors.white,
                            ),
                          ),
                          Text(context.l10n.t_music)
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              AppAssets.eventIcon,
                              color: _currentIndex == 4 ? AppColors.activeLabelItem : Colors.white,
                            ),
                          ),
                          Text(context.l10n.t_events)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
