import 'package:audio_cult/app/base/index_walker.dart';

class BlockedUser {
  String? blockUserId;
  String? userId;
  String? profilePageId;
  String? userServerId;
  String? userName;
  String? fullName;
  String? userImageUrl;
  String? isInvisible;
  String? userGroupId;
  String? userGroupTitle;
  String? languageId;
  String? lastActivity;
  String? birthday;
  String? countryISO;

  BlockedUser.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    blockUserId = iw['block_user_id'].get();
    userId = iw['user_id'].get();
    profilePageId = iw['profile_page_id'].get();
    userServerId = iw['user_server_id'].get();
    userName = iw['user_name'].get();
    fullName = iw['full_name'].get();
    userImageUrl = iw['user_image'].get();
    isInvisible = iw['is_invisible'].get();
    userGroupId = iw['user_group_id'].get();
    languageId = iw['language_id'].get();
    lastActivity = iw['last_activity'].get();
    birthday = iw['birthday'].get();
    countryISO = iw['country_iso'].get();
    userGroupTitle = iw['user_group_title'].get();
  }
}
