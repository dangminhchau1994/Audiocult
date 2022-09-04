import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/data_source/models/responses/video_data.dart';
import 'package:audio_cult/app/features/player_widgets/player_screen.dart';
import 'package:audio_cult/app/features/profile/profile_screen.dart';
import 'package:audio_cult/app/features/universal_search/universal_seach_bloc.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_result_item_widget.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_results_page.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/di/bloc_locator.dart';

import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UniversalSearchScreen extends StatefulWidget {
  const UniversalSearchScreen({Key? key}) : super(key: key);

  @override
  State<UniversalSearchScreen> createState() => _UniversalSearchScreenState();
}

class _UniversalSearchScreenState extends State<UniversalSearchScreen> {
  final _bloc = getIt.get<UniversalSearchBloc>();
  final _tabController = CustomTabBarController();
  final _pageController = PageController();
  var _currentIndex = UniversalSearchView.all.index;
  var _listPages = <UniversalSearchResultsPage>[];
  var _searchText = '';
  final _universalSearchAllKey = GlobalKey<UniversalSearchResultsPageState>();
  final _universalSearchVideosKey = GlobalKey<UniversalSearchResultsPageState>();
  final _universalSearchPhotosKey = GlobalKey<UniversalSearchResultsPageState>();
  final _universalSearchSongsKey = GlobalKey<UniversalSearchResultsPageState>();
  final _universalSearchEventsKey = GlobalKey<UniversalSearchResultsPageState>();
  final _universalSearchPagesKey = GlobalKey<UniversalSearchResultsPageState>();
  final _universalSearchRssfeedsKey = GlobalKey<UniversalSearchResultsPageState>();

  @override
  void initState() {
    super.initState();
    _initListPages();
    _bloc.searchStream.listen((search) {
      final keyword = search.item1;
      final searchView = search.item2;
      observeSearchOnChange(keyword: keyword, searchView: searchView ?? UniversalSearchView.all);
    });

    _bloc.loadSongDetails.listen((event) {
      event.when(
        success: (details) async {
          final song = details as Song;
          await Navigator.pushNamed(
            context,
            AppRoute.routePlayerScreen,
            arguments: PlayerScreen.createArguments(
              listSong: [song],
              index: 0,
            ),
          );
        },
        loading: Container.new,
        error: (e) {
          ToastUtility.showError(context: context, message: e);
        },
      );
    });
  }

  void observeSearchOnChange({required String keyword, required UniversalSearchView searchView}) {
    switch (searchView) {
      case UniversalSearchView.all:
        _universalSearchAllKey.currentState?.searchKeywordOnChange(keyword);
        break;
      case UniversalSearchView.video:
        _universalSearchVideosKey.currentState?.searchKeywordOnChange(keyword);
        break;
      case UniversalSearchView.event:
        _universalSearchEventsKey.currentState?.searchKeywordOnChange(keyword);
        break;
      case UniversalSearchView.song:
        _universalSearchSongsKey.currentState?.searchKeywordOnChange(keyword);
        break;
      case UniversalSearchView.photo:
        _universalSearchPhotosKey.currentState?.searchKeywordOnChange(keyword);
        break;
      case UniversalSearchView.rssfeed:
        _universalSearchRssfeedsKey.currentState?.searchKeywordOnChange(keyword);
        break;
      case UniversalSearchView.page:
        _universalSearchPagesKey.currentState?.searchKeywordOnChange(keyword);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: context.localize.t_search),
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: WKeyboardDismiss(
          child: BlocHandle(
            bloc: _bloc,
            child: Column(
              children: [
                _searchBar(),
                Container(height: 12, color: AppColors.secondaryButtonColor),
                Expanded(child: _bodyWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).pushNamed(
          AppRoute.routeSearchSuggestion,
          arguments: _searchText,
        );
        if (result != null) {
          setState(() {
            _searchText = result as String;
            _bloc.searchTextOnChange(_searchText);
            _bloc.startSearch(_searchText);
          });
        }
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 12, right: 12),
        color: AppColors.secondaryButtonColor,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.mainColor,
          ),
          padding: const EdgeInsets.only(top: 1),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: SvgPicture.asset(AppAssets.whiteSearchIcon),
              ),
              const SizedBox(width: 12),
              Expanded(child: _searchTextFieldWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchTextFieldWidget() {
    return Text(
      _searchText,
      textAlign: TextAlign.left,
      style: context.body1TextStyle(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _bodyWidget() {
    return CommonTabbar(
      pageCount: UniversalSearchViewExtension.total,
      pageController: _pageController,
      tabBarController: _tabController,
      currentIndex: _currentIndex,
      tabbarItemBuilder: (context, index) {
        final searchView = UniversalSearchViewExtension.init(index);
        return _tabbarItemBuilder(searchView);
      },
      pageViewBuilder: (context, index) => _listPages[index],
      onTapItem: (index) {
        setState(() {
          _currentIndex = index;
          final searchView = UniversalSearchViewExtension.init(index);
          _bloc.searchViewOnChange(searchView);
        });
      },
    );
  }

  Widget _tabbarItemBuilder(UniversalSearchView searchView) {
    switch (searchView) {
      case UniversalSearchView.all:
        return CommonTabbarItem(
          index: UniversalSearchView.all.index,
          currentIndex: _currentIndex,
          title: context.localize.t_all,
          hasIcon: false,
        );
      case UniversalSearchView.video:
        return CommonTabbarItem(
          index: UniversalSearchView.video.index,
          title: context.localize.t_videos,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.event:
        return CommonTabbarItem(
          index: UniversalSearchView.event.index,
          title: context.localize.t_events,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.song:
        return CommonTabbarItem(
          index: UniversalSearchView.song.index,
          title: context.localize.t_songs,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.photo:
        return CommonTabbarItem(
          index: UniversalSearchView.photo.index,
          title: context.localize.t_photos,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.rssfeed:
        return CommonTabbarItem(
          index: UniversalSearchView.rssfeed.index,
          title: context.localize.t_rssfeed,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.page:
        return CommonTabbarItem(
          index: UniversalSearchView.page.index,
          title: context.localize.t_pages,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
    }
  }

  void _initListPages() {
    _listPages = [
      UniversalSearchResultsPage(
        UniversalSearchView.all,
        (_, item, ___) {
          return UniversalSearchResultItemWidget(
            item,
            queryString: _searchText,
            onTap: () => _navigateToDetailsScreen(item),
          );
        },
        key: _universalSearchAllKey,
        screenOnLaunch: () => _bloc.searchViewOnChange(UniversalSearchView.all),
      ),
      UniversalSearchResultsPage(
        UniversalSearchView.video,
        (_, item, ___) {
          return UniversalSearchResultItemWidget(
            item,
            queryString: _searchText,
            onTap: () => _navigateToDetailsScreen(item),
          );
        },
        key: _universalSearchVideosKey,
        screenOnLaunch: () => _bloc.searchViewOnChange(UniversalSearchView.video),
      ),
      UniversalSearchResultsPage(
        UniversalSearchView.event,
        (_, item, ___) {
          return UniversalSearchResultItemWidget(
            item,
            queryString: _searchText,
            onTap: () => _navigateToDetailsScreen(item),
          );
        },
        key: _universalSearchEventsKey,
        screenOnLaunch: () => _bloc.searchViewOnChange(UniversalSearchView.event),
      ),
      UniversalSearchResultsPage(
        UniversalSearchView.song,
        (_, item, ___) {
          return UniversalSearchResultItemWidget(
            item,
            queryString: _searchText,
            onTap: () => _navigateToDetailsScreen(item),
          );
        },
        key: _universalSearchSongsKey,
        screenOnLaunch: () => _bloc.searchViewOnChange(UniversalSearchView.song),
      ),
      UniversalSearchResultsPage(
        UniversalSearchView.photo,
        (_, item, ___) {
          return UniversalSearchResultItemWidget(
            item,
            queryString: _searchText,
            onTap: () => _navigateToDetailsScreen(item),
          );
        },
        key: _universalSearchPhotosKey,
        screenOnLaunch: () => _bloc.searchViewOnChange(UniversalSearchView.photo),
      ),
      UniversalSearchResultsPage(
        UniversalSearchView.rssfeed,
        (_, item, ___) {
          return UniversalSearchResultItemWidget(
            item,
            queryString: _searchText,
            onTap: () => _navigateToDetailsScreen(item),
          );
        },
        key: _universalSearchRssfeedsKey,
        screenOnLaunch: () => _bloc.searchViewOnChange(UniversalSearchView.rssfeed),
      ),
      UniversalSearchResultsPage(
        UniversalSearchView.page,
        (_, item, ___) {
          return UniversalSearchResultItemWidget(
            item,
            queryString: _searchText,
            onTap: () => _navigateToDetailsScreen(item),
          );
        },
        key: _universalSearchPagesKey,
        screenOnLaunch: () => _bloc.searchViewOnChange(UniversalSearchView.page),
      )
    ];
  }

  void _navigateToDetailsScreen(UniversalSearchItem searchItem) {
    final itemType = UniversalSearchViewExtension.initWithType(searchItem.itemTypeId ?? '');
    switch (itemType) {
      case UniversalSearchView.video:
        if (searchItem.itemUrl?.isNotEmpty != true) return;

        _showVideoPlayer(searchItem.itemUrl!);
        break;
      case UniversalSearchView.event:
        final arguments = {'event_id': int.parse(searchItem.itemId ?? '0')};
        Navigator.pushNamed(context, AppRoute.routeEventDetail, arguments: arguments);
        break;
      case UniversalSearchView.song:
        _bloc.getSongDetails(searchItem.itemId ?? '');
        break;
      case UniversalSearchView.photo:
        // ignore: invariant_booleans
        if (searchItem.itemUrl?.isNotEmpty != true) return;
        _showImageScreen(searchItem.itemUrl!);
        break;
      case UniversalSearchView.rssfeed:
        break;
      case UniversalSearchView.page:
        Navigator.pushNamed(
          context,
          AppRoute.routeProfile,
          arguments: ProfileScreen.createArguments(id: searchItem.itemId ?? ''),
        );
        break;
      case UniversalSearchView.all:
        break;
    }
  }

  void _showImageScreen(String imageUrl) {
    showModalBottomSheet<void>(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return CachedNetworkImage(
          errorWidget: (_, error, __) => const Icon(Icons.error),
          imageUrl: imageUrl,
          placeholder: (context, url) => LoadingWidget(
            backgroundColor: AppColors.mainColor,
          ),
          imageBuilder: (_, imageProvider) {
            return Container(
              padding: const EdgeInsets.only(top: 50, right: 12),
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider),
                color: AppColors.mainColor,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    AppAssets.icClear,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showVideoPlayer(String url) {
    final isVideoFromYoutube = url.toLowerCase().contains('youtube');
    final video = Video();
    if (isVideoFromYoutube) {
      video.videoUrl = url;
    } else {
      video.destination = url;
    }
    Navigator.pushNamed(
      context,
      AppRoute.routeVideoPlayer,
      arguments: {'data': video},
    );
  }
}
