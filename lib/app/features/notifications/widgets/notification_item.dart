import 'package:audio_cult/app/data_source/models/responses/notifications/notification_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../utils/constants/app_colors.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    this.data,
  }) : super(key: key);

  final NotificationResponse? data;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
        theme: const ExpandableThemeData(
          hasIcon: false,
          tapHeaderToExpand: false,
          tapBodyToCollapse: false,
          tapBodyToExpand: false,
          useInkWell: false,
        ),
        controller: ExpandableController(initialExpanded: true),
        header: Text(
          data?.date ?? '',
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
        expanded: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data?.notifications?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: data?.notifications?[index].isRead == '0' ? AppColors.primaryButtonColor : Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 14,
                    bottom: 14,
                  ),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      imageUrl: data?.notifications?[index].userImage ?? '',
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
                    title: Html(
                      data: data?.notifications?[index].message,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        data?.date ?? '',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        collapsed: Container());
  }
}
