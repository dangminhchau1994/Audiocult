import 'package:audio_cult/app/utils/flavor/flavor.dart';

class AppConstants {
  static const String clientId = 'mobileapp';
  static String clientSecret = FlavorConfig.isProduction()
      ? '5dd247eea4f89ceb57144e40de0002f95c6a158a'
      : '6e31ef65768789d2e6144eb792878d6211e97406';
  static const String grantType = 'password';
  static const String basicToken = 'Basic bW9iaWxlYXBwOjZlMzFlZjY1NzY4Nzg5ZDJlNjE0NGViNzkyODc4ZDYyMTFlOTc0MDY=';
  static const String androidKey = 'AIzaSyCq_ewBkTd_Ptlva35RYyHJU7oBYCGhMpY';
  static const String iosKey = 'AIzaSyCq_ewBkTd_Ptlva35RYyHJU7oBYCGhMpY';
}

const fileExtensions = ['mp3', 'wav'];

enum RequestStatus { success, failed }

extension RequestStatusExtension on RequestStatus {
  String get value {
    switch (this) {
      case RequestStatus.success:
        return 'success';
      case RequestStatus.failed:
        return 'failed';
    }
  }
}

enum SubscriptionStatus { subscribe, unsubscribe }

extension SubscriptionStatusExtension on SubscriptionStatus {
  int get value {
    switch (this) {
      case SubscriptionStatus.subscribe:
        return 1;
      case SubscriptionStatus.unsubscribe:
        return 0;
    }
  }
}
