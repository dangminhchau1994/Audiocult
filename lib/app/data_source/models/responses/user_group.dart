import '../../../base/index_walker.dart';

class UserGroup {
  int? userGroupId;
  String? title;

  UserGroup({this.userGroupId, this.title});

  UserGroup.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);

    userGroupId = iw['user_group_id'].get();
    title = iw['title'].get();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_group_id'] = userGroupId;
    data['title'] = title;
    return data;
  }
}
