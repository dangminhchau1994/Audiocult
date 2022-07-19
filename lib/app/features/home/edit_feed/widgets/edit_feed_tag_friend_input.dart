import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/textfields/common_chip_input.dart';
import '../../../../data_source/models/responses/profile_data.dart';
import '../../../../utils/constants/app_colors.dart';

class EditFeedTagFriendInput extends StatelessWidget {
  const EditFeedTagFriendInput({
    Key? key,
    this.onChooseTags,
    this.listProfile,
    this.onDeleteTag,
  }) : super(key: key);

  final Function(List<ProfileData> tag)? onChooseTags;
  final Function(ProfileData data)? onDeleteTag;
  final List<ProfileData>? listProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.secondaryButtonColor),
      child: Row(
        children: [
          Text(
            'with: ',
            style: context.bodyTextStyle()?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: CommonChipInput(
              initTags: listProfile,
              hintText: context.l10n.t_who_with_you,
              maxChip: 10,
              chooseMany: true,
              enableBorder: false,
              isFillColor: false,
              onChooseMultipleTag: (value) {
                onChooseTags!(value);
              },
              onDeleteTag: (value) {
                onDeleteTag!(value);
              },
              onPressedChip: (ProfileData value) {},
            ),
          ),
        ],
      ),
    );
  }
}
