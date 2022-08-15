class FilterUsersRequest {
  final String? keyword;
  final int? groupId;
  final int? categoryId;
  final String? countryISO;
  final List<String>? genreIds;
  final int? page;
  final String? userId;
  final String? getSubscribed;

  FilterUsersRequest(
      {this.keyword,
      this.groupId,
      this.categoryId,
      this.countryISO,
      this.genreIds,
      this.page,
      this.userId,
      this.getSubscribed});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['keyword'] = keyword;
    data['group_id'] = groupId;
    data['category_id'] = categoryId;
    data['country_iso'] = countryISO;
    data['genres_ids'] = genreIds?.join(',');
    data['page'] = page;
    data['user_id'] = userId;
    if (getSubscribed != null) {
      data['get_subscribed'] = getSubscribed;
    }
    return data;
  }

  @override
  String toString() {
    return 'FilterUsersRequestParams: $keyword $groupId-$categoryId-$countryISO-$genreIds';
  }
}
