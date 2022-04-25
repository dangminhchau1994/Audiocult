import '../../../base/index_walker.dart';

class Subscriptions {
  String? userId;
  String? userName;
  String? fullName;
  String? userImage;
  bool? isSubscribed;
  int? mutualCount;

  Subscriptions({this.userId, this.userName, this.fullName, this.userImage, this.isSubscribed, this.mutualCount});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    userId = iw['user_id'].get();
    userName = iw['user_name'].get();
    fullName = iw['full_name'].get();
    userImage = iw['user_image'].get();
    isSubscribed = iw['is_subscribed'].get();
    mutualCount = iw['mutual_count'].get();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['full_name'] = fullName;
    data['user_image'] = userImage;
    data['is_subscribed'] = isSubscribed;
    data['mutual_count'] = mutualCount;
    return data;
  }
}
