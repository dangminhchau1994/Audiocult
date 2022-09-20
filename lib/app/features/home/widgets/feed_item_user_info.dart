import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/reg/reg_util.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../data_source/models/responses/profile_data.dart';
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

  String otherFriends(FeedResponse data, BuildContext context) {
    if (data.friendsTagged != null && int.parse(data.totalFriendsTagged ?? '') > 1) {
      return '${data.totalFriendsTagged} ${context.localize.t_others}';
    }
    return '';
  }

  String friendTagged(FeedResponse data, BuildContext context) {
    if (data.friendsTagged != null) {
      return data.friendsTagged?[0].fullName ?? '';
    }
    return '';
  }

  int otherFriendCount() {
    return data?.friendsTagged?.length ?? 0;
  }

  bool isUserBlocked() {
    return data?.friendsTagged?[0].isBlocked ?? false;
  }

  List<ProfileData> getOthers(FeedResponse data) {
    if (data.friendsTagged != null) {
      return data.friendsTagged!.getRange(1, data.friendsTagged!.length).toList();
    }
    return [];
  }

  void _showDialog(BuildContext context, List<ProfileData> users) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 600,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.secondaryButtonColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: ListView.separated(
          itemCount: users.length,
          separatorBuilder: (context, index) => const Divider(height: 10),
          itemBuilder: (context, index) {
            return WButtonInkwell(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoute.routeProfile,
                  arguments: ProfileScreen.createArguments(
                    id: users[index].userId ?? '',
                  ),
                );
              },
              child: Row(
                children: [
                  CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: users[index].userImage ?? '',
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
                  const SizedBox(width: 16),
                  Text(
                    users[index].fullName ?? '',
                    style: context.bodyTextPrimaryStyle()!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
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
                        TextSpan(text: RegUtils.replaceHtml(data?.feedInfo ?? '')),
                        const TextSpan(text: ' '),
                        TextSpan(text: otherFriendCount() > 0 ? context.localize.t_with.toLowerCase() : ''),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: friendTagged(data!, context),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.routeProfile,
                                arguments: ProfileScreen.createArguments(id: data?.friendsTagged?[0].userId ?? ''),
                              );
                            },
                          style: TextStyle(
                            color: isUserBlocked() ? Colors.grey : AppColors.lightBlue,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(text: otherFriendCount() > 1 ? context.localize.t_and.toLowerCase() : ''),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: otherFriends(data!, context),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _showDialog(
                                context,
                                getOthers(data!),
                              );
                            },
                          style: TextStyle(color: AppColors.lightBlue, fontSize: 16),
                        ),
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
                            text: data?.locationName?.isNotEmpty ?? false ? '${context.localize.t_at.toLowerCase()} ' : '',
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
