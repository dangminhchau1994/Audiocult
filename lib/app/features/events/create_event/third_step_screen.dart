import 'package:audio_cult/app/features/events/create_event/widgets/preview_image.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';
import '../../../../w_components/buttons/common_button.dart';
import '../../../data_source/models/requests/create_event_request.dart';
import '../../../utils/constants/app_colors.dart';

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
  double _ratio = 1;

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
              context.localize.t_upload_event_banner,
              style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              context.localize.t_please_check_preview,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor, fontSize: 14),
            ),
            const SizedBox(height: 20),
            PreViewImage(
              ratio: _ratio,
              request: widget.createEventRequest,
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
                      text: context.localize.btn_back,
                      onTap: widget.onBack,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CommonButton(
                      color: AppColors.primaryButtonColor,
                      text: context.localize.btn_next,
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
          onlyRatio ? ratio : '${context.localize.t_preview} ($ratio)',
          style: context.bodyTextStyle()?.copyWith(
                color: AppColors.subTitleColor,
                fontSize: 14,
              ),
        ),
      ),
    );
  }
}
