import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../w_components/comment/common_comment.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../base/bloc_state.dart';
import '../../../../constants/app_text_styles.dart';
import '../../../../data_source/models/responses/comment/comment_response.dart';
import '../../../../injections.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';

class DetailPlayListComment extends StatefulWidget {
  const DetailPlayListComment({
    Key? key,
    this.id,
  }) : super(key: key);

  final int? id;

  @override
  State<DetailPlayListComment> createState() => _DetailPlayListCommentState();
}

class _DetailPlayListCommentState extends State<DetailPlayListComment> {
  DetailPlayListBloc playListBloc = DetailPlayListBloc(locator.get());

  @override
  void initState() {
    playListBloc.getComments(widget.id ?? 0, 'advancedmusic_playlist', 1, 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLines: 5,
            cursorColor: Colors.white,
            onChanged: (value) {},
            style: AppTextStyles.regular,
            decoration: InputDecoration(
              filled: true,
              focusColor: AppColors.outlineBorderColor,
              fillColor: AppColors.secondaryButtonColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                ),
              ),
              hintText: context.l10n.t_leave_comment,
              hintStyle: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.lightWhiteColor,
                    fontSize: 14,
                  ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: SvgPicture.asset(
                  AppAssets.faceIcon,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<BlocState<List<CommentResponse>>>(
            initialData: const BlocState.loading(),
            stream: playListBloc.getCommentsStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (success) {
                  final data = success as List<CommentResponse>;

                  if (data.isEmpty) {
                    return const Center(
                      child: Text(
                        'No comments for this playlists',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Divider(height: 30),
                    itemBuilder: (context, index) => ExpandablePanel(
                      controller: ExpandableController(initialExpanded: true),
                      header: CommonComment(data: data[index]),
                      theme: const ExpandableThemeData(
                        hasIcon: false,
                        tapBodyToExpand: false,
                        useInkWell: false,
                      ),
                      collapsed: Container(),
                      expanded: Container(),
                    ),
                  );
                },
                loading: () {
                  return const Center(
                    child: LoadingWidget(),
                  );
                },
                error: (error) {
                  return ErrorSectionWidget(
                    errorMessage: error,
                    onRetryTap: () {},
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            color: AppColors.secondaryButtonColor,
            height: 1,
          ),
        ],
      ),
    );
  }
}
