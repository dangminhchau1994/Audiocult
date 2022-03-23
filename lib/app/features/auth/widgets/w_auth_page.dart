import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/constants/app_font_sizes.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_assets.dart';

class WAuthPage extends StatefulWidget {
  final Widget child;
  final bool isShowIconRight;
  const WAuthPage({Key? key, required this.child, this.isShowIconRight = true}) : super(key: key);

  @override
  State<WAuthPage> createState() => _WAuthPageState();
}

class _WAuthPageState extends State<WAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: AppColors.secondaryButtonColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + kVerticalSpacing,
              ),
              Image.asset(
                AppAssets.logoIcon,
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
                child: Text(
                  context.l10n.t_auth_page,
                  style: context.body2TextStyle()?.copyWith(fontSize: AppFontSize.size24, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                AppAssets.avatarAuthImg,
                height: 32,
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
                      child: Text(
                        context.l10n.t_auth_member_join,
                        style: context.body2TextStyle()?.copyWith(fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: kHorizontalSpacing,
                    ),
                    if (widget.isShowIconRight)
                      Image.asset(
                        AppAssets.authVectorIcon,
                        height: 36,
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
              const SizedBox(
                height: kVerticalSpacing,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.mainColor,
            child: widget.child,
          ),
        )
      ],
    );
  }
}
