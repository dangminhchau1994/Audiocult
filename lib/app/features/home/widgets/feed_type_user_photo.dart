import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/loading/loading_widget.dart';

class FeedTypeUserPhoto extends StatelessWidget {
  const FeedTypeUserPhoto({
    Key? key,
    this.feedImageUrl,
  }) : super(key: key);

  final List<String>? feedImageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: feedImageUrl?[0] ?? '',
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
          child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(minHeight: 50),
        child: const LoadingWidget(),
      )),
      errorWidget: (
        BuildContext context,
        _,
        __,
      ) =>
          const Image(
        fit: BoxFit.cover,
        image: AssetImage(
          'assets/cover.jpg',
        ),
      ),
    );
  }
}
