import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/datetime/date_time_utils.dart';
import '../../../utils/route/app_route.dart';
import '../../profile/profile_screen.dart';

class FeedItemUserInfo extends StatelessWidget {
  const FeedItemUserInfo({
    Key? key,
    this.data,
  }) : super(key: key);

  final FeedResponse? data;

  String getFriendTagged(FeedResponse data) {
    if (data.friendsTagged != null) {
      final otherFriends = data.friendsTagged!.length > 1 ? '${data.friendsTagged!.length - 1} others' : '';
      final friendTagged = data.friendsTagged!.length > 1 ? ' and $otherFriends' : '';
      return data.friendsTagged!.isNotEmpty ? 'with ${data.friendsTagged?[0].fullName} $friendTagged' : '';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoute.routeProfile,
              arguments: ProfileScreen.createArguments(id: data!.userId!),
            );
          },
          child: CachedNetworkImage(
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
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  RichText(
                    text: TextSpan(
                      style: context.buttonTextStyle()!.copyWith(fontSize: 16, color: Colors.white),
                      children: [
                        TextSpan(
                          text: data?.userName ?? '',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.routeProfile,
                                arguments: ProfileScreen.createArguments(id: data!.userId!),
                              );
                            },
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(text: data?.feedInfo ?? ''),
                        const TextSpan(text: ' '),
                        TextSpan(text: getFriendTagged(data!)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: data?.locationName != null,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'at ',
                            style: context.buttonTextStyle()!.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                          ),
                          TextSpan(
                            text: data?.locationName,
                            style: context.buttonTextStyle()!.copyWith(
                                  fontSize: 16,
                                  color: AppColors.primaryButtonColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    DateTimeUtils.convertToAgo(int.tryParse(data?.timeStamp ?? '0') ?? 0),
                    style: context.buttonTextStyle()!.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(width: 8),
                  _buildPrivacyIcon()
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyIcon() {
    switch (data?.getFeedPrivacy()) {
      case FeedPrivacy.everyone:
        return Image.asset(
          AppAssets.icPublic,
          width: 16,
        );
      case FeedPrivacy.subscriptions:
        return Image.asset(
          AppAssets.icSubscription,
          width: 16,
        );
      case FeedPrivacy.friend:
        return Image.asset(
          AppAssets.icFriends,
          width: 16,
        );
      case FeedPrivacy.onlyme:
        return Image.asset(
          AppAssets.icLock,
          width: 16,
        );
      // ignore: no_default_cases
      default:
        return Container();
    }
  }
}
