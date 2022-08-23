class TopSongRequest {
  final String? sort;
  final String? query;
  final String? genresId;
  final String? when;
  final int? page;
  final int? limit;
  final String? tag;
  final String? view;
  final String? type;

  TopSongRequest({
    this.query,
    this.sort,
    this.page,
    this.limit,
    this.view,
    this.tag,
    this.type,
    this.genresId,
    this.when,
  });

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};
    data['search[search]'] = query;
    data['sort'] = sort;
    data['genre_id'] = genresId;
    data['when'] = when;
    data['page'] = page;
    data['limit'] = limit;
    data['tag'] = tag;
    data['type'] = type;
    data['view'] = view;

    return data;
  }
}
