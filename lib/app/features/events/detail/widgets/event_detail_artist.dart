import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class ArtistLineUp extends StatelessWidget {
  const ArtistLineUp({
    Key? key,
    this.data,
  }) : super(key: key);

  final EventResponse? data;

  @override
  Widget build(BuildContext context) {
    return data?.lineup?.artist != null
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalSpacing,
              vertical: kVerticalSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.t_artist_lineup,
                  style: context.bodyTextPrimaryStyle()!.copyWith(
                        color: AppColors.subTitleColor,
                        fontSize: 16,
                      ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 25,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 8 / 2,
                  children: data!.lineup!.artist!
                      .map(
                        (e) => Row(
                          children: [
                            CachedNetworkImage(
                              width: 50,
                              height: 50,
                              imageUrl: e.userImage ?? '',
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
                            const SizedBox(width: 20),
                            Text(
                              e.fullName ?? '',
                              style: context.bodyTextPrimaryStyle()!.copyWith(
                                    color: AppColors.unActiveLabelItem,
                                    fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
