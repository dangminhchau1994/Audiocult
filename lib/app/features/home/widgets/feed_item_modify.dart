import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../w_components/menus/common_popup_menu.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/local/pref_provider.dart';
import '../../../injections.dart';
import '../../../utils/constants/app_assets.dart';

class FeedItemModify extends StatelessWidget {
  const FeedItemModify({
    Key? key,
    this.onDelete,
    this.onEdit,
    this.item,
  }) : super(key: key);

  final Function()? onDelete;
  final Function()? onEdit;
  final FeedResponse? item;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Visibility(
        visible: locator<PrefProvider>().currentUserId == item?.userId,
        child: CommonPopupMenu(
          icon: SvgPicture.asset(
            AppAssets.verticalIcon,
            width: 28,
            height: 28,
          ),
          items: GlobalConstants.menuFeedItem(context),
          onSelected: (selected) {
            switch (selected) {
              case 0:
                onEdit!();
                break;
              case 1:
                onDelete!();
                break;
              case 2:
                break;
              default:
            }
          },
        ),
      ),
    );
  }
}
