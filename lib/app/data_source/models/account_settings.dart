import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';

class AccountSettings {
  String? fullName;
  String? email;
  String? currentPass;
  String? newPass;
  String? confirmPass;
  String? languageId;
  String? timezone;
  String? paypalEmail;

  AccountSettings(ProfileData? profile) {
    fullName = profile?.fullName;
    email = profile?.email;
  }

  Map<String, dynamic> toJson() {
    final params = <String, dynamic>{};
    params['val[full_name]'] = fullName;
    params['val[email]'] = email;
    params['val[old_password]'] = currentPass;
    params['val[new_password]'] = newPass;
    params['val[confirm_password]'] = confirmPass;
    params['val[language_id]'] = languageId;
    params['val[time_zone]'] = timezone;
    params['val[paypal_email]'] = paypalEmail;
    return params;
  }

  AccountSettings clone() {
    return AccountSettings(null)
      ..fullName = fullName
      ..email = email
      ..currentPass = currentPass
      ..newPass = newPass
      ..confirmPass = confirmPass
      ..languageId = languageId
      ..timezone = timezone
      ..paypalEmail = paypalEmail;
  }
}
