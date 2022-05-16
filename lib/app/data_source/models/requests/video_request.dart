class VideoRequest {
  final int? page;
  final int? limit;
  final String? userId;
  final String? sort;
  final String? when;
  VideoRequest({this.limit, this.page, this.userId, this.sort, this.when});
  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'page': page, 'limit': limit};
  }
}
