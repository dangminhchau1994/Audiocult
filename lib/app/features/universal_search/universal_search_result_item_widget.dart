import 'dart:async';

import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/extensions/string_extension.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tuple/tuple.dart';
import 'dart:ui' as ui;

class UniversalSearchResultItemWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final UniversalSearchItem searchItem;

  final String? queryString;

  const UniversalSearchResultItemWidget(
    this.searchItem, {
    this.onTap,
    this.queryString,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avatarWidget(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleWidget(),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _subtitleWidget(context),
                      const SizedBox(width: 8),
                      _timeWidget(context),
                    ],
                  ),
                ],
              ),
            ),
            _imageWidget(),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Text.rich(
      TextSpan(
        children: searchItem.itemTitle?.highlightOccurrences(queryString ?? ''),
      ),
    );
  }

  Widget _subtitleWidget(BuildContext context) {
    return Text(
      searchItem.itemName ?? '',
      style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _timeWidget(BuildContext context) {
    if (searchItem.itemTimedStamp?.isNotEmpty == true) {
      return Text(
        DateTimeUtils.formatyMMMMd(
          int.parse(searchItem.itemTimedStamp!),
        ),
        style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor),
      );
    }
    return Container();
  }

  Widget _avatarWidget() {
    return CachedNetworkImage(
      width: 50,
      height: 50,
      imageUrl: searchItem.userImage ?? '',
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

  Widget _imageWidget() {
    if (searchItem.itemDisplayPhoto?.isNotEmpty == true) {
      return Container(
        constraints: const BoxConstraints(maxHeight: 120, maxWidth: 100),
        child: Html(data: searchItem.itemDisplayPhoto),
      );
    }
    return Container();
  }
}
