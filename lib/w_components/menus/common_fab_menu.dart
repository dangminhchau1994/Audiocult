import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/fcm/fcm_bloc.dart';
import 'package:audio_cult/app/features/my_cart/my_cart_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/data_source/local/pref_provider.dart';
import '../../app/utils/constants/app_assets.dart';
import '../../app/utils/constants/app_colors.dart';

class CommonFabMenu extends StatelessWidget {
  const CommonFabMenu({
    Key? key,
    this.onSearchTap,
    this.onCartTap,
    this.onNotificationTap,
  }) : super(key: key);

  final Function()? onSearchTap;
  final Function()? onNotificationTap;
  final Function()? onCartTap;

  void setBadge() async {
    await locator<PrefProvider>().setShowBadge(0);
    getIt<FCMBloc>().showBadge(locator<PrefProvider>().showBadge ?? 0);
    getIt<FCMBloc>().countBadge(locator<PrefProvider>().countBadge ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayColor: AppColors.mainColor,
      spaceBetweenChildren: 12,
      elevation: 0,
      dialRoot: (context, open, toggleChildren) {
        if (open) {
          setBadge();
          return _buildActionIcon(
            const Icon(Icons.close),
            false,
          );
        } else {
          return _buildActionIcon(
            StreamBuilder<int>(
              initialData: locator<PrefProvider>().showBadge,
              stream: getIt<FCMBloc>().showBadgeStream,
              builder: (context, snapshot) {
                final showBadge = snapshot.data ?? 0;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: toggleChildren,
                      child: SvgPicture.asset(
                        AppAssets.actionMenu,
                      ),
                    ),
                    Visibility(
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      visible: showBadge == 1 ? true : false,
                      child: Positioned(
                        top: 10,
                        right: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            false,
          );
        }
      },
      direction: SpeedDialDirection.down,
      children: [
        SpeedDialChild(
          child: SvgPicture.asset(
            AppAssets.searchIcon,
            width: 50,
            height: 50,
          ),
          backgroundColor: AppColors.inputFillColor,
          foregroundColor: Colors.white,
          onTap: onSearchTap,
        ),
        SpeedDialChild(
          child: StreamBuilder<int>(
            initialData: locator<PrefProvider>().countBadge,
            stream: getIt<FCMBloc>().countBadgeStream,
            builder: (context, snapshot) {
              final countBadge = snapshot.data ?? 0;

              return Badge(
                elevation: 0,
                badgeContent: Text(
                  countBadge > 99 ? '+99' : '$countBadge',
                  style: context.buttonTextStyle()?.copyWith(fontSize: 12),
                ),
                showBadge: countBadge > 0,
                position: BadgePosition.topEnd(),
                padding: const EdgeInsets.all(6),
                badgeColor: AppColors.badgeColor,
                child: SvgPicture.asset(
                  AppAssets.notificationIcon,
                  width: 30,
                  height: 30,
                ),
              );
            },
          ),
          backgroundColor: AppColors.inputFillColor,
          foregroundColor: Colors.white,
          onTap: onNotificationTap,
        ),
        SpeedDialChild(
          child: _myCartBadge(context),
          backgroundColor: AppColors.inputFillColor,
          foregroundColor: Colors.white,
          onTap: onCartTap,
        ),
      ],
    );
  }

  Widget _myCartBadge(BuildContext context) {
    return StreamBuilder<BlocState<List<Song>>>(
      stream: getIt.get<MyCartBloc>().allCartItemsStream,
      builder: (_, snapshot) {
        return Badge(
          showBadge: getIt.get<MyCartBloc>().cartItems.isNotEmpty,
          elevation: 0,
          badgeColor: AppColors.badgeColor,
          position: BadgePosition.topEnd(),
          padding: const EdgeInsets.all(6),
          badgeContent: Text(
            getIt.get<MyCartBloc>().cartItems.length.toString(),
            style: context.buttonTextStyle()?.copyWith(fontSize: 12),
          ),
          child: SvgPicture.asset(
            AppAssets.cartIcon,
            width: 30,
            height: 30,
          ),
        );
      },
    );
  }

  Widget _buildActionIcon(Widget child, bool padding) {
    return Container(
      padding: EdgeInsets.all(padding ? 8 : 0),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.inputFillColor,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
