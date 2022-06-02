import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/features/universal_search/universal_seach_bloc.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_result_post_item_widget.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_results_page.dart';
import 'package:audio_cult/app/features/universal_search/universal_search_result_item_widget.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/debouncer.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar.dart';
import 'package:audio_cult/w_components/tabbars/common_tabbar_item.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
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
  final _searchTextFieldFocusNode = FocusNode();
  final _pageController = PageController();
  final _searchKeywordOnChangeDebouncer = Debouncer(milliseconds: 500);
  var _currentIndex = UniversalSearchView.all.index;

  final _searchTextFieldController = TextEditingController();

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

    _searchTextFieldController.addListener(() {
      _searchKeywordOnChangeDebouncer.run(() {
        _bloc.keywordOnChange(_searchTextFieldController.text);
      });
    });

    _bloc.searchStream.listen((search) {
      final keyword = search.item1;
      final searchView = search.item2;
      observeSearchOnChange(keyword: keyword, searchView: searchView ?? UniversalSearchView.all);
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
          child: Column(
            children: [
              Container(height: 12, color: AppColors.secondaryButtonColor),
              _searchBar(),
              Container(height: 12, color: AppColors.secondaryButtonColor),
              Expanded(child: _body()),
            ],
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
      child: _searchTextField(),
    );
  }

  Widget _searchTextField() {
    return Stack(
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
              Flexible(
                child: TextField(
                  focusNode: _searchTextFieldFocusNode,
                  controller: _searchTextFieldController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: context.l10n.t_search,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: _clearTextSearchButton(),
              ),
              _cancelButton(),
            ],
          ),
        )
      ],
    );
  }

  Widget _cancelButton() {
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

  Widget _clearTextSearchButton() {
    return IconButton(
      onPressed: _searchTextFieldController.clear,
      icon: SvgPicture.asset(
        AppAssets.icClear,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _body() {
    return CommonTabbar(
      pageCount: UniversalSearchViewExtension.total,
      pageController: _pageController,
      tabBarController: _tabController,
      currentIndex: _currentIndex,
      tabbarItemBuilder: (context, index) {
        final searchView = UniversalSearchViewExtension.init(index);
        return _tabbarItemBuilder(searchView);
      },
      pageViewBuilder: (context, index) {
        final searchView = UniversalSearchViewExtension.init(index);
        return _tabbarPageViewBuilder(searchView);
      },
      onTapItem: (index) {
        setState(() {
          _bloc.searchViewOnChange(UniversalSearchViewExtension.init(index));
          _currentIndex = index;
        });
      },
      onPageChanged: (index) {
        _bloc.searchViewOnChange(UniversalSearchViewExtension.init(index));
        setState(() => _currentIndex = index);
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

  Widget _tabbarPageViewBuilder(UniversalSearchView searchView) {
    switch (searchView) {
      case UniversalSearchView.all:
        return UniversalSearchResultsPage(
          searchView,
          (_, item, ___) {
            return UniversalSearchResultItemWidget(
              imageUrl: item.userImage ?? '',
              title: item.itemTitle ?? '',
              subtitle: item.itemName ?? '',
              onTap: () {
                // TODO: handle tap
              },
            );
          },
          key: _universalSearchAllKey,
        );
      case UniversalSearchView.video:
        return UniversalSearchResultsPage(
          searchView,
          (_, item, ___) {
            return UniversalSearchResultItemWidget(
              imageUrl: item.userImage ?? '',
              title: item.itemTitle ?? '',
              subtitle: item.itemName ?? '',
              onTap: () {
                // TODO: handle tap
              },
            );
          },
          key: _universalSearchVideosKey,
        );
      case UniversalSearchView.event:
        return UniversalSearchResultsPage(
          searchView,
          (_, item, ___) {
            return UniversalSearchResultItemWidget(
              imageUrl: item.userImage ?? '',
              title: item.itemTitle ?? '',
              subtitle: item.itemName ?? '',
              onTap: () {
                // TODO: handle tap
              },
            );
          },
          key: _universalSearchEventsKey,
        );
      case UniversalSearchView.song:
        return UniversalSearchResultsPage(
          searchView,
          (_, item, ___) {
            return UniversalSearchResultItemWidget(
              imageUrl: item.userImage ?? '',
              title: item.itemTitle ?? '',
              subtitle: item.itemName ?? '',
              onTap: () {
                // TODO: handle tap
              },
            );
          },
          key: _universalSearchSongsKey,
        );
      case UniversalSearchView.photo:
        return UniversalSearchResultsPage(
          searchView,
          (_, item, ___) {
            return UniversalSearchResultItemWidget(
              imageUrl: item.userImage ?? '',
              title: item.itemTitle ?? '',
              subtitle: item.itemName ?? '',
              onTap: () {
                // TODO: handle tap
              },
            );
          },
          key: _universalSearchPhotosKey,
        );
      case UniversalSearchView.rssfeed:
        return UniversalSearchResultsPage(
          searchView,
          (_, item, ___) {
            return UniversalSearchResultPostItemWidget(
              avatarUrl: item.userImage ?? '',
              imageUrl: item.itemPhoto ?? '',
              content: item.itemTitle ?? '',
            );
          },
          key: _universalSearchRssfeedsKey,
        );
      case UniversalSearchView.page:
        return UniversalSearchResultsPage(
          searchView,
          (_, item, ___) {
            return UniversalSearchResultItemWidget(
              imageUrl: item.userImage ?? '',
              title: item.itemTitle ?? '',
              subtitle: item.itemName ?? '',
              onTap: () {
                // TODO: handle tap
              },
            );
          },
          key: _universalSearchPagesKey,
        );
    }
  }
}
