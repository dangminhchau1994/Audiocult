import 'package:audio_cult/app/data_source/models/responses/event_invitation/event_invitation_response.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/checkbox/common_checkbox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InviteFriendItem extends StatelessWidget {
  const InviteFriendItem({
    Key? key,
    this.data,
    this.onChecked,
  }) : super(key: key);

  final EventInvitationResponse? data;
  final Function(EventInvitationResponse data, bool isChecked)? onChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.inputFillColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                width: 50,
                height: 50,
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
              const SizedBox(height: 4),
              Text(
                data?.fullName ?? '',
                style: context.bodyTextPrimaryStyle()!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                data?.isInvisible ?? '',
                style: context.bodyTextPrimaryStyle()!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Visibility(
              visible: data?.isActive == null,
              child: CommonCheckbox(
                isChecked: data?.isChecked,
                onChanged: (value) {
                  onChecked!(data!, value);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
