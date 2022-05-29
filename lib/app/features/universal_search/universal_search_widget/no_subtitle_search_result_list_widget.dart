import 'package:audio_cult/app/data_source/models/universal_search/no_subtitle_universal_search_item.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NoSubtitleSearchResultListWidget extends StatelessWidget {
  final String headerTitle;
  final List<NoSubtitleUniversalSearchItem> results;

  const NoSubtitleSearchResultListWidget({
    required this.headerTitle,
    required this.results,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(headerTitle, style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor)),
        const SizedBox(height: 12),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: results.length,
          shrinkWrap: true,
          itemBuilder: (_, index) => _resultWidget(context, results[index]),
        ),
      ],
    );
  }

  Widget _resultWidget(BuildContext context, NoSubtitleUniversalSearchItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          _imageWidget(item.imageUrl),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: context.body1TextStyle()),
              const SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageWidget(String imageUrl) {
    return CachedNetworkImage(
      width: 50,
      height: 50,
      placeholder: (_, __) => const LoadingWidget(),
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      imageBuilder: (_, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider),
          shape: BoxShape.circle,
        ),
      ),
      errorWidget: (_, __, ___) => const Image(
        image: AssetImage(AppAssets.imagePlaceholder),
        fit: BoxFit.cover,
      ),
    );
  }
}
