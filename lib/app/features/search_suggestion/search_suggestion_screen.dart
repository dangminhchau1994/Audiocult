import 'package:audio_cult/app/features/search_suggestion/search_suggestion_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchSuggestionScreen extends StatefulWidget {
  const SearchSuggestionScreen({Key? key}) : super(key: key);

  @override
  State<SearchSuggestionScreen> createState() => _SearchSuggestionScreenState();
}

class _SearchSuggestionScreenState extends State<SearchSuggestionScreen> {
  final _bloc = getIt.get<SearchSuggestionBloc>();

  final _searchTextFieldFocusNode = FocusNode();
  final _searchTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTextFieldController.addListener(() {
      _bloc.searchTextOnChange(_searchTextFieldController.text);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      const Duration(milliseconds: 600),
      _searchTextFieldFocusNode.requestFocus,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: AppColors.mainColor,
        child: Column(
          children: [
            _searchBar(),
            Expanded(child: _suggestionListWidget()),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(left: 12, right: 8, bottom: 8, top: 10),
      color: AppColors.secondaryButtonColor,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 82),
            child: Container(
              height: 60,
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
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _searchTextField(),
                )),
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

  Widget _searchTextField() {
    return TextField(
      onSubmitted: (string) {
        _bloc.search(string);
        Navigator.of(context).pop(string);
      },
      textInputAction: TextInputAction.search,
      controller: _searchTextFieldController,
      focusNode: _searchTextFieldFocusNode,
      decoration: const InputDecoration(border: InputBorder.none),
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

  Widget _suggestionListWidget() {
    return StreamBuilder<List<String>>(
        initialData: const [],
        stream: _bloc.searchHistoryStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final searchHistory = snapshot.data ?? [];
            return ListView.separated(
              separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.borderOutline),
              itemCount: searchHistory.length,
              itemBuilder: (_, index) {
                return ListTile(
                  onTap: () {
                    _bloc.search(searchHistory[index]);
                    _searchTextFieldController.text = searchHistory[index];
                    _searchTextFieldController.selection =
                        TextSelection.fromPosition(TextPosition(offset: _searchTextFieldController.text.length));
                  },
                  title: Text(searchHistory[index]),
                );
              },
            );
          }
          return Container();
        });
  }
}
