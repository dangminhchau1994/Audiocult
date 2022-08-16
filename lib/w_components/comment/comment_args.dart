import 'package:audio_cult/w_components/comment/comment_list_screen.dart';
import 'package:audio_cult/w_components/dialogs/report_dialog.dart';

import '../../app/data_source/models/responses/comment/comment_response.dart';

class CommentArgs {
  final CommentResponse? data;
  final int? itemId;
  final String? title;
  final ReportType? reportType;
  final CommentType? commentType;

  CommentArgs({
    required this.data,
    required this.itemId,
    required this.commentType,
    this.reportType,
    this.title,
  });
}
