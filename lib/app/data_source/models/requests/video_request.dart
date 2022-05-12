class VideoRequest {
  final int? page;
  final int? limit;
  final int? profile; //0 or 1
  final String? sort;
  final String? when;
  VideoRequest({this.limit, this.page, this.profile, this.sort, this.when});
  Map<String, dynamic> toJson() {
    return {'profile': profile, 'page': page, 'limit': limit};
  }
}
