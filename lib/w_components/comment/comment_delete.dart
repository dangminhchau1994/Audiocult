import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import '../buttons/w_button_inkwell.dart';

class CommentDelete extends StatelessWidget {
  const CommentDelete({
    Key? key,
    this.onDelete,
  }) : super(key: key);

  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: onDelete,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              context.l10n.t_delete,
              style: context.buttonTextStyle()!.copyWith(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
