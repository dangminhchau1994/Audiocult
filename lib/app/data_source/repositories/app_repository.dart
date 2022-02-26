import 'package:audio_cult/app/data_source/models/requests/register_request.dart';
import 'package:dartz/dartz.dart';
import '../models/requests/login_request.dart';
import '../models/responses/login_response.dart';
import '../models/responses/register_response.dart';
import '../models/responses/song/song_response.dart';
import '../services/app_service_provider.dart';
import 'base_repository.dart';

class AppRepository extends BaseRepository {
  final AppServiceProvider appServiceProvider;

  AppRepository({required this.appServiceProvider});

  Future<Either<LoginResponse, Exception>> login(LoginRequest request) {
    return safeCall(() => appServiceProvider.login(request));
  }

  Future<Either<SongResponse, Exception>> getTopSongs(
    String sort,
    int limit,
    int page,
  ) {
    return safeCall(
      () => appServiceProvider.getTopSongs(sort, page, limit),
    );
  }

  Future<Either<LoginResponse, Exception>> authentication() {
    return safeCall(appServiceProvider.authentication);
  }

  Future<Either<RegisterResponse, Exception>> register(RegisterRequest request) {
    return safeCall(() => appServiceProvider.register(request));
  }

  Future<Either<bool, Exception>> logout() {
    return safeCall(appServiceProvider.logout);
  }
}
