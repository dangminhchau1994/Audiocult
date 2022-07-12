import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';

import '../../../data_source/models/requests/create_post_request.dart';
import '../../../utils/constants/app_colors.dart';

class EditFeedScreen extends StatefulWidget {
  const EditFeedScreen({Key? key}) : super(key: key);

  @override
  State<EditFeedScreen> createState() => _EditFeedScreenState();
}

class _EditFeedScreenState extends State<EditFeedScreen> {
  final TextEditingController _textEditingController = TextEditingController(text: '');
  final CreatePostRequest _createPostRequest = CreatePostRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: context.l10n.t_edit_post,
      ),
      body: Stack(
        children: [
          TextField(
            maxLines: 10,
            controller: _textEditingController,
            onChanged: (value) {
              _createPostRequest.userStatus = value;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(18),
              hintText: context.l10n.t_what_new,
              hintStyle: context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
          
        ],
      ),
    );
  }
}
