import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/utils/constants/app_colors.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    Key? key,
    this.data,
    this.onReply,
  }) : super(key: key);

  final CommentResponse? data;
  final Function(CommentResponse data)? onReply;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: 50,
            height: 50,
            imageUrl: widget.data?.userImage ?? '',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryButtonColor,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.data?.userName ?? '',
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            color: AppColors.lightBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateTimeUtils.formatCommonDate('hh:mm', int.parse(widget.data?.timeStamp ?? '')),
                      style: context.bodyTextPrimaryStyle()!.copyWith(
                            color: AppColors.lightWhiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.data?.text ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyTextPrimaryStyle()!.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateTimeUtils.convertToAgo(int.parse(widget.data?.timeStamp ?? '')),
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.lightWhiteColor,
                                fontSize: 12,
                              ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.onReply!(widget.data!);
                          },
                          child: Text(
                            'Reply',
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: Colors.lightBlue,
                                  fontSize: 12,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.activeHeart,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.data?.totalLike ?? '',
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.lightWhiteColor,
                                fontSize: 14,
                              ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
