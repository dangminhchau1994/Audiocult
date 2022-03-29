import 'dart:io';

import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:audio_cult/w_components/textfields/common_input_tags.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../w_components/dialogs/app_dialog.dart';
import '../../../../../w_components/dropdown/common_dropdown.dart';
import '../../../../../w_components/textfields/common_chip_input.dart';
import '../../../../base/pair.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';

class SongStep2 extends StatefulWidget {
  final Function()? onNext;

  final Function()? onBack;

  const SongStep2({Key? key, this.onBack, this.onNext}) : super(key: key);

  @override
  State<SongStep2> createState() => _SongStep2State();
}

class _SongStep2State extends State<SongStep2> {
  final _formKey = GlobalKey<FormState>();
  SelectMenuModel? _genre;
  SelectMenuModel? _musicType;
  bool isValidate1 = false;
  bool isValidate2 = false;
  // ignore: prefer_typing_uninitialized_variables
  var _genres;
  final _musicList = [SelectMenuModel(id: 0, title: 'Normal songs'), SelectMenuModel(id: 1, title: 'Mixtape songs')];
  UploadSongBloc? _uploadSongBloc;
  XFile? _fileSongCover;
  @override
  void initState() {
    super.initState();
    _uploadSongBloc = context.read<UploadSongBloc>();
    _uploadSongBloc?.getGenres();
    _uploadSongBloc?.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return WKeyboardDismiss(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.l10n.t_main_info, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
                const SizedBox(
                  height: kVerticalSpacing / 2,
                ),
                Text(
                  context.l10n.t_sub_main_info,
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
                ),
                const SizedBox(
                  height: kVerticalSpacing,
                ),
                CommonInput(hintText: context.l10n.t_track_title),
                const SizedBox(
                  height: 12,
                ),
                StreamBuilder<List<Genre>>(
                    stream: context.read<UploadSongBloc>().getGenresStream,
                    builder: (context, snapshot) {
                      _genres ??=
                          snapshot.data?.map((e) => SelectMenuModel(id: int.parse(e.genreId!), title: e.name)).toList();
                      return CommonDropdown(
                        isValidate: isValidate1,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        selection: _genre,
                        onChanged: (value) {
                          setState(() {
                            _genre = value;
                          });
                        },
                        hint: context.l10n.t_genres,
                        // ignore: cast_nullable_to_non_nullable
                        data: snapshot.hasData ? _genres as List<SelectMenuModel> : [],
                      );
                    }),
                const SizedBox(
                  height: 12,
                ),
                CommonDropdown(
                  isValidate: isValidate2,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  selection: _musicType,
                  onChanged: (value) {
                    setState(() {
                      _musicType = value;
                    });
                  },
                  hint: context.l10n.t_music_type,
                  data: _musicList,
                ),
                const SizedBox(
                  height: 12,
                ),
                StreamBuilder<ProfileData?>(
                  stream: _uploadSongBloc?.profileStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      // ignore: unrelated_type_equality_checks
                      if (data!.userGroupId == '8') {
                        return Row(
                          children: [
                            Text('${context.l10n.t_artist}: '),
                            Text(
                              data.fullName ?? '',
                              style: context.body1TextStyle()?.copyWith(color: AppColors.activeLabelItem),
                            )
                          ],
                        );
                      }
                      return CommonChipInput(
                        groupUserId: '8',
                        initTags: [],
                        hintText: context.l10n.t_artist,
                        onChooseTag: (value) {},
                        // onDeleteTag: (value) {},
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CommonChipInput(
                  hintText: context.l10n.t_collab_remix,
                  initTags: [],
                  onChooseTag: (value) {},
                ),
                const SizedBox(
                  height: 12,
                ),
                StreamBuilder<ProfileData?>(
                    stream: _uploadSongBloc?.profileStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        // ignore: unrelated_type_equality_checks
                        if (data!.userGroupId != '8') {
                          return Container(
                            child: Row(
                              children: [
                                Text('${context.l10n.t_label}: '),
                                Text(
                                  data.fullName ?? '',
                                  style: context.body1TextStyle()?.copyWith(color: AppColors.activeLabelItem),
                                )
                              ],
                            ),
                          );
                        }
                        return CommonChipInput(
                          groupUserId: '9',
                          initTags: [],
                          hintText: context.l10n.t_label,
                          onChooseTag: (value) {},
                          onDeleteTag: (value) {},
                        );
                      }
                      return Container();
                    }),
                const SizedBox(
                  height: 12,
                ),
                CommonInput(
                  hintText: '* ${context.l10n.t_description}',
                  height: 100,
                  maxLine: 100,
                ),
                const SizedBox(
                  height: 12,
                ),
                CommonInput(
                  hintText: context.l10n.t_tags_separate,
                ),
                const SizedBox(
                  height: kVerticalSpacing,
                ),
                Text(context.l10n.t_upload_song_cover, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
                const SizedBox(
                  height: kVerticalSpacing / 2,
                ),
                Text(
                  context.l10n.t_sub_upload_song_cover,
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
                ),
                const SizedBox(
                  height: kVerticalSpacing,
                ),
                WButtonInkwell(
                  borderRadius: BorderRadius.circular(4),
                  onPressed: () {
                    AppDialog.showSelectionBottomSheet(
                      context,
                      listSelection: [
                        Pair(
                          Container(),
                          context.l10n.t_take_picture,
                        ),
                        Pair(
                          Container(),
                          context.l10n.t_choose_gallery,
                        ),
                      ],
                      onTap: (index) async {
                        Navigator.pop(context);
                        final _picker = ImagePicker();
                        // Pick an image
                        final image =
                            await _picker.pickImage(source: index == 0 ? ImageSource.camera : ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            _fileSongCover = image;
                          });
                        }
                      },
                    );
                  },
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: AppColors.inputFillColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.outlineBorderColor),
                    ),
                    child: Stack(
                      children: [
                        if (_fileSongCover != null)
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            top: 0,
                            child: Image.file(
                              File(_fileSongCover!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.activeLabelItem.withOpacity(0.4),
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppColors.activeLabelItem,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: kVerticalSpacing,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        color: AppColors.secondaryButtonColor,
                        text: context.l10n.btn_back,
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
                        text: context.l10n.btn_next,
                        onTap: () {
                          setState(() {
                            isValidate1 = true;
                            isValidate2 = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            widget.onNext?.call();
                          }
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
          ),
        ),
      ),
    );
  }
}
