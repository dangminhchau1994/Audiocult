class FeedRequest {
  final int? page;
  final int? limit;
  final int? lastFeedId;

  FeedRequest({
    this.page,
    this.limit,
    this.lastFeedId,
  });
}
