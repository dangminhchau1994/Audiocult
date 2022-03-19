class CommentRequest {
  final int? parentId;
  final int? id;
  final String? typeId;
  final int? page;
  final int? limit;

  CommentRequest({
    this.parentId,
    this.id,
    this.typeId,
    this.page,
    this.limit,
  });
}
