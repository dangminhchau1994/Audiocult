import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';

class DetailCommentArgs {
  final CommentResponse? data;
  final int? itemId;

  DetailCommentArgs({
    required this.data,
    required this.itemId,
  });
}
