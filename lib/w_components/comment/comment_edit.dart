import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';
import '../buttons/w_button_inkwell.dart';

class CommentEdit extends StatelessWidget {
  const CommentEdit({Key? key, this.onEdit}) : super(key: key);

  final Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: onEdit,
      child: Padding(
        padding: const EdgeInsets.all(8),
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
              context.localize.t_edit,
              style: context.buttonTextStyle()!.copyWith(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
