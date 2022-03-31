import 'dart:io';

import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../base/pair.dart';
import '../../../../utils/constants/app_constants.dart';
import '../widgets/item_uploaded_music.dart';
import 'package:http/http.dart' as http;

class SongStep1 extends StatefulWidget {
  final Function()? onNext;
  final Song? song;
  const SongStep1({Key? key, this.onNext, this.song}) : super(key: key);

  @override
  State<SongStep1> createState() => SongStep1State();
}

class SongStep1State extends State<SongStep1> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Pair<PlatformFile, Duration>> listFileAudio = [];
  @override
  void initState() {
    super.initState();
    fillData();
  }

  void fillData() async {
    if (widget.song != null && widget.song!.songPath != null && widget.song!.songPath!.isNotEmpty) {
      // ignore: use_named_constants
      var file = await downloadFile(widget.song!.songPath!, widget.song!.title ?? const Uuid().v4());
      final byte = await file.readAsBytes();
      listFileAudio.add(
          Pair(PlatformFile(name: widget.song!.title ?? '', size: file.lengthSync(), bytes: byte), const Duration()));
      setState(() {});
    }
  }

  Future<File> downloadFile(String url, String filename) async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    final file = File('$dir/$filename');
    final request = await http.get(
      Uri.parse(url),
    );
    final bytes = request.bodyBytes; //close();
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.t_upload_music, style: context.bodyTextStyle()?.copyWith(fontSize: 18)),
          const SizedBox(
            height: kVerticalSpacing / 2,
          ),
          Text(
            context.l10n.t_sub_upload_music,
            style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          WButtonInkwell(
            borderRadius: BorderRadius.circular(4),
            onPressed: widget.song != null
                ? null
                : () async {
                    final result = await FilePicker.platform
                        .pickFiles(allowedExtensions: fileExtensions, allowMultiple: true, type: FileType.custom);
                    if (result != null) {
                      final files = result.files;
                      if (files.length < 10) {
                        for (final element in files) {
                          final duration = await _audioPlayer.setFilePath(element.path!);
                          // ignore: avoid_print
                          listFileAudio.add(Pair(element, duration!));
                        }
                        setState(() {});
                      }
                    } else {
                      // User canceled the picker
                    }
                  },
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(4),
              color: AppColors.borderOutline,
              dashPattern: const [20, 6],
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.inputFillColor.withOpacity(0.2),
                height: 168,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.icUploadFrame,
                      width: 48,
                    ),
                    Text(
                      context.l10n.t_upload_music,
                      style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor, fontSize: 18),
                    ),
                    Text(
                      context.l10n.t_limit_upload,
                      style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: listFileAudio
                .map(
                  (e) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ItemUploadedMusic(
                      duration: e.second,
                      file: e.first,
                      onRemove: (id) {
                        if (widget.song == null) {
                          listFileAudio.removeWhere((element) => element.first.identifier == id);
                          setState(() {});
                        }
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: kVerticalSpacing,
          ),
          CommonButton(
            color: AppColors.primaryButtonColor,
            text: context.l10n.btn_next,
            onTap: listFileAudio.isEmpty
                ? null
                : () {
                    widget.onNext?.call();
                  },
          )
        ],
      ),
    );
  }
}
