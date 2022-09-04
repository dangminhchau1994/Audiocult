class InviteFriendRequest {
  String? type;
  String? emails;
  String? personalMessage;
  String? userIds;
  String? itemId;

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};

    data['val[type]'] = type;
    data['val[emails]'] = emails;
    data['val[personal_message]'] = personalMessage;
    data['val[user_ids]'] = userIds;
    data['val[item_id]'] = itemId;

    return data;
  }
}
