class CreatePostRequest {
  String? userStatus;
  String? statusBackgroundId;
  String? taggedFriends;
  String? latLng;
  String? locationName;

  CreatePostRequest({
    this.userStatus,
    this.statusBackgroundId,
    this.taggedFriends,
    this.latLng,
    this.locationName,
  });

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};

    data['val[user_status]'] = userStatus;
    data['val[status_background_id]'] = statusBackgroundId;
    data['val[tagged_friends]'] = taggedFriends;
    data['val[location][latlng]'] = latLng;
    data['val[location][name]'] = locationName;

    return data;
  }
}
