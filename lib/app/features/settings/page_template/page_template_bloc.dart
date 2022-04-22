import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/country_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/utils/constants/gender_enum.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:collection/collection.dart';

class PageTemplateBloc extends BaseBloc {
  final AppRepository _appRepo;

  Country? _selectedCountry;
  City? _selectedCity;
  Gender? _selectedGender;
  DateTime? _dateOfBirth;

  List<Country>? _countries;
  List<City>? _cities;

  final _loadCountriesStreamController = StreamController<BlocState<List<Country>>>.broadcast();
  Stream<BlocState<List<Country>>> get loadCountriesStream => _loadCountriesStreamController.stream;

  final _loadCitiesStreamController = StreamController<List<City>>.broadcast();
  Stream<List<City>> get loadCitiesStream => _loadCitiesStreamController.stream;

  final _selectedGenderChanged = StreamController<Gender>.broadcast();
  Stream<Gender> get genderChangedStream => _selectedGenderChanged.stream;

  final _dateOfBirthChanged = StreamController<DateTime>.broadcast();
  Stream<DateTime> get dobChangedStream => _dateOfBirthChanged.stream;

  List<Gender> get allGenders => [
        Gender.none,
        Gender.male,
        Gender.female,
        Gender.alien,
        Gender.panda,
        Gender.custom,
      ];

  PageTemplateBloc(this._appRepo);

  void loadAllCountries() async {
    final result = await _appRepo.getAllCountries();
    result.fold((countries) {
      _countries = countries;
      // final menuOptions = countries.map((e) => SelectMenuModel(title: e.name)).toList();
      _loadCountriesStreamController.sink.add(BlocState.success(countries));
    }, (exception) {
      _loadCountriesStreamController.sink.add(BlocState.error(exception.toString()));
    });
  }

  void selectCountry(SelectMenuModel option) {
    _selectedCountry = _countries?.firstWhereOrNull((element) => element.name == option.title);
    _cities = _selectedCountry?.cities ?? [];
    _loadCitiesStreamController.sink.add(_cities ?? []);
  }

  void selectCity(SelectMenuModel option) {
    // TODO: handle selecting city
  }

  void selectGender(SelectMenuModel option) {
    _selectedGender = allGenders.firstWhere((element) => element.index == option.id);
    _selectedGenderChanged.sink.add(_selectedGender ?? Gender.none);
  }

  void selectDateOfBirth(DateTime dateTime) {
    _dateOfBirth = dateTime;
    _dateOfBirthChanged.sink.add(dateTime);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
