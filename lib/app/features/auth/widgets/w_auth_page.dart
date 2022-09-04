import 'package:audio_cult/app/features/auth/w_auth_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/constants/app_font_sizes.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_assets.dart';

class WAuthPage extends StatefulWidget {
  final Widget child;
  final bool isShowIconRight;
  final bool isHideHeader;
  const WAuthPage({Key? key, required this.child, this.isShowIconRight = true, this.isHideHeader = false})
      : super(key: key);

  @override
  State<WAuthPage> createState() => _WAuthPageState();
}

class _WAuthPageState extends State<WAuthPage> {
  final WAuthPageBloc _authPageBloc = WAuthPageBloc(locator.get(), locator.get());
  @override
  void initState() {
    super.initState();
    _authPageBloc.getCount();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.isHideHeader)
          const SizedBox()
        else
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
                    context.localize.t_auth_page,
                    style:
                        context.body2TextStyle()?.copyWith(fontSize: AppFontSize.size24, fontWeight: FontWeight.w700),
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
                      // StreamBuilder<String?>(
                      //     initialData: '...',
                      //     stream: _authPageBloc.navigateMainStream,
                      //     builder: (context, snapshot) {
                      //       return Padding(
                      //         padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
                      //         child: Text(
                      //           '${snapshot.data ?? ' '}k+',
                      //           style: context.body2TextStyle()?.copyWith(fontWeight: FontWeight.w300),
                      //           textAlign: TextAlign.center,
                      //         ),
                      //       );
                      //     }),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kVerticalSpacing),
                          child: Text(
                            context.localize.t_auth_member_join,
                            style: context.body2TextStyle()?.copyWith(fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   width: kHorizontalSpacing,
                      // ),
                      if (widget.isShowIconRight)
                        Padding(
                          padding: const EdgeInsets.only(right: kVerticalSpacing),
                          child: Image.asset(
                            AppAssets.authVectorIcon,
                            height: 36,
                          ),
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
