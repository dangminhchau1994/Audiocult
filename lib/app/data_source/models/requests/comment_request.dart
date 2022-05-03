class CommentRequest {
  final int? parentId;
  final int? id;
  final String? typeId;
  final int? page;
  final int? limit;
  final String? sort;

  CommentRequest({
    this.parentId,
    this.id,
    this.typeId,
    this.page,
    this.limit,
    this.sort,
  });
}
