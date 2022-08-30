class GetInvitationRequest {
  String? searchType;
  int? itemId;
  String? keyword;

  GetInvitationRequest({
    this.searchType,
    this.itemId,
    this.keyword,
  });

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};

    data['search[type]'] = searchType;
    data['search[item_id]'] = itemId;
    data['search[keyword]'] = keyword;

    return data;
  }
}
