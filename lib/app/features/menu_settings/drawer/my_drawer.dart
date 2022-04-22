import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/features/profile/profile_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/constants/app_font_sizes.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/mixins/disposable_state_mixin.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:blur/blur.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/dialogs/app_dialog.dart';
import '../../../data_source/models/responses/profile_data.dart';
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
    getIt.get<MainBloc>().getUserProfile();
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
          Stack(
            children: [
              Image.asset(AppAssets.imgHeaderDrawer),
              // Positioned.fill(
              //   child: CommonImageNetWork(
              //     imagePath: locator.get<MainBloc>().profileData?.coverPhoto,
              //   ),
              // ),
              Positioned(
                left: 16,
                right: 0,
                bottom: 16,
                child: WButtonInkwell(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.routeProfile,
                        arguments: ProfileScreen.createArguments(id: locator.get<PrefProvider>().currentUserId!));
                  },
                  child: StreamBuilder<ProfileData?>(
                      initialData: locator.get<MainBloc>().profileData,
                      stream: locator.get<MainBloc>().profileStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data?.fullName}',
                                style: context.body1TextStyle()?.copyWith(fontSize: AppFontSize.size16),
                              ),
                              Text('${snapshot.data?.title}'),
                            ],
                          );
                        }
                        return Container();
                      }),
                ),
              )
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Blur(
                  blur: 20,
                  blurColor: AppColors.secondaryButtonColor,
                  child: Container(),
                ),
                Column(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        WButtonInkwell(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppAssets.icSubscription,
                                  width: 24,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(context.l10n.t_subscriptions)
                              ],
                            ),
                          ),
                        ),
                        WButtonInkwell(
                          onPressed: () {
                            // Navigator.pushNamedAndRemoveUntil(context, AppRoute.routeLogin, (route) => false);
                            Navigator.pushNamed(context, AppRoute.routeSettings);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Image.asset(AppAssets.icSetting, width: 24),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(context.l10n.t_settings)
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 56),
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
