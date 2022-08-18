class FeedRequest {
  final int? page;
  final int? limit;
  final int? lastFeedId;
  final String? userId;

  FeedRequest({
    this.page,
    this.limit,
    this.lastFeedId,
    this.userId,
  });

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};

    data['page'] = page;
    data['limit'] = limit;
    data['last_feed_id'] = lastFeedId;
    if (userId?.isNotEmpty ?? false) {
      data['user_id'] = userId;
    }

    return data;
  }
}
