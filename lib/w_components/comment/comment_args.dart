import 'package:audio_cult/w_components/comment/comment_list_screen.dart';

import '../../app/data_source/models/responses/comment/comment_response.dart';

class CommentArgs {
  final CommentResponse? data;
  final int? itemId;
  final String? title;
  final CommentType? commentType;

  CommentArgs({
    required this.data,
    required this.itemId,
    required this.commentType,
    this.title,
  });
}
