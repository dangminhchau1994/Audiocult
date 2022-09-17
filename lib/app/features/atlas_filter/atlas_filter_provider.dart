import 'package:audio_cult/app/data_source/models/requests/filter_users_request.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_category.dart';
import 'package:audio_cult/app/data_source/models/responses/country_response.dart';
import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class AtlasFilterProvider extends ChangeNotifier {
  final AppRepository _appRepository;
  final _defaultSelectOption = SelectMenuModel(id: -1, title: '...', isSelected: true);
  String? _userId;
  String? _getSubscribed;
  List<Genre>? musicGenres;
  List<Country>? countries;
  List<AtlasCategory>? userGroups;
  List<AtlasSubCategory>? subCategories;
  List<SelectMenuModel>? countryOptions;
  List<SelectMenuModel>? userGroupOptions;
  List<SelectMenuModel>? subCategoryOptions;
  bool musicGenresIsLoading = false;
  bool countriesIsLoading = false;
  bool userGroupIsLoading = false;

  AtlasFilterProvider(this._appRepository, {FilterUsersRequest? filterRequest}) {
    _userId = filterRequest?.userId;
    _getSubscribed = filterRequest?.getSubscribed;
  }

  // USER GROUP
  Future<void> getAllUserGroups() async {
    userGroupIsLoading = true;
    final result = await _appRepository.getAtlasCategories();
    result.fold(
      _handleGetUserGroupsSuccess,
      (error) {
        _handleGetUserGroupFail();
      },
    );
  }

  void _handleGetUserGroupsSuccess(List<AtlasCategory> userGroups) {
    userGroupIsLoading = false;
    this.userGroups = userGroups;
    userGroupOptions = userGroups.map((element) {
      return SelectMenuModel(id: int.parse(element.userGroupId ?? '0'), title: element.title);
    }).toList();
    userGroupOptions?.insert(
      0,
      SelectMenuModel()
        ..id = _defaultSelectOption.id
        ..title = _defaultSelectOption.title
        ..isSelected = _defaultSelectOption.isSelected,
    );
    notifyListeners();
  }

  void _handleGetUserGroupFail() {
    userGroupIsLoading = false;
    userGroupOptions = [];
    userGroups = [];
    notifyListeners();
  }

  void selectUserGroup(SelectMenuModel? option) {
    if (option == null) return;
    final previousSelectedOption = userGroupOptions?.firstWhereOrNull((element) => element.isSelected);
    previousSelectedOption?.isSelected = false;
    final index = userGroupOptions?.indexOf(option);
    if (index == null) return;
    userGroupOptions?[index].isSelected = true;
    userGroupOptions = userGroupOptions?.toList();
    _updateSubcategoryData();
    notifyListeners();
  }

  // SUB CATEGORY
  void _updateSubcategoryData() {
    final selectedOptionOfUserGroup = userGroupOptions?.firstWhereOrNull((element) => element.isSelected);
    final userGroup = userGroups?.firstWhereOrNull(
      (element) => element.userGroupId == selectedOptionOfUserGroup?.id.toString(),
    );
    subCategories = userGroup?.subCategories;
    subCategoryOptions = subCategories?.map((element) {
      return SelectMenuModel(id: int.parse(element.optionId ?? '0'), title: element.title);
    }).toList();
    subCategoryOptions?.insert(
      0,
      SelectMenuModel()
        ..id = _defaultSelectOption.id
        ..title = _defaultSelectOption.title
        ..isSelected = _defaultSelectOption.isSelected,
    );
  }

  void selectSubCategory(SelectMenuModel? option) {
    if (option == null) return;
    final previousSelectedOption = subCategoryOptions?.firstWhereOrNull((element) => element.isSelected);
    previousSelectedOption?.isSelected = false;
    final index = subCategoryOptions?.indexOf(option);
    if (index == null) return;
    subCategoryOptions?[index].isSelected = true;
    subCategoryOptions = subCategoryOptions?.toList();
    notifyListeners();
  }

  // MUSIC GENRES
  Future<void> getAllMusicGenres() async {
    musicGenresIsLoading = true;
    final result = await _appRepository.getGenres();
    result.fold(_handleGetMusicGenresSuccess, (error) {
      _handleGetMusicGenresFail();
    });
  }

  void _handleGetMusicGenresSuccess(List<Genre> genres) {
    musicGenres = genres;
    musicGenresIsLoading = false;
    notifyListeners();
  }

  void _handleGetMusicGenresFail() {
    musicGenres = [];
    musicGenresIsLoading = false;
    notifyListeners();
  }

  void tapMusicGenre(Genre genre) {
    final index = musicGenres?.indexOf(genre);
    if (index == null) return;
    musicGenres![index].isSelected = !(musicGenres![index].isSelected ?? false);
    musicGenres = musicGenres!.toList();
    notifyListeners();
  }

  // COUNTRIES
  void getAllCountries() async {
    countriesIsLoading = true;
    final result = await _appRepository.getAllCountries();
    result.fold(
      _handleGetCountriesSuccess,
      (error) {
        _handleGetCountriesFail();
      },
    );
  }

  void _handleGetCountriesSuccess(List<Country> countries) {
    countriesIsLoading = false;
    this.countries = countries;
    countryOptions = countries.mapIndexed((index, element) {
      return SelectMenuModel(id: index, title: element.name);
    }).toList();
    countryOptions?.insert(
      0,
      SelectMenuModel()
        ..id = _defaultSelectOption.id
        ..title = _defaultSelectOption.title
        ..isSelected = _defaultSelectOption.isSelected,
    );
    notifyListeners();
  }

  void _handleGetCountriesFail() {
    countriesIsLoading = false;
    countries = [];
    countryOptions = [];
    notifyListeners();
  }

  void selectCountry(SelectMenuModel? option) {
    if (option == null) return;
    final previousSelectedOption = countryOptions?.firstWhereOrNull((element) => element.isSelected);
    previousSelectedOption?.isSelected = false;

    final index = countryOptions?.indexOf(option);
    if (index == null) return;
    countryOptions?[index].isSelected = true;
    countryOptions = countryOptions?.toList();
    notifyListeners();
  }

  void clearFilter() {
    selectCountry(countryOptions?.first);
    selectUserGroup(userGroupOptions?.first);
    userGroupOptions = userGroupOptions?.toList();
    countryOptions = userGroupOptions?.toList();
    musicGenres?.forEach((element) {
      element.isSelected = false;
    });
    musicGenres = musicGenres?.toList();
    notifyListeners();
  }

  FilterUsersRequest? getFilterAtlasUsers() {
    if (countriesIsLoading || userGroupIsLoading || musicGenresIsLoading) {
      return null;
    }
    final selectedUserGroupOption = userGroupOptions?.firstWhereOrNull((element) => element.isSelected);
    final selectedOptionOfSubCategory = subCategoryOptions?.firstWhereOrNull((element) => element.isSelected);

    final selectedCountryOption = countryOptions?.firstWhereOrNull((element) => element.isSelected);
    final selectedCountry = countries
        ?.firstWhereOrNull((element) => element.name?.toLowerCase() == selectedCountryOption?.title?.toLowerCase());

    final selectedGenres = musicGenres?.where((e) => e.isSelected == true).toList();
    return FilterUsersRequest(
      groupId: (selectedUserGroupOption?.id ?? -1) < 0 ? null : selectedUserGroupOption?.id,
      categoryId: (selectedOptionOfSubCategory?.id ?? -1) < 0 ? null : selectedOptionOfSubCategory?.id,
      countryISO: selectedCountry?.countryISO,
      genreIds: selectedGenres?.map((e) => e.genreId ?? '-1').toList(),
      userId: _userId,
      getSubscribed: _getSubscribed,
    );
  }
}
