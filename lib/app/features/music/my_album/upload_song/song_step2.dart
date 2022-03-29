import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../w_components/dropdown/common_dropdown.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<UploadSongBloc>().getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              CommonInput(hintText: context.l10n.t_label),
              const SizedBox(
                height: 12,
              ),
              CommonInput(hintText: context.l10n.t_collab_remix),
              const SizedBox(
                height: 12,
              ),
              CommonInput(hintText: context.l10n.t_label),
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
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.inputFillColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.outlineBorderColor),
                ),
                child: Center(
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
    );
  }
}
