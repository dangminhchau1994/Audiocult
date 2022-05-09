import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/features/atlas_filter/atlas_filter_provider.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FilterAtlasScreen extends StatefulWidget {
  const FilterAtlasScreen({Key? key}) : super(key: key);

  @override
  State<FilterAtlasScreen> createState() => _FilterAtlasScreenState();
}

class _FilterAtlasScreenState extends State<FilterAtlasScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AtlasFilterProvider>().getAllUserGroups();
    context.read<AtlasFilterProvider>().getAllMusicGenres();
    context.read<AtlasFilterProvider>().getAllCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.l10n.t_filter,
        actions: [
          TextButton(
            onPressed: () {
              context.read<AtlasFilterProvider>().clearFilter();
            },
            child: Text(context.l10n.t_clear_filter),
          ),
        ],
      ),
      body: WKeyboardDismiss(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: _userGroupMenuWidget(),
                ),
                _categoryMenuWidget(),
                Divider(
                  thickness: 1,
                  color: AppColors.deepTeal,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: _countriesMenuWidget(),
                ),
                Divider(
                  thickness: 1,
                  color: AppColors.deepTeal,
                ),
                _musicGenreContainer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: _filterButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userGroupMenuWidget() {
    return Selector<AtlasFilterProvider, bool>(
      selector: (_, provider) => provider.userGroupIsLoading,
      builder: (_, isInProcess, ___) {
        if (isInProcess) {
          return const LoadingWidget();
        }
        return Selector<AtlasFilterProvider, List<SelectMenuModel>>(
          shouldRebuild: (list1, list2) => list1 != list2,
          selector: (_, provider) => provider.userGroupOptions ?? [],
          builder: (_, options, __) {
            return _dropdownWidget(
              context.l10n.t_choose_role,
              options,
              options.firstWhereOrNull((element) => element.isSelected == true),
              context.read<AtlasFilterProvider>().selectUserGroup,
              () {},
            );
          },
        );
      },
    );
  }

  Widget _categoryMenuWidget() {
    return Selector<AtlasFilterProvider, List<SelectMenuModel>>(
      shouldRebuild: (list1, list2) => list1 != list2,
      selector: (_, provider) => provider.subCategoryOptions ?? [],
      builder: (_, options, __) {
        if (options.isEmpty) {
          return Container();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: _dropdownWidget(
            context.l10n.t_choose_category,
            options,
            options.firstWhereOrNull((element) => element.isSelected == true),
            context.read<AtlasFilterProvider>().selectSubCategory,
            () {},
          ),
        );
      },
    );
  }

  Widget _countriesMenuWidget() {
    return Selector<AtlasFilterProvider, bool>(
      selector: (_, provider) => provider.countriesIsLoading,
      builder: (_, isInProcess, ___) {
        if (isInProcess) {
          return const LoadingWidget();
        }
        return Selector<AtlasFilterProvider, List<SelectMenuModel>>(
          shouldRebuild: (list1, list2) => list1 != list2,
          selector: (_, provider) => provider.countryOptions ?? [],
          builder: (_, options, __) {
            return _dropdownWidget(
              context.l10n.t_choose_country,
              options,
              options.firstWhereOrNull((element) => element.isSelected == true),
              context.read<AtlasFilterProvider>().selectCountry,
              () {},
            );
          },
        );
      },
    );
  }

  Widget _dropdownWidget(
    String? title,
    List<SelectMenuModel>? options,
    SelectMenuModel? selectedOption,
    Function(SelectMenuModel?) onChanged,
    Function() onTap,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.inputFillColor,
        border: Border.all(color: AppColors.outlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              title ?? '',
              style: context.title1TextStyle()?.copyWith(color: AppColors.pealSky),
            ),
          ),
          if (options?.isNotEmpty != true)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(context.l10n.t_no_data),
              ),
            )
          else
            CommonDropdown(
              isBorderVisible: false,
              selection: selectedOption,
              onChanged: (value) => onChanged(value),
              onTap: onTap,
              data: options,
              hint: '',
            ),
        ],
      ),
    );
  }

  Widget _musicGenreContainer() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            '${context.l10n.t_music_genre}:',
            style: context.bodyTextStyle()?.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          _musicGenreGridWidget(),
        ],
      ),
    );
  }

  Widget _musicGenreGridWidget() {
    return Selector<AtlasFilterProvider, bool>(
      selector: (_, provider) => provider.musicGenresIsLoading,
      builder: (_, isLoading, __) {
        if (isLoading) {
          return const LoadingWidget();
        }
        return Selector<AtlasFilterProvider, List<Genre>>(
          shouldRebuild: (list1, list2) => list1 != list2,
          selector: (_, provider) => provider.musicGenres ?? [],
          builder: (_, genres, __) {
            if (genres.isEmpty) {
              return Center(child: Text(context.l10n.t_no_data));
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: genres.length,
              itemBuilder: (context, index) => _musicGenreOptionWidget(genres[index]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3,
              ),
            );
          },
        );
      },
    );
  }

  Widget _musicGenreOptionWidget(Genre genre) {
    return InkWell(
      onTap: () => context.read<AtlasFilterProvider>().tapMusicGenre(genre),
      child: Row(
        children: [
          SvgPicture.asset(
            (genre.isSelected ?? false) ? AppAssets.squareCheckedIcon : AppAssets.squareUncheckedIcon,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${genre.name}',
              style: context.body1TextStyle()?.copyWith(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton() {
    return CommonButton(
      color: AppColors.activeLabelItem,
      text: context.l10n.t_filter,
      onTap: () {
        final request = context.read<AtlasFilterProvider>().getFilterAtlasUsers();
        if (request == null) return;
        Navigator.pushNamed(
          context,
          AppRoute.routeAtlasFilterResult,
          arguments: request,
        );
      },
    );
  }
}
