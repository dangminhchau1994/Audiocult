import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/extensions/string_extension.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UniversalSearchResultItemWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String? queryString;

  const UniversalSearchResultItemWidget({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.queryString,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            _imageWidget(imageUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _titleWidget(),
                  const SizedBox(height: 4),
                  Text(
                    subtitle.toUpperCase(),
                    style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Text.rich(
      TextSpan(children: title.highlightOccurrences(queryString ?? '')),
    );
  }

  Widget _imageWidget(String imageUrl) {
    return CachedNetworkImage(
      width: 70,
      height: 70,
      imageUrl: imageUrl,
      imageBuilder: (_, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      fit: BoxFit.cover,
      errorWidget: (_, __, ___) => const Image(
        image: AssetImage(AppAssets.imagePlaceholder),
        fit: BoxFit.cover,
      ),
      placeholder: (_, __) => const LoadingWidget(),
    );
  }
}
