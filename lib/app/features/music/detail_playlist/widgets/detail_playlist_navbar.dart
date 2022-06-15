import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../../w_components/menus/common_popup_menu.dart';
import '../../../../data_source/local/pref_provider.dart';
import '../../../../injections.dart';

class DetailPlayListNavBar extends StatelessWidget {
  const DetailPlayListNavBar({
    Key? key,
    this.onDelete,
    this.userId,
  }) : super(key: key);

  final Function()? onDelete;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
            left: 20,
          ),
          child: WButtonInkwell(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        Visibility(
          visible: locator.get<PrefProvider>().currentUserId == userId,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              right: 8,
            ),
            child: CommonPopupMenu(
              icon: const Icon(
                Icons.settings,
                size: 24,
                color: Colors.white,
              ),
              items: GlobalConstants.menuModify(context),
              onSelected: (selected) {
                switch (selected) {
                  case 0:
                    onDelete!();
                    break;
                  case 1:
                    break;
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
