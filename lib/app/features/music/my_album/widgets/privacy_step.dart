import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/common_button.dart';
import '../../../../../w_components/dropdown/common_dropdown.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';

class PrivacyStep extends StatefulWidget {
  final Function()? onNext;

  final Function()? onBack;
  const PrivacyStep({Key? key, this.onBack, this.onNext}) : super(key: key);

  @override
  State<PrivacyStep> createState() => PrivacyStepState();
}

class PrivacyStepState extends State<PrivacyStep> {
  SelectMenuModel? _privacy;
  SelectMenuModel? _privacyComment;
  late List<SelectMenuModel> listPrivacy;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listPrivacy = [
      SelectMenuModel(
        id: 1,
        title: context.localize.t_everyone,
        isSelected: true,
        icon: Image.asset(
          AppAssets.icPublic,
          width: 24,
        ),
      ),
      SelectMenuModel(
        id: 2,
        title: context.localize.t_subscriptions,
        icon: Image.asset(
          AppAssets.icSubscription,
          width: 24,
        ),
      ),
      SelectMenuModel(
        id: 3,
        title: context.localize.t_friends_of_friends,
        icon: Image.asset(
          AppAssets.icFriends,
          width: 24,
        ),
      ),
      SelectMenuModel(
        id: 4,
        title: context.localize.t_only_me,
        icon: Image.asset(
          AppAssets.icLock,
          width: 24,
        ),
      ),
      SelectMenuModel(
        id: 5,
        title: context.localize.t_customize,
        icon: Image.asset(
          AppAssets.icSetting,
          width: 24,
        ),
      ),
    ];
    _privacy = listPrivacy[0];
    _privacyComment = listPrivacy[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.localize.t_privacy, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
          const SizedBox(
            height: kVerticalSpacing / 2,
          ),
          Text(
            context.localize.t_sub_privacy,
            style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          CommonDropdown(
              selection: _privacy,
              hint: '',
              data: listPrivacy,
              onChanged: (value) {
                setState(() {
                  _privacy = value;
                });
              }),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          Text(context.localize.t_comment_privacy, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
          const SizedBox(
            height: kVerticalSpacing / 2,
          ),
          Text(
            context.localize.t_sub_comment_privacy,
            style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          CommonDropdown(
              selection: _privacyComment,
              hint: '',
              data: listPrivacy,
              onChanged: (value) {
                setState(() {
                  _privacyComment = value;
                });
              }),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  color: AppColors.secondaryButtonColor,
                  text: context.localize.btn_back,
                  onTap: () {
                    widget.onBack?.call();
                  },
                ),
              ),
              const SizedBox(
                width: kVerticalSpacing,
              ),
              Expanded(
                child: CommonButton(
                  color: AppColors.primaryButtonColor,
                  text: context.localize.btn_next,
                  onTap: () {
                    widget.onNext?.call();
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
        ],
      ),
    );
  }
}
