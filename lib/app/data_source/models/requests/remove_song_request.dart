class RemoveSongRequest {
  int? playlistId;
  String? songId;

  RemoveSongRequest({
    this.playlistId,
    this.songId,
  });

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};
    data['val[playlist_id]'] = playlistId;
    data['val[song_ids]'] = songId;

    return data;
  }
}
