import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants/app_assets.dart';

class HomeStatus extends StatefulWidget {
  const HomeStatus({Key? key}) : super(key: key);

  @override
  State<HomeStatus> createState() => _HomeStatusState();
}

class _HomeStatusState extends State<HomeStatus> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(18),
            hintText: context.l10n.t_what_new,
            hintStyle: context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
        Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              children: [
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.tagFriends,
                      width: 28,
                      height: 28,
                    ),
                    const SizedBox(width: 20),
                    SvgPicture.asset(
                      AppAssets.locationIcon,
                      width: 28,
                      height: 28,
                    ),
                    const SizedBox(width: 20),
                    SvgPicture.asset(
                      AppAssets.colorPickerIcon,
                      width: 28,
                      height: 28,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2.25),
                      child: CommonButton(
                        width: 110,
                        color: AppColors.primaryButtonColor,
                        text: 'Post',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
