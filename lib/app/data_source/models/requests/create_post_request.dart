class CreatePostRequest {
  String? userStatus;
  String? statusBackgroundId;
  String? taggedFriends;
  String? latLng;
  int? feedId;
  String? locationName;
  int? privacy;
  String? userId;

  CreatePostRequest({
    this.userStatus,
    this.feedId,
    this.statusBackgroundId,
    this.taggedFriends,
    this.latLng,
    this.locationName,
    this.privacy,
    this.userId
  });

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};

    if (feedId != 0) {
      data['val[feed_id]'] = feedId;
    }
    data['val[user_status]'] = userStatus;
    data['val[status_background_id]'] = statusBackgroundId;
    data['val[tagged_friends]'] = taggedFriends;
    data['val[location][latlng]'] = latLng;
    data['val[location][name]'] = locationName;
    data['val[privacy]'] = privacy;
    data['val[parent_user_id]'] = userId;

    return data;
  }
}
