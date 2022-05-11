import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../w_components/menus/common_popup_menu.dart';
import '../../../constants/global_constants.dart';
import '../../../utils/constants/app_assets.dart';

class FeedItemModify extends StatelessWidget {
  const FeedItemModify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
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
              break;
            case 1:
              break;
            case 2:
              break;
            default:
          }
        },
      ),
    );
  }
}
