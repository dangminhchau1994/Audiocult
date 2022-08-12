class TopSongRequest {
  final String? sort;
  final String? genresId;
  final String? when;
  final int? page;
  final int? limit;
  final String? view;
  final String? type;

  TopSongRequest({
    this.sort,
    this.page,
    this.limit,
    this.view,
    this.type,
    this.genresId,
    this.when,
  });
}
