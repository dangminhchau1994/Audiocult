import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_category.dart';
import 'package:audio_cult/app/data_source/models/responses/country_response.dart';
import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/data_source/models/page_template_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/utils/constants/gender_enum.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:collection/collection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tuple/tuple.dart';

class PageTemplateBloc extends BaseBloc {
  final AppRepository _appRepo;
  final PrefProvider _prefProvider;

  Country? _selectedCountry;
  City? _selectedCity;
  AtlasCategory? _selectedCategory;
  Genre? _selectedMusicGenre;
  LatLng? _latlng;
  PageTemplateResponse? _userProfile;

  List<Country>? _countries;
  List<City>? _cities;
  List<AtlasCategory>? _allPageTemplates;
  List<Genre>? _genres;

  List<Country> get countries => _countries ?? [];
  List<City> get cities => _cities ?? [];
  List<AtlasCategory> get categories => _allPageTemplates ?? [];
  List<Genre> get genres => _genres ?? [];

  Country? get selectedCountry => _selectedCountry;
  City? get selectedCity => _selectedCity;
  AtlasCategory? get selectedCategory => _selectedCategory;
  Genre? get selectedMusicGenre => _selectedMusicGenre;

  final _loadCountriesStreamController = StreamController<BlocState<Tuple2<List<Country>, Country?>>>.broadcast();
  Stream<BlocState<Tuple2<List<Country>, Country?>>> get loadCountriesStream => _loadCountriesStreamController.stream;

  final _loadCategoriesStreamController =
      StreamController<BlocState<Tuple2<List<AtlasCategory>, AtlasCategory?>>>.broadcast();
  Stream<BlocState<Tuple2<List<AtlasCategory>, AtlasCategory?>>> get loadCategoriesStream =>
      _loadCategoriesStreamController.stream;

  final _loadMusicGenresStreamController = StreamController<BlocState<Tuple2<List<Genre>, Genre?>>>.broadcast();
  Stream<BlocState<Tuple2<List<Genre>, Genre?>>> get loadMusicGenresStream => _loadMusicGenresStreamController.stream;

  final _selectedGenderChanged = StreamController<Gender>.broadcast();
  Stream<Gender> get genderChangedStream => _selectedGenderChanged.stream;

  final _dateOfBirthChanged = StreamController<DateTime>.broadcast();
  Stream<DateTime> get dobChangedStream => _dateOfBirthChanged.stream;

  final _latLngChangeStreamController = StreamController<BlocState<LatLng?>>.broadcast();
  Stream<BlocState<LatLng?>> get latlngStream => _latLngChangeStreamController.stream;

  final _userProfileStreamController = StreamController<BlocState<PageTemplateResponse?>>.broadcast();
  Stream<BlocState<PageTemplateResponse?>> get userProfileStream => _userProfileStreamController.stream;

  List<Gender> get allGenders => [
        Gender.male,
        Gender.female,
        Gender.alien,
        Gender.panda,
        Gender.custom,
      ];

  PageTemplateBloc(this._appRepo, this._prefProvider);

  void loadUserProfile() async {
    final userId = _prefProvider.currentUserId;
    if (userId?.isNotEmpty == true) {
      final result = await _appRepo.getPageTemplateData(userId!);
      result.fold(
        (profile) {
          _userProfile = profile;
          loadAllCountries();
          loadAllPageTemplates();
          _userProfileStreamController.sink.add(BlocState.success(profile));
          selectGender(null);
        },
        (exception) {
          _userProfileStreamController.sink.add(BlocState.error(exception.toString()));
        },
      );
    }
  }

  void loadAllCountries() async {
    final result = await _appRepo.getAllCountries();
    result.fold((countries) {
      _countries = countries;
      _selectedCountry = _countries?.firstWhereOrNull((e) => e.countryISO == _userProfile?.countryISO);
      _loadCountriesStreamController.sink.add(BlocState.success(Tuple2(countries, _selectedCountry)));
    }, (exception) {
      _countries = [];
      _loadCountriesStreamController.sink.add(BlocState.error(exception.toString()));
    });
  }

  void loadAllPageTemplates() async {
    final result = await _appRepo.getAtlasCategories();
    result.fold((categories) {
      _allPageTemplates = categories;
      _loadCategoriesStreamController.sink.add(
        BlocState.success(
          Tuple2(
            _allPageTemplates ?? [],
            _allPageTemplates?.firstWhereOrNull(
              (element) => element.userGroupId == _userProfile?.userGroupId,
            ),
          ),
        ),
      );
    }, (exception) {
      _allPageTemplates = [];
      _loadCategoriesStreamController.sink.add(BlocState.error(exception.toString()));
    });
  }

  void selectCountry(SelectMenuModel option) async {
    _selectedCountry = _countries?.firstWhereOrNull((element) => element.name == option.title);
    _loadCountriesStreamController.sink.add(BlocState.success(Tuple2(_countries ?? [], _selectedCountry)));
    if (_cities?.isNotEmpty == true) {
      _selectedCity = _cities?.first;
    }
  }

  void selectGender(SelectMenuModel? option) {
    if (option != null) {
      _userProfile?.gender =
          allGenders.firstWhereOrNull((element) => element.name.toLowerCase() == option.title?.toLowerCase());
    } else {
      _userProfile?.gender = allGenders.firstWhereOrNull((element) => element == _userProfile?.gender);
    }
    _selectedGenderChanged.sink.add(_userProfile?.gender ?? Gender.none);
  }

  void selectDateOfBirth(DateTime dateTime) {
    _userProfile?.updateBirthday(dateTime);
    _userProfileStreamController.sink.add(BlocState.success(_userProfile));
  }

  void selectArtistCategory(SelectMenuModel option) {
    _selectedCategory = _allPageTemplates?.firstWhereOrNull((element) => element.title == option.title);
    _loadCategoriesStreamController.sink.add(BlocState.success(Tuple2(_allPageTemplates ?? [], _selectedCategory)));
  }

  void selectMusicGenre(SelectMenuModel option) {
    _selectedMusicGenre = _genres?.firstWhereOrNull((element) => element.name == option.title);
    _loadMusicGenresStreamController.sink.add(BlocState.success(Tuple2(_genres ?? [], _selectedMusicGenre)));
  }

  void pinLatLng(LatLng latlng) {
    _latlng = latlng;
    _latLngChangeStreamController.sink.add(BlocState.success(_latlng));
  }

  void multiSelectionFieldOnChanged({required PageTemplateCustomField field, required String title}) {
    final customField = _userProfile?.customFields
        ?.firstWhere((element) => element.fieldName?.toLowerCase() == field.fieldName?.toLowerCase());
    final updatedOption = customField?.options?.firstWhereOrNull((e) => e.value == title);
    if (customField?.getValues?.contains(updatedOption?.key) == true) {
      customField?.customValue?.remove(updatedOption?.key ?? '');
    } else {
      customField?.customValue?.add(updatedOption?.key ?? '');
    }
  }

  void singleSelectionFieldOnChanged({required PageTemplateCustomField field, required String? value}) {
    final customField = _userProfile?.customFields
        ?.firstWhere((element) => element.fieldName?.toLowerCase() == field.fieldName?.toLowerCase());
    customField?.value = value;
    _userProfileStreamController.sink.add(BlocState.success(_userProfile));
  }

  void textFieldOnChanged({required PageTemplateCustomField field, required String string}) {
    final customField = _userProfile?.customFields
        ?.firstWhere((element) => element.fieldName?.toLowerCase() == field.fieldName?.toLowerCase());
    customField?.value = string;
  }

  void radioOnChanged({required PageTemplateCustomField field, required SelectableOption selection}) {
    final customField = _userProfile?.customFields
        ?.firstWhere((element) => element.fieldName?.toLowerCase() == field.fieldName?.toLowerCase());
    if (customField?.options?.isNotEmpty == true) {
      final selectedItemIndex = customField!.options!.indexWhere((element) => element.selected == true);
      final newSelectedItemIndex =
          customField.options!.indexWhere((element) => element.value?.toLowerCase() == selection.value?.toLowerCase());
      customField.options![selectedItemIndex] = customField.options![selectedItemIndex]..selected = false;
      customField.options![newSelectedItemIndex] = customField.options![newSelectedItemIndex]..selected = true;
      _userProfileStreamController.sink.add(BlocState.success(_userProfile));
    }
  }
}
