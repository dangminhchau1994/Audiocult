import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/mixins/disposable_state_mixin.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:blur/blur.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/dialogs/app_dialog.dart';
import '../../main/main_bloc.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with DisposableStateMixin {
  @override
  void initState() {
    super.initState();
    getIt.get<MainBloc>().logoutStream.listen((event) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoute.routeLogin, (route) => false);
    }).disposeOn(disposeBag);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Image.asset(AppAssets.imgHeaderDrawer),
          Expanded(
            child: Stack(
              children: [
                Blur(
                  blur: 20,
                  blurColor: AppColors.semiMainColor,
                  child: Container(),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 56,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
                    child: Column(
                      children: [
                        Divider(
                          color: AppColors.inputFillColor,
                        ),
                        WButtonInkwell(
                          onPressed: () {
                            AppDialog.showYesNoDialog(
                              context,
                              message: context.l10n.t_question_logout,
                              onYesPressed: () {
                                getIt.get<MainBloc>().logout();
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppAssets.icLogout,
                                  width: 24,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  context.l10n.t_logout,
                                  style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
