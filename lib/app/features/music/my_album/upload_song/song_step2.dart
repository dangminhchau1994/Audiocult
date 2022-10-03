import 'dart:io';

import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../w_components/dialogs/app_dialog.dart';
import '../../../../../w_components/dropdown/common_dropdown.dart';
import '../../../../../w_components/textfields/common_chip_input.dart';
import '../../../../base/pair.dart';
import '../../../../data_source/models/requests/upload_request.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_dimens.dart';
import '../../../../utils/route/app_route.dart';
import '../../../profile/profile_screen.dart';

class SongStep2 extends StatefulWidget {
  final Function()? onNext;

  final Function()? onBack;
  final bool? isUploadSong;
  final Song? song;
  final Album? album;

  const SongStep2({Key? key, this.onBack, this.onNext, this.isUploadSong, this.song, this.album}) : super(key: key);

  @override
  State<SongStep2> createState() => SongStep2State();
}

class SongStep2State extends State<SongStep2> {
  final _formKey = GlobalKey<FormState>();
  SelectMenuModel? _genreSelection;
  SelectMenuModel? _musicType;
  bool isValidate1 = false;
  bool isValidate2 = false;
  // ignore: prefer_typing_uninitialized_variables
  var _genres;
  final _musicList = [SelectMenuModel(id: 0, title: 'Normal songs'), SelectMenuModel(id: 1, title: 'Mixtape songs')];
  UploadSongBloc? _uploadSongBloc;
  XFile? _fileSongCover;
  final UploadRequest _uploadRequest = UploadRequest();
  final trackTitleEditTextController = TextEditingController();
  final yearEditTextController = TextEditingController();
  final albumNameEditTextController = TextEditingController();
  final descriptionEditTextController = TextEditingController();
  final tagsEditTextController = TextEditingController();
  ProfileData? collabUser;
  ProfileData? labelUser;

  @override
  void initState() {
    super.initState();
    _uploadSongBloc = context.read<UploadSongBloc>();
    _uploadSongBloc?.getGenres();
    _uploadSongBloc?.getUserProfile();
    if (widget.song != null) {
      trackTitleEditTextController.text = widget.song!.title ?? '';
      descriptionEditTextController.text = widget.song!.description ?? '';
      tagsEditTextController.text = widget.song!.tags ?? '';
      _genreSelection = SelectMenuModel(
          id: int.parse(widget.song!.genreId ?? '0'), title: widget.song!.genreName ?? '', isSelected: true);
      _musicType = _musicList.where((element) => element.id == int.tryParse(widget.song!.isDj ?? '0')).first;
      _musicType!.isSelected = true;
      collabUser = widget.song?.collabUser;
      labelUser = widget.song?.labelUser;
    }

    if (widget.album != null) {
      albumNameEditTextController.text = widget.album!.name ?? '';
      yearEditTextController.text = widget.album!.year ?? '';
      descriptionEditTextController.text = widget.album!.description ?? '';
      _genreSelection = SelectMenuModel(id: int.parse(widget.album!.genreId ?? '0'), title: '', isSelected: true);
      _musicType = _musicList.where((element) => element.id == int.tryParse(widget.album!.isDj ?? '0')).first;
      _musicType!.isSelected = true;
      collabUser = widget.album?.collabUser;
      labelUser = widget.album?.labelUser;
      _uploadRequest.year = int.tryParse(yearEditTextController.text);
      _uploadRequest.name = albumNameEditTextController.text;
      _uploadRequest.genreId = widget.album?.genreId;
      _uploadRequest.musicType = widget.album?.isDj ?? '0';
    }
    setState(() {});
  }

  UploadRequest get getValue {
    return _uploadRequest;
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
                Text(context.localize.t_main_info, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
                const SizedBox(
                  height: kVerticalSpacing / 2,
                ),
                Text(
                  context.localize.t_sub_main_info,
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
                ),
                const SizedBox(
                  height: kVerticalSpacing,
                ),
                if (widget.isUploadSong!)
                  CommonInput(
                    editingController: trackTitleEditTextController,
                    hintText: context.localize.t_track_title,
                    onChanged: (v) {
                      setState(() {
                        _uploadRequest.title = v;
                        _uploadRequest.name = v;
                      });
                    },
                  )
                else
                  CommonInput(
                    editingController: albumNameEditTextController,
                    hintText: context.localize.t_album_name,
                    onChanged: (v) {
                      setState(() {
                        _uploadRequest.title = v;
                        _uploadRequest.name = v;
                      });
                    },
                  ),
                const SizedBox(
                  height: 12,
                ),
                if (widget.isUploadSong!)
                  const SizedBox.shrink()
                else
                  CommonInput(
                    editingController: yearEditTextController,
                    hintText: context.localize.t_year,
                    textInputType: TextInputType.datetime,
                    onChanged: (v) {
                      setState(() {
                        _uploadRequest.year = int.tryParse(v);
                      });
                    },
                  ),
                const SizedBox(
                  height: 12,
                ),
                StreamBuilder<List<Genre>>(
                    stream: context.read<UploadSongBloc>().getGenresStream,
                    builder: (context, snapshot) {
                      _genres ??=
                          snapshot.data?.map((e) => SelectMenuModel(id: int.parse(e.genreId!), title: e.name)).toList();
                      if (_genres is List) {
                        (_genres as List<SelectMenuModel>).map((e) {
                          if (e.id == _genreSelection?.id) {
                            _genreSelection = e;
                            e.isSelected = true;
                          }
                          return e;
                        }).toList();
                      }
                      return CommonDropdown(
                        isValidate: isValidate1,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        selection: _genreSelection,
                        onChanged: (value) {
                          setState(() {
                            _genreSelection = value;
                            _uploadRequest.genreId = _genreSelection!.id.toString();
                          });
                        },
                        hint: context.localize.t_genres,
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
                      _uploadRequest.musicType = _musicType!.id.toString();
                    });
                  },
                  hint: context.localize.t_music_type,
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
                        _uploadRequest.artistUserId = data.userId;
                        return Row(
                          children: [
                            Text('${context.localize.t_artist}: '),
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
                        hintText: context.localize.t_artist,
                        onChooseTag: (value) {
                          setState(() {
                            _uploadRequest.artistUserId = value.userId;
                          });
                        },
                        onPressedChip: (ProfileData value) {
                          Navigator.pushNamed(context, AppRoute.routeProfile,
                              arguments: ProfileScreen.createArguments(id: value.userId!));
                        },
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
                  onPressedChip: (ProfileData value) {
                    Navigator.pushNamed(context, AppRoute.routeProfile,
                        arguments: ProfileScreen.createArguments(id: value.userId!));
                  },
                  hintText: context.localize.t_collab_remix,
                  initTags: collabUser == null ? [] : [collabUser!],
                  onChooseTag: (value) {
                    setState(() {
                      _uploadRequest.collabUserId = value.userId;
                    });
                  },
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
                          _uploadRequest.labelUserId = data.userId;
                          return Row(
                            children: [
                              Text('${context.localize.t_label}: '),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoute.routeProfile,
                                      arguments: ProfileScreen.createArguments(id: data.userId!));
                                },
                                child: Text(
                                  data.fullName ?? '',
                                  style: context.body1TextStyle()?.copyWith(color: AppColors.activeLabelItem),
                                ),
                              )
                            ],
                          );
                        }
                        return CommonChipInput(
                          onPressedChip: (ProfileData value) {
                            Navigator.pushNamed(context, AppRoute.routeProfile,
                                arguments: ProfileScreen.createArguments(id: value.userId!));
                          },
                          groupUserId: '9',
                          initTags: labelUser == null ? [] : [labelUser!],
                          hintText: context.localize.t_label,
                          onChooseTag: (value) {
                            setState(() {
                              _uploadRequest.labelUserId = value.userId;
                            });
                          },
                          onDeleteTag: (value) {},
                        );
                      }
                      return Container();
                    }),
                const SizedBox(
                  height: 12,
                ),
                CommonInput(
                  editingController: descriptionEditTextController,
                  hintText: '* ${context.localize.t_description}',
                  height: 100,
                  maxLine: 100,
                  onChanged: (v) {
                    setState(() {
                      _uploadRequest.description = v;
                      _uploadRequest.text = v;
                    });
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                if (!widget.isUploadSong!)
                  const SizedBox.shrink()
                else
                  CommonInput(
                    editingController: tagsEditTextController,
                    hintText: context.localize.t_tags_separate,
                    onChanged: (v) {
                      setState(() {
                        _uploadRequest.tags = v;
                      });
                    },
                  ),
                const SizedBox(
                  height: kVerticalSpacing,
                ),
                Text(context.localize.t_upload_song_cover, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
                const SizedBox(
                  height: kVerticalSpacing / 2,
                ),
                Text(
                  context.localize.t_sub_upload_song_cover,
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
                          Pair(
                            0,
                            Container(),
                          ),
                          context.localize.t_take_picture,
                        ),
                        Pair(
                          Pair(
                            1,
                            Container(),
                          ),
                          context.localize.t_choose_gallery,
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
                            _uploadRequest.songCoverFile = _fileSongCover;
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
                        Stack(
                          children: [
                            if ((widget.song?.imagePath != null || widget.album?.imagePath != null) &&
                                _fileSongCover == null)
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top: 0,
                                  child: Image.network(
                                    widget.song?.imagePath ?? widget.album?.imagePath ?? '',
                                    fit: BoxFit.cover,
                                  ))
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
