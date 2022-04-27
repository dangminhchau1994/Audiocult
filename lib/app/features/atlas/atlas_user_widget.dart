import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data_source/models/responses/atlas_user.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_font_sizes.dart';
import '../../utils/route/app_route.dart';
import '../profile/profile_screen.dart';

class AtlasUserWidget extends StatelessWidget {
  final AtlasUser atlasUser;
  final bool userSubscriptionInProcess;
  final Function? subscriptionOnChanged;
  final bool? updatedSubscriptionStatus;
  final int? updatedSubscriptionCount;

  const AtlasUserWidget(
    this.atlasUser, {
    this.userSubscriptionInProcess = false,
    Key? key,
    this.subscriptionOnChanged,
    this.updatedSubscriptionCount,
    this.updatedSubscriptionStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: () {
        Navigator.pushNamed(context, AppRoute.routeProfile,
            arguments: ProfileScreen.createArguments(id: atlasUser.userId!));
      },
      child: Container(
        color: AppColors.mainColor,
        child: Column(
          children: [
            _thumbnailWidget(context),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoWidget(context),
                  _subscribeButton(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _thumbnailWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: _imageWidget(),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: _roleLabel(context),
        ),
      ],
    );
  }

  Widget _imageWidget() {
    return CachedNetworkImage(
      imageUrl: atlasUser.userImage ?? '',
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(color: AppColors.primaryButtonColor),
      ),
      errorWidget: (_, __, ___) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(AppAssets.imagePlaceholder),
            fit: BoxFit.fill,
          ),
        ),
      ),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget _roleLabel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.deepTeal.withAlpha(150),
      ),
      child: Text(
        atlasUser.userGroupTitle ?? '',
        style: context.body2TextStyle()?.copyWith(color: AppColors.activeLabelItem),
      ),
    );
  }

  Widget _infoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          atlasUser.fullName ?? '',
          style: context.body2TextStyle()?.copyWith(
                fontSize: AppFontSize.size20,
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          atlasUser.locationName ?? '',
          style: context.body1TextStyle()?.copyWith(
                color: AppColors.subTitleColor,
              ),
        ),
      ],
    );
  }

  Widget _subscribeButton(BuildContext context) {
    return TextButton(
      onPressed: () => userSubscriptionInProcess ? null : subscriptionOnChanged?.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.secondaryButtonColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              updatedSubscriptionCount?.toString() ?? atlasUser.subscriptionCount.toString(),
              style: context.body1TextStyle()?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColors.subTitleColor,
                  ),
            ),
            const SizedBox(width: 12),
            _subscriptionIcon(),
          ],
        ),
      ),
    );
  }

  Widget _subscriptionIcon() {
    const loadingIndicator = CircularProgressIndicator(
      strokeWidth: 2,
      color: Colors.white,
    );
    final subscriptionIcon = SvgPicture.asset(
      updatedSubscriptionStatus ?? atlasUser.isSubscribed == true
          ? AppAssets.subscribedUserIcon
          : AppAssets.unsubscribedUserIcon,
    );
    return SizedBox(
      height: 18,
      width: 18,
      child: userSubscriptionInProcess ? loadingIndicator : subscriptionIcon,
    );
  }
}
