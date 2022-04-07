class FilterUsersRequest {
  final int? groupId;
  final String? countryISO;
  final List<String>? genreIds;
  final int? page;

  FilterUsersRequest({this.groupId, this.countryISO, this.genreIds, this.page});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['country_iso'] = countryISO;
    data['genres_ids'] = genreIds?.join(',');
    data['page'] = page;
    return data;
  }

  @override
  String toString() {
    return 'FilterUsersRequestParams: $groupId-$countryISO-$genreIds';
  }
}