import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class DetailPlaylistDescription extends StatelessWidget {
  const DetailPlaylistDescription({
    Key? key,
    this.description,
  }) : super(key: key);

  final String? description;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: description?.isNotEmpty ?? false
          ? Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.t_description,
                    style: context.bodyTextPrimaryStyle()!.copyWith(
                          color: AppColors.subTitleColor,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    description ?? '',
                    style: context.bodyTextPrimaryStyle()!.copyWith(
                          color: AppColors.subTitleColor,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
