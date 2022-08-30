import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import '../../../../../w_components/comment/comment_args.dart';
import '../../../../../w_components/comment/comment_list_screen.dart';
import '../../../../../w_components/dialogs/report_dialog.dart';
import '../../../../../w_components/menus/common_popup_menu.dart';
import '../../../../../w_components/reactions/common_reaction.dart';
import '../../../../constants/global_constants.dart';
import '../../../../utils/constants/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';
import '../../../../utils/route/app_route.dart';

class DetailAlbumDescription extends StatelessWidget {
  final Album? data;

  const DetailAlbumDescription({
    Key? key,
    this.data,
    this.id,
    this.title,
  }) : super(key: key);

  final int? id;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: kVerticalSpacing,
          left: kVerticalSpacing,
          right: kVerticalSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localize.t_description,
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            //first row
            ReadMoreText(
              data?.text ?? '',
              trimLines: 3,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: context.localize.t_read_more,
              trimExpandedText: context.localize.t_read_less,
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 14,
                  ),
              moreStyle: TextStyle(
                color: AppColors.lightBlueColor,
              ),
              lessStyle: TextStyle(
                color: AppColors.lightBlueColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //heart, comment
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CommonReactions(
                      reactionType: ReactionType.album,
                      itemId: data?.albumId ?? '',
                      totalLike: data?.totalLike ?? '',
                      iconPath: data?.lastIcon?.imagePath,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    WButtonInkwell(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.routeCommentListScreen,
                          arguments: CommentArgs(
                            itemId: id ?? 0,
                            title: title ?? '',
                            commentType: CommentType.album,
                            data: null,
                          ),
                        );
                      },
                      child: _buildIcon(
                        SvgPicture.asset(AppAssets.commentIcon),
                        data?.totalComment ?? '',
                        context,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    WButtonInkwell(
                      onPressed: () {},
                      child: Container(
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.secondaryButtonColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: CommonPopupMenu(
                            icon: SvgPicture.asset(
                              AppAssets.verticalIcon,
                              width: 24,
                              height: 24,
                            ),
                            items: GlobalConstants.menuDetail(context),
                            onSelected: (selected) {
                              switch (selected) {
                                case 0:
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      insetPadding: EdgeInsets.zero,
                                      contentPadding: EdgeInsets.zero,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                      ),
                                      content: Builder(
                                        builder: (context) => ReportDialog(
                                          type: ReportType.album,
                                          itemId: int.parse(data?.albumId ?? ''),
                                        ),
                                      ),
                                    ),
                                  );
                                  break;
                                case 1:
                                  break;
                                case 2:
                                  break;
                                default:
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                _buildPlayCount(data?.totalPlay ?? '', context)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              color: AppColors.secondaryButtonColor,
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Widget icon, String value, BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.secondaryButtonColor,
      ),
      padding: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 14,
            ),
            Text(
              value,
              style: context.bodyTextPrimaryStyle()!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlayCount(
    String value,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.playCountIcon,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            value,
            style: context.bodyTextPrimaryStyle()!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
