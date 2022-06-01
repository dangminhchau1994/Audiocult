import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentSearchListWidget extends StatelessWidget {
  final String? title;
  final List<String> recentKeywords;

  const RecentSearchListWidget({
    required this.title,
    required this.recentKeywords,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? context.l10n.t_recent_search,
          style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentKeywords.length,
          shrinkWrap: true,
          itemBuilder: (_, index) => _listItemWidget(recentKeywords[index]),
        ),
      ],
    );
  }

  Widget _listItemWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.timeIcon),
          const SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}
