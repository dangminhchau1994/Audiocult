class FeedRequest {
  final int? page;
  final int? limit;
  final int? lastFeedId;
  final String? userId;

  FeedRequest({
    this.page,
    this.limit,
    this.lastFeedId,
    this.userId
  });
}
