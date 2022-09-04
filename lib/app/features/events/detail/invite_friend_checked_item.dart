import 'package:audio_cult/app/data_source/models/responses/event_invitation/event_invitation_response.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';

class InviteFriendCheckedItem extends StatelessWidget {
  const InviteFriendCheckedItem({
    Key? key,
    this.onChecked,
    this.data,
  }) : super(key: key);

  final Function(EventInvitationResponse data)? onChecked;
  final EventInvitationResponse? data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          width: 56,
          height: 56,
          imageUrl: data?.userImage ?? '',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryButtonColor,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.inputFillColor,
              shape: BoxShape.circle,
            ),
            child: WButtonInkwell(
              onPressed: () {
                onChecked!(data!);
              },
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.close,
                  size: 20,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
