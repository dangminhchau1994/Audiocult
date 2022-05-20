import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/fcm/fcm_service.dart';
import 'package:audio_cult/app/features/atlas/atlas_screen.dart';
import 'package:audio_cult/app/features/audio_player/miniplayer.dart';
import 'package:audio_cult/app/features/main/main_bloc.dart';
import 'package:audio_cult/app/features/music/music_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/bottom_navigation_bar/common_bottom_bar.dart';
import 'package:audio_cult/w_components/menus/common_circular_menu.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../di/bloc_locator.dart';
import '../../../w_components/appbar/common_appbar.dart';
import '../../../w_components/dialogs/app_dialog.dart';
import '../../../w_components/images/no_image_available.dart';
import '../../../w_components/menus/common_fab_menu.dart';
import '../../base/pair.dart';
import '../../data_source/models/responses/profile_data.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_colors.dart';
import '../events/event_screen.dart';
import '../home/home_screen.dart';
import '../menu_settings/drawer/my_drawer.dart';
import '../music/my_album/upload_song/upload_song_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _pageController = PageController();
  final MainBloc _mainBloc = locator.get();
  ProfileData? _profileData;

  @override
  void initState() {
    super.initState();
    FCMService(context, locator.get()).askPermission();
    _mainBloc.getUserProfile();
    _mainBloc.profileStream.listen((event) {
      setState(() {
        _profileData = event;
      });
    });
  }

  List<Widget> _buildPages() {
    final pages = <Widget>[];
    pages.add(const HomeScreen());
    pages.add(const AtlasScreen());
    pages.add(const SizedBox());
    pages.add(const MusicScreen());
    pages.add(const EventScreen());
    return pages;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String getAppBarTitle(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return context.l10n.t_home;
      case 1:
        return context.l10n.t_atlas;
      case 3:
        return context.l10n.t_music;
      case 4:
        return context.l10n.t_events;
      default:
        return '';
    }
  }

  Widget _buildIcon(int currentIndex) {
    if (currentIndex == 0 || currentIndex == 1) {
      return SvgPicture.asset(
        AppAssets.messageIcon,
        fit: BoxFit.cover,
      );
    } else {
      return SvgPicture.asset(
        AppAssets.searchIcon,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: getIt.get<MainBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _drawerKey,
        drawerScrimColor: Colors.transparent,
        appBar: CommonAppBar(
          title: getAppBarTitle(_currentIndex),
          leading: GestureDetector(
            onTap: () {
              _drawerKey.currentState?.openDrawer();
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: CachedNetworkImage(
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const NoImageAvailable(),
                  imageUrl: _profileData != null ? _profileData!.userImage ?? '' : '',
                ),
              ),
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.inputFillColor,
                shape: BoxShape.circle,
              ),
              child: _buildIcon(_currentIndex),
            ),
            CommonFabMenu(
              onSearchTap: () {
                ToastUtility.showPending(
                  context: context,
                  message: context.l10n.t_feature_development,
                );
              },
              onNotificationTap: () {
                Navigator.pushNamed(context, AppRoute.routeNotification);
              },
              onCartTap: () {
                ToastUtility.showPending(
                  context: context,
                  message: context.l10n.t_feature_development,
                );
              },
            ),
          ],
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Drawer(
            backgroundColor: Colors.transparent,
            child: MyDrawer(),
          ),
        ),
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _buildPages(),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: CommonBottomBar(
                topWidget: const MiniPlayer(),
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  _pageController.jumpToPage(index);
                },
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.mainColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CommonCircularMenu(
          onMusicTap: () {
            AppDialog.showSelectionBottomSheet(
              context,
              listSelection: [
                Pair(
                  Pair(
                    0,
                    Container(),
                  ),
                  context.l10n.t_upload_song,
                ),
                Pair(
                  Pair(
                    1,
                    Container(),
                  ),
                  context.l10n.t_upload_album,
                ),
              ],
              onTap: (index) {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  AppRoute.routeUploadSong,
                  arguments: UploadSongScreen.createArguments(
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      isUploadSong: index == 0 ? true : false,
                      song: null,
                      album: null),
                );
              },
            );
          },
          onEventTap: () {
            Navigator.pushNamed(context, AppRoute.routeCreateEvent);
          },
          onPostTap: () {},
        ),
      ),
    );
  }
}
