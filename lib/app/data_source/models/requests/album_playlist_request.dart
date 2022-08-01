class AlbumPlaylistRequest {
  final String? query;
  final String? view;
  final int? page;
  final String? sort;
  final String? genresId;
  final String? when;
  final int? limit;
  final int? getAll;

  AlbumPlaylistRequest(
      {this.query, this.view, this.page, this.sort, this.limit, this.getAll, this.genresId, this.when});
}
