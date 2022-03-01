import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/base_response.dart';
import 'package:audio_cult/app/data_source/models/responses/user_group.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data_source/local/pref_provider.dart';
import '../../../data_source/models/requests/register_request.dart';
import '../../../data_source/models/responses/place.dart';
import '../../../data_source/networks/exceptions/app_exception.dart';
import '../../../data_source/repositories/app_repository.dart';
import '../widgets/register_page.dart';

class RegisterBloc extends BaseBloc {
  final AppRepository _appRepository;
  // ignore: unused_field
  final PrefProvider _prefProvider;
  final _navigateMain = PublishSubject<bool>();
  final _listRoles = PublishSubject<List<UserGroup>>();
  final _listSuggestion = PublishSubject<List<Suggestion>>();

  Stream<bool> get navigateMainStream => _navigateMain.stream;
  Stream<List<UserGroup>> get rolesStream => _listRoles.stream;
  Stream<List<Suggestion>> get suggestionStream => _listSuggestion.stream;

  RegisterBloc(this._appRepository, this._prefProvider);
  // ignore: avoid_void_async
  void submitRegister(RegisterRequest registerRequest) async {
    showOverLayLoading();
    final resultAuthentication = await _appRepository.authentication();
    hideOverlayLoading();

    resultAuthentication.fold(
      (authentication) async {
        registerRequest.accessToken = authentication.accessToken;
        showOverLayLoading();
        final result = await _appRepository.register(registerRequest);
        hideOverlayLoading();
        result.fold(
          (data) async {
            if (data.status == StatusString.success) {
              _navigateMain.add(true);
            } else {
              showError(AppException('${data.message}'));
            }
          },
          showError,
        );
      },
      showError,
    );
  }

  // ignore: avoid_void_async
  void getRole() async {
    showOverLayLoading();
    final resultAuthentication = await _appRepository.authentication();
    hideOverlayLoading();
    resultAuthentication.fold(
      (authentication) async {
        showOverLayLoading();
        final result = await _appRepository.getRole(authentication.accessToken);
        hideOverlayLoading();
        result.fold(
          // ignore: unnecessary_lambdas
          (data) {
            _listRoles.add(data);
          },
          showError,
        );
      },
      showError,
    );
  }

  void fetchSuggestions(String query, String languageCode) async {
    _listSuggestion.addError('error');
    final result = await _appRepository.fetchSuggestions(query, languageCode);
    result.fold((l) {
      _listSuggestion.add(l);
      return l;
    }, (r) {
      _listSuggestion.add([]);
      return [];
    });
  }

  Future<Place?> getPlaceDetailFromId(String placeId) async {
    showOverLayLoading();
    final result = await _appRepository.getPlaceDetailFromId(placeId);
    hideOverlayLoading();
    return result.fold((l) {
      return l;
    }, (r) {
      return null;
    });
  }

  Future<Location?> getLatLng(String description) async {
    showOverLayLoading();
    try {
      final locations = await locationFromAddress(description);
      hideOverlayLoading();
      if (locations.isNotEmpty) {
        return locations[0];
      } else {
        return null;
      }
    } on Exception catch (e) {
      hideOverlayLoading();
      showError(e);
      return null;
    }
  }
}
