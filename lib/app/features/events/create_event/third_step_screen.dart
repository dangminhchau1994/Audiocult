import 'dart:io';

import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_button.dart';
import '../../../data_source/models/requests/create_event_request.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/image/image_utils.dart';

class ThirdStepScreen extends StatefulWidget {
  const ThirdStepScreen({
    Key? key,
    this.onNext,
    this.onBack,
    this.createEventRequest,
  }) : super(key: key);

  final Function()? onNext;
  final Function()? onBack;
  final CreateEventRequest? createEventRequest;

  @override
  State<ThirdStepScreen> createState() => _ThirdStepScreenState();
}

class _ThirdStepScreenState extends State<ThirdStepScreen> {
  List<File>? _imageFileList;
  String? _pickImageError;
  double _ratio = 1;

  Widget _buildChooseImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.icUploadFrame,
          width: 48,
        ),
        Text(
          context.l10n.t_upload_banner,
          style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlue, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.t_limit_upload_event,
          style: context.bodyTextStyle()?.copyWith(color: AppColors.borderOutline, fontSize: 14),
        )
      ],
    );
  }

  Widget _buildImagePicked() {
    widget.createEventRequest?.image = _imageFileList![0];
    return AspectRatio(
      aspectRatio: _ratio,
      child: Center(
        child: Stack(
          children: [
            Image.file(
              File(_imageFileList![0].path),
              filterQuality: FilterQuality.high,
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _imageFileList = null;
                  });
                },
                child: const Icon(
                  Icons.close,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kHorizontalSpacing,
        vertical: kVerticalSpacing,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.t_upload_event_banner,
              style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              context.l10n.t_please_check_preview,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor, fontSize: 14),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await ImageUtils.onPickGallery(
                  context: context,
                  onChooseImage: (image) {
                    setState(() {
                      _imageFileList = image == null ? null : <File>[image];
                    });
                  },
                  onError: (error) {
                    setState(() {
                      _pickImageError = error.toString();
                    });
                  },
                );
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
                  child: _imageFileList != null ? _buildImagePicked() : _buildChooseImage(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  _ratio = 4.3 / 1;
                });
              },
              child: _buildPreviewOptions('4,3:1', context),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _ratio = 3 / 1;
                      });
                    },
                    child: _buildPreviewOptions('3:1', context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _ratio = 2 / 1;
                      });
                    },
                    child: _buildPreviewOptions('2:1', context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _ratio = 1.5 / 1;
                      });
                    },
                    child: _buildPreviewOptions('1,5:1', context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _ratio = 1 / 1;
                      });
                    },
                    child: _buildPreviewOptions('1:1', context, onlyRatio: true),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 40),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CommonButton(
                      color: AppColors.ebonyClay,
                      text: context.l10n.btn_back,
                      onTap: widget.onBack,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CommonButton(
                      color: AppColors.primaryButtonColor,
                      text: context.l10n.btn_next,
                      onTap: () {
                        widget.onNext!();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewOptions(String ratio, BuildContext context, {bool onlyRatio = false}) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.inputFillColor,
        border: Border.all(color: AppColors.outlineBorderColor),
      ),
      child: Center(
        child: Text(
          onlyRatio ? ratio : 'Preview ($ratio)',
          style: context.bodyTextStyle()?.copyWith(
                color: AppColors.subTitleColor,
                fontSize: 14,
              ),
        ),
      ),
    );
  }
}
