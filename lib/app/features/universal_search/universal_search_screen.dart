import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/data_source/models/responses/video_data.dart';
import 'package:audio_cult/app/features/player_widgets/player_screen.dart';
import 'package:audio_cult/app/features/universal_search/universal_seach_bloc.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_result_item_widget.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_results_page.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class UniversalSearchScreen extends StatefulWidget {
  const UniversalSearchScreen({Key? key}) : super(key: key);

  @override
  State<UniversalSearchScreen> createState() => _UniversalSearchScreenState();
}

class _UniversalSearchScreenState extends State<UniversalSearchScreen> {
  final _bloc = getIt.get<UniversalSearchBloc>();
  final _tabController = CustomTabBarController();
  final _searchTextFieldFocusNode = FocusNode();
  final _searchTextFieldController = TextEditingController();
  final _pageController = PageController();
  var _currentIndex = UniversalSearchView.all.index;
  var _listPages = <UniversalSearchResultsPage>[];
  final _suggestionsBoxController = SuggestionsBoxController();

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
    _searchTextFieldController.addListener(() {
      _bloc.searchTextOnChange(_searchTextFieldController.text);
    });
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
  void dispose() {
    _searchTextFieldFocusNode.dispose();
    _searchTextFieldController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _searchTextFieldFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: WKeyboardDismiss(
          child: BlocHandle(
            bloc: _bloc,
            child: Column(
              children: [
                Container(height: 12, color: AppColors.secondaryButtonColor),
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
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 12, right: 8),
      color: AppColors.secondaryButtonColor,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 82),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.mainColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SvgPicture.asset(AppAssets.whiteSearchIcon),
                ),
                const SizedBox(width: 12),
                Flexible(child: _searchTextFieldWidget()),
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: _clearSearchTextButton(),
                ),
                _cancelSearchButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _searchTextFieldWidget() {
    return TypeAheadField<String>(
      suggestionsBoxController: _suggestionsBoxController,
      getImmediateSuggestions: true,
      hideOnEmpty: true,
      hideOnLoading: true,
      hideOnError: true,
      debounceDuration: const Duration(milliseconds: 600),
      animationDuration: Duration.zero,
      textFieldConfiguration: TextFieldConfiguration(
        onSubmitted: _bloc.startSearch,
        textInputAction: TextInputAction.search,
        controller: _searchTextFieldController,
        autofocus: true,
        style: context.body1TextStyle(),
        decoration: InputDecoration(border: InputBorder.none, hintText: context.l10n.t_search),
      ),
      suggestionsCallback: (pattern) async => _bloc.getSearchHistory(),
      noItemsFoundBuilder: (context) => Container(),
      itemBuilder: (context, String suggestion) => _suggestionWidget(suggestion),
      onSuggestionSelected: (suggestion) {
        _searchTextFieldController.text = suggestion;
        _bloc.searchTextOnChange(_searchTextFieldController.text);
        _bloc.startSearch(suggestion);
      },
    );
  }

  Widget _suggestionWidget(String suggestion) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        border: const Border(
          left: BorderSide(color: Colors.white24),
          bottom: BorderSide(color: Colors.white24),
        ),
      ),
      child: ListTile(leading: Text(suggestion)),
    );
  }

  Widget _cancelSearchButton() {
    return SizedBox(
      width: 80,
      child: TextButton(
        onPressed: Navigator.of(context).pop,
        child: Text(
          context.l10n.t_cancel,
          style: context.buttonTextStyle(),
        ),
      ),
    );
  }

  Widget _clearSearchTextButton() {
    return StreamBuilder<String>(
      initialData: '',
      stream: _bloc.searchTextStream,
      builder: (_, string) {
        if (string.hasData) {
          return string.data!.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchTextFieldController.clear();
                    _bloc.searchTextOnChange('');
                  },
                  icon: SvgPicture.asset(AppAssets.icClear, fit: BoxFit.fill),
                )
              : Container();
        }
        return Container();
      },
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
          title: context.l10n.t_all,
          hasIcon: false,
        );
      case UniversalSearchView.video:
        return CommonTabbarItem(
          index: UniversalSearchView.video.index,
          title: context.l10n.t_videos,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.event:
        return CommonTabbarItem(
          index: UniversalSearchView.event.index,
          title: context.l10n.t_events,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.song:
        return CommonTabbarItem(
          index: UniversalSearchView.song.index,
          title: context.l10n.t_songs,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.photo:
        return CommonTabbarItem(
          index: UniversalSearchView.photo.index,
          title: context.l10n.t_photos,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.rssfeed:
        return CommonTabbarItem(
          index: UniversalSearchView.rssfeed.index,
          title: context.l10n.t_rssfeed,
          hasIcon: false,
          currentIndex: _currentIndex,
        );
      case UniversalSearchView.page:
        return CommonTabbarItem(
          index: UniversalSearchView.page.index,
          title: context.l10n.t_pages,
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
            queryString: _searchTextFieldController.text,
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
            queryString: _searchTextFieldController.text,
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
            queryString: _searchTextFieldController.text,
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
            queryString: _searchTextFieldController.text,
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
            queryString: _searchTextFieldController.text,
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
            queryString: _searchTextFieldController.text,
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
            queryString: _searchTextFieldController.text,
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
        Navigator.pushNamed(context, AppRoute.routeVideoPlayer, arguments: {
          'data': Video()
            ..destination =
                'https://staging-media.audiocult.net/file/video/2022/06/0376aeff25a26114406fd0c60dac7eeb.mp4'
        });
        break;
      case UniversalSearchView.event:
        final arguments = {'event_id': int.parse(searchItem.itemId ?? '0')};
        Navigator.pushNamed(context, AppRoute.routeEventDetail, arguments: arguments);
        break;
      case UniversalSearchView.song:
        _bloc.getSongDetails(searchItem.itemId ?? '');
        break;
      case UniversalSearchView.photo:
        break;
      case UniversalSearchView.rssfeed:
        break;
      case UniversalSearchView.page:
        break;
      case UniversalSearchView.all:
        // TODO: Handle this case.
        break;
    }
  }
}
