import 'package:audio_cult/app/constants/app_text_styles.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

import '../../app/utils/constants/app_colors.dart';

class CommonChipInput extends StatefulWidget {
  const CommonChipInput({
    Key? key,
    this.onChooseTag,
    this.onDeleteTag,
    this.controller,
    this.initTags,
    this.hintText,
    this.groupUserId,
  }) : super(key: key);

  final Function(ProfileData tag)? onChooseTag;
  final Function(ProfileData tag)? onDeleteTag;
  final List<ProfileData>? initTags;
  final TextEditingController? controller;
  final String? hintText;
  final String? groupUserId;

  @override
  State<CommonChipInput> createState() => _CommonChipInputState();
}

class _CommonChipInputState extends State<CommonChipInput> {
  UploadSongBloc? _uploadSongBloc;
  @override
  void initState() {
    super.initState();
    _uploadSongBloc = context.read<UploadSongBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return ChipsInput<ProfileData>(
      textStyle: AppTextStyles.regular,
      initialValue: widget.initTags!,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.regular,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        focusColor: AppColors.outlineBorderColor,
        fillColor: AppColors.inputFillColor.withOpacity(0.4),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: AppColors.outlineBorderColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: AppColors.outlineBorderColor,
            width: 2,
          ),
        ),
      ),
      maxChips: 1,
      chipBuilder: (BuildContext context, ChipsInputState<ProfileData> state, data) {
        return InputChip(
          key: ObjectKey(data),
          label: Text(data.fullName ?? ''),
          avatar: CircleAvatar(
            backgroundImage: NetworkImage(data.userImage ?? ''),
          ),
          onDeleted: () => state.deleteChip(data),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      findSuggestions: (String query) async {
        if (query.isNotEmpty) {
          var result = await _uploadSongBloc?.getListUsers(query, widget.groupUserId);
          return result!;
        } else {
          return const <ProfileData>[];
        }
      },
      onChanged: (List<ProfileData> value) {
        widget.onChooseTag?.call(value[0]);
      },
      suggestionBuilder: (BuildContext context, ChipsInputState<ProfileData?> state, ProfileData profile) {
        return ListTile(
          key: ObjectKey(profile),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(profile.userImage ?? ''),
          ),
          title: Text(
            profile.fullName ?? '',
            style: context.bodyTextStyle()?.copyWith(color: Colors.black),
          ),
          subtitle: Text(
            profile.userName ?? '',
            style: context.bodyTextStyle()?.copyWith(color: Colors.black),
          ),
          onTap: () => state.selectSuggestion(profile),
        );
      },
    );
  }
}
