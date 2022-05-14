import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_category.dart';
import 'package:audio_cult/app/data_source/models/responses/country_response.dart';
import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/data_source/models/responses/page_template_custom_field_response.dart';
import 'package:audio_cult/app/data_source/models/responses/page_template_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/utils/constants/gender_enum.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:collection/collection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tuple/tuple.dart';

class PageTemplateBloc extends BaseBloc {
  final AppRepository _appRepo;
  final PrefProvider _prefProvider;

  Genre? _selectedMusicGenre;
  PageTemplateResponse? _userProfile;

  List<Country>? _countries;
  List<City>? _cities;
  List<AtlasCategory>? _allPageTemplates;
  List<Genre>? _genres;
  List<PageTemplateCustomFieldConfig>? _customFieldConfigs;

  List<Country> get countries => _countries ?? [];
  List<City> get cities => _cities ?? [];
  List<AtlasCategory> get categories => _allPageTemplates ?? [];
  List<Genre> get genres => _genres ?? [];
  List<PageTemplateCustomFieldConfig> get customFieldConfigs => _customFieldConfigs ?? [];

  Genre? get selectedMusicGenre => _selectedMusicGenre;

  final _loadCountriesStreamController = StreamController<BlocState<Tuple2<List<Country>, Country?>>>.broadcast();
  Stream<BlocState<Tuple2<List<Country>, Country?>>> get loadCountriesStream => _loadCountriesStreamController.stream;

  final _loadPageTemplatesStreamController =
      StreamController<BlocState<Tuple2<List<AtlasCategory>, AtlasCategory?>>>.broadcast();
  Stream<BlocState<Tuple2<List<AtlasCategory>, AtlasCategory?>>> get loadPageTemplatesStream =>
      _loadPageTemplatesStreamController.stream;

  final _selectedGenderChanged = StreamController<Tuple2<Gender, String?>>.broadcast();
  Stream<Tuple2<Gender, String?>> get genderChangedStream => _selectedGenderChanged.stream;

  final _dateOfBirthChanged = StreamController<DateTime>.broadcast();
  Stream<DateTime> get dobChangedStream => _dateOfBirthChanged.stream;

  final _latLngChangeStreamController = StreamController<BlocState<LatLng?>>.broadcast();
  Stream<BlocState<LatLng?>> get latlngStream => _latLngChangeStreamController.stream;

  final _userProfileStreamController = StreamController<BlocState<PageTemplateResponse?>>.broadcast();
  Stream<BlocState<PageTemplateResponse?>> get userProfileStream => _userProfileStreamController.stream;

  final _loadCustomFieldsStreamController =
      StreamController<BlocState<List<PageTemplateCustomFieldConfig>?>>.broadcast();
  Stream<BlocState<List<PageTemplateCustomFieldConfig>?>> get loadCustomFieldsStream =>
      _loadCustomFieldsStreamController.stream;

  final _mapTypeStreamController = StreamController<MapType>.broadcast();
  Stream<MapType> get mapTypeStream => _mapTypeStreamController.stream;

  final _profileIsModifiedStreamController = StreamController<bool>.broadcast();
  Stream<bool> get profileModified => _profileIsModifiedStreamController.stream;

  List<Gender> get allGenders => [
        Gender.male,
        Gender.female,
        Gender.alien,
        Gender.panda,
        Gender.custom,
      ];

  PageTemplateBloc(this._appRepo, this._prefProvider);

  void loadPageTemplateData() async {
    final userId = _prefProvider.currentUserId;
    if (userId?.isNotEmpty == true) {
      final result = await _appRepo.getPageTemplateData();
      result.fold(
        (profile) {
          _userProfile = profile;
          loadAllCountries();
          loadAllPageTemplates();
          _userProfileStreamController.sink.add(BlocState.success(profile));
          _customFieldConfigs = profile.customFields;
          _loadCustomFieldsStreamController.sink.add(BlocState.success(_customFieldConfigs));
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
      final selectedCountry = _countries?.firstWhereOrNull((e) => e.countryISO == _userProfile?.countryISO);
      _loadCountriesStreamController.sink.add(BlocState.success(Tuple2(countries, selectedCountry)));
    }, (exception) {
      _countries = [];
      _loadCountriesStreamController.sink.add(BlocState.error(exception.toString()));
    });
  }

  void loadAllPageTemplates() async {
    final result = await _appRepo.getAtlasCategories();
    result.fold((categories) {
      _allPageTemplates = categories;
      _loadPageTemplatesStreamController.sink.add(
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
      _loadPageTemplatesStreamController.sink.add(BlocState.error(exception.toString()));
    });
  }

  void selectCountry(SelectMenuModel option) async {
    _profileIsModifiedStreamController.sink.add(true);
    final selectedCountry = _countries?.firstWhereOrNull((element) => element.name == option.title);
    _userProfile?.countryISO = selectedCountry?.countryISO;
    _loadCountriesStreamController.sink.add(BlocState.success(Tuple2(_countries ?? [], selectedCountry)));
  }

  void selectGender(SelectMenuModel? option) {
    if (option != null) {
      _profileIsModifiedStreamController.sink.add(true);
      _userProfile?.gender = allGenders.firstWhereOrNull((element) => element.indexs == option.id);
    } else {
      _userProfile?.gender = allGenders.firstWhereOrNull((element) => element == _userProfile?.gender);
    }
    _selectedGenderChanged.sink.add(Tuple2(
      _userProfile?.gender ?? Gender.none,
      (_userProfile?.genderText?.isNotEmpty == true) ? _userProfile?.genderText?.first : null,
    ));
  }

  void selectPageTemplate(SelectMenuModel selection) async {
    final selectedPageTemplate = _allPageTemplates?.firstWhereOrNull(
      (element) => element.title?.toLowerCase() == selection.title?.toLowerCase(),
    );
    _loadPageTemplatesStreamController.sink.add(
      BlocState.success(Tuple2(_allPageTemplates ?? [], selectedPageTemplate)),
    );
    final isPageTemplateChanged = selectedPageTemplate?.userGroupId != _userProfile?.userGroupId;
    if (isPageTemplateChanged) {
      _loadNewCustomFieldConfig(selectedPageTemplate?.userGroupId);
    } else {
      _loadAvailableCustomFieldConfig();
    }
  }

  void _loadNewCustomFieldConfig(String? userGroupId) async {
    _loadCustomFieldsStreamController.sink.add(const BlocState.loading());
    final result = await _appRepo.getPageTemplateData(userGroupId: userGroupId);
    result.fold(
      (l) {
        _customFieldConfigs = l.customFields;
        _loadCustomFieldsStreamController.sink.add(BlocState.success(_customFieldConfigs));
      },
      (r) {
        _loadCustomFieldsStreamController.sink.add(BlocState.error(r.toString()));
      },
    );
  }

  void _loadAvailableCustomFieldConfig() {
    _customFieldConfigs = _userProfile?.customFields;
    _loadCustomFieldsStreamController.sink.add(BlocState.success(_customFieldConfigs));
  }

  void genderTextOnChanged(String text) {
    if (_userProfile?.genderText?[0] != text) {
      _profileIsModifiedStreamController.sink.add(true);
    }
    _userProfile?.genderText?[0] = text;
  }

  void zipCodeOnChanged(String text) {
    if (_userProfile?.postalCode != text) {
      _profileIsModifiedStreamController.sink.add(true);
    }
    _userProfile?.postalCode = text;
  }

  void cityOnChanged(String text) {
    if (_userProfile?.cityLocation != text) {
      _profileIsModifiedStreamController.sink.add(true);
    }
    _userProfile?.cityLocation = text;
  }

  void selectDateOfBirth(DateTime dateTime) {
    _userProfile?.updateBirthday(dateTime);
    _userProfileStreamController.sink.add(BlocState.success(_userProfile));
    _profileIsModifiedStreamController.sink.add(true);
  }

  void pinLatLngOnChanged(LatLng latlng) {
    _userProfile?.updateLatLng(latlng);
    _userProfileStreamController.sink.add(BlocState.success(_userProfile));
    _profileIsModifiedStreamController.sink.add(true);
  }

  void selectableFieldOnChanged({required PageTemplateCustomFieldConfig field, required SelectableOption option}) {
    field.updateSelectedOption(option);
    field.options?.forEach((element) {
      print('----:${element.selected}');
    });
    final index = _customFieldConfigs?.indexWhere((element) => element.fieldId == field.fieldId);
    if (index != null) {
      _customFieldConfigs?[index] = field;
      _loadCustomFieldsStreamController.sink.add(BlocState.success(_customFieldConfigs));
      _profileIsModifiedStreamController.sink.add(true);
    }
  }

  void textFieldOnChanged({required PageTemplateCustomFieldConfig field, required String string}) {
    final customField = _userProfile?.customFields
        ?.firstWhere((element) => element.fieldName?.toLowerCase() == field.fieldName?.toLowerCase());
    customField?.updateTextValue(string);
    _profileIsModifiedStreamController.sink.add(true);
  }

  Future<bool> updatePageTemplate() async {
    if (_userProfile == null) {
      return false;
    }
    showOverLayLoading();
    _userProfile!.customFields = _customFieldConfigs;
    final result = await _appRepo.updatePageTemplate(_userProfile!.toJson());
    return result.fold((result) {
      hideOverlayLoading();
      return true;
    }, (exception) {
      hideOverlayLoading();
      showError(exception);
      return false;
    });
  }

  void changeMapType(MapType type) {
    _mapTypeStreamController.sink.add(type);
  }
}
