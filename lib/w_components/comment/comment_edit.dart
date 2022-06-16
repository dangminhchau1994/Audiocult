import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../app/utils/route/app_route.dart';
import '../buttons/w_button_inkwell.dart';

// ignore: must_be_immutable
class CommentEdit extends StatelessWidget {
  CommentEdit({
    Key? key,
    this.item,
    this.commentResponse,
  }) : super(key: key);

  CommentResponse? item;
  final ValueNotifier<CommentResponse>? commentResponse;

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: () async {
        Navigator.pop(context);
        final result = await Navigator.pushNamed(
          context,
          AppRoute.routeCommentEdit,
          arguments: {
            'comment_response': item,
          },
        );
        if (result != null) {
          commentResponse?.value = result as CommentResponse;
          item = commentResponse?.value;
        }
      },
      child: Row(
        children: [
          const Icon(
            Icons.edit_outlined,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            context.l10n.t_edit,
            style: context.buttonTextStyle()!.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
