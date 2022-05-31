import 'dart:io';

import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/upload_video_request.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/features/home/post_video/widgets/add_video.dart';
import 'package:audio_cult/app/features/home/post_video/widgets/get_video.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../constants/global_constants.dart';
import '../../../injections.dart';
import '../../../services/media_service.dart';
import '../../../utils/bottom_sheet/image_picker_action_sheet.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';

class PostVideo extends StatefulWidget {
  const PostVideo({
    Key? key,
    this.onAddVideo,
  }) : super(key: key);

  final Function()? onAddVideo;

  @override
  State<PostVideo> createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> with DisposableStateMixin, AutomaticKeepAliveClientMixin {
  final MediaServiceInterface _mediaService = locator<MediaServiceInterface>();
  final FocusNode _focusNode = FocusNode();
  File? _video;
  SelectMenuModel? _privacy;
  bool _showAddVideo = true;
  String _urlVideo = '';
  String _videoTitle = '';
  String _fileName = '';
  String _status = '';

  @override
  void initState() {
    super.initState();
    _privacy = GlobalConstants.listPrivacy[0];
    getIt.get<HomeBloc>().uploadVideoStream.listen((data) {
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);
  }

  Future _getImage(AppImageSource _appImageSource) async {
    final _pickedVideoFile = await _mediaService.uploadVideo(context, AppImageSource.gallery);

    setState(() {
      _video = _pickedVideoFile;
      _fileName = _video!.path.split('/').last;
      _showAddVideo = false;
    });
  }

  Future<AppImageSource?> _pickVideoSource() async {
    final _appImageSource = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => const ImagePickerActionSheet(),
    );
    if (_appImageSource != null) {
      await _getImage(_appImageSource as AppImageSource);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: getIt<HomeBloc>(),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                if (_showAddVideo || _fileName.isEmpty)
                  Visibility(
                    visible: _showAddVideo,
                    child: AddVideo(
                      onAddVideo: _pickVideoSource,
                    ),
                  )
                else
                  GetVideo(
                    onRemoveFile: () {
                      setState(() {
                        _showAddVideo = true;
                        _fileName = '';
                      });
                    },
                    videoName: _fileName,
                  ),
                CommonInput(
                  focusNode: _focusNode,
                  onChanged: (value) {
                    if (_fileName.isEmpty) {
                      setState(() {
                        _urlVideo = value;
                      });
                    } else {
                      _videoTitle = value;
                    }
                  },
                  hintText: _fileName.isEmpty ? context.l10n.t_paste_url : context.l10n.t_video_title,
                  suffixIcon: _showAddVideo || _urlVideo.isEmpty || _fileName.isNotEmpty
                      ? const SizedBox()
                      : WButtonInkwell(
                          onPressed: () {
                            setState(() {
                              _showAddVideo = true;
                              _focusNode.unfocus();
                            });
                          },
                          child: Text(
                            'Cancel',
                            style: context.buttonTextStyle()!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.activeLabelItem,
                                ),
                          ),
                        ),
                  onTap: () {
                    setState(() {
                      _showAddVideo = false;
                    });
                  },
                ),
                Visibility(
                  visible: !_showAddVideo,
                  child: TextField(
                    maxLines: 10,
                    onChanged: (value) {
                      setState(() {
                        _status = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        top: 20,
                        bottom: 10,
                      ),
                      hintText: context.l10n.t_say_something_video,
                      hintStyle: context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.secondaryButtonColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: CommonDropdown(
                          selection: _privacy,
                          hint: '',
                          backgroundColor: Colors.transparent,
                          noBorder: true,
                          data: GlobalConstants.listPrivacy,
                          onChanged: (value) {
                            setState(() {
                              _privacy = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        AppAssets.tagFriends,
                        width: 28,
                        height: 28,
                      ),
                      const SizedBox(width: 20),
                      SvgPicture.asset(
                        AppAssets.locationIcon,
                        width: 28,
                        height: 28,
                      ),
                    ],
                  ),
                  CommonButton(
                    width: 110,
                    color: AppColors.primaryButtonColor,
                    text: 'Post',
                    onTap: () async {
                      final request = UploadVideoRequest()
                        ..video = _video
                        ..title = _videoTitle
                        ..url = _urlVideo
                        ..statusInfo = _status;

                      getIt<HomeBloc>().uploadVideo(request);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
