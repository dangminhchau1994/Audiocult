import 'package:audio_cult/app/features/music/detail_album/detail_comment_args.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/appbar/common_appbar.dart';
import '../../../../utils/constants/app_colors.dart';

class DetailListRepliesScreen extends StatefulWidget {
  const DetailListRepliesScreen({
    Key? key,
    this.detailCommentArgs,
  }) : super(key: key);

  final DetailCommentArgs? detailCommentArgs;

  @override
  State<DetailListRepliesScreen> createState() => _DetailListRepliesScreenState();
}

class _DetailListRepliesScreenState extends State<DetailListRepliesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        centerTitle: false,
        title: context.l10n.t_reply,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: kVerticalSpacing,
              horizontal: kHorizontalSpacing,
            ),
          ),
        ],
      ),
    );
  }
}
