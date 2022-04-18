import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyDiaryEventWidget extends StatelessWidget {
  final EventResponse event;
  final VoidCallback? onTapped;

  const MyDiaryEventWidget(this.event, {this.onTapped, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WButtonInkwell(
      onPressed: onTapped,
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            _imageWidget(),
            const SizedBox(width: 10),
            _infoWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _imageWidget() {
    return SizedBox(
      width: 60,
      height: 60,
      child: CachedNetworkImage(
        imageUrl: event.imagePath ?? '',
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        errorWidget: (_, __, ___) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: const DecorationImage(image: AssetImage(AppAssets.imagePlaceholder), fit: BoxFit.cover),
          ),
        ),
        placeholder: (_, __) {
          return Center(
            child: SizedBox(
              height: 30,
              child: CircularProgressIndicator(color: AppColors.primaryButtonColor),
            ),
          );
        },
      ),
    );
  }

  Widget _infoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title ?? '',
          style: context.body1TextStyle(),
        ),
        const SizedBox(height: 4),
        Text(
          event.getFormatedDateTime().toUpperCase(),
          style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor),
        ),
      ],
    );
  }
}
