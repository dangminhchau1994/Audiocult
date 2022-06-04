import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/string_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UniversalSearchResultPostItemWidget extends StatelessWidget {
  final String avatarUrl;
  final String content;
  final String imageUrl;
  final String? queryString;

  const UniversalSearchResultPostItemWidget({
    required this.avatarUrl,
    required this.content,
    required this.imageUrl,
    Key? key,
    this.queryString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.secondaryButtonColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _contentWidget(context),
          const SizedBox(height: 16),
          _imageWidget(),
        ],
      ),
    );
  }

  Widget _contentWidget(BuildContext context) {
    return Text.rich(TextSpan(
      children: content.highlightOccurrences(queryString ?? ''),
    ));
  }

  Widget _imageWidget() {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      errorWidget: (_, __, ___) => Container(),
      imageBuilder: (_, imageProvider) {
        return Container(
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(maxHeight: 300, minHeight: 200),
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
          ),
        );
      },
    );
  }
}
