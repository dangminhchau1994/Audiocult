import '../services/app_service_provider.dart';
import 'base_repository.dart';

class AppRepository extends BaseRepository {
  final AppServiceProvider appServiceProvider;

  AppRepository({required this.appServiceProvider});

  // Future<Either<Authorize, Exception>> login(LoginRequest request) {
  //   return safeCall(() => appServiceProvider.login(request));
  // }

}
