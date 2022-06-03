import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UniversalSearchResultItemWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String? keyword;

  const UniversalSearchResultItemWidget({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.keyword,
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
                  // Text(
                  //   title,
                  //   softWrap: false,
                  //   maxLines: 1,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: context.body1TextStyle(),
                  // ),
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
      TextSpan(children: highlightOccurrences(title, keyword ?? '')),
    );
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    var lastMatchEnd = 0;

    final children = <TextSpan>[];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(background: Paint()..color = AppColors.inputFillColor),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
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
