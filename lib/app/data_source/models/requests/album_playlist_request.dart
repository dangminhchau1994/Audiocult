class AlbumPlaylistRequest {
  final String? query;
  final String? view;
  final int? page;
  final String? sort;
  final int? limit;
  final int? getAll;

  AlbumPlaylistRequest({
    this.query,
    this.view,
    this.page,
    this.sort,
    this.limit,
    this.getAll,
  });
}
