import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UniversalSearchResultPostItemWidget extends StatelessWidget {
  final String avatarUrl;
  final String content;
  final String imageUrl;

  const UniversalSearchResultPostItemWidget({
    required this.avatarUrl,
    required this.content,
    required this.imageUrl,
    Key? key,
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
          _topHeader(context),
          const SizedBox(height: 16),
          _contentWidget(context),
          const SizedBox(height: 16),
          _imageWidget(),
        ],
      ),
    );
  }

  Widget _topHeader(BuildContext context) {
    return Row(
      children: [
        _avatarWidget(),
        const SizedBox(width: 12),
        _titleWidget(context),
        TextButton(
          onPressed: () {},
          child: SvgPicture.asset(AppAssets.verticalIcon),
        )
      ],
    );
  }

  Widget _avatarWidget() {
    return CachedNetworkImage(
      imageUrl: avatarUrl,
      imageBuilder: (_, image) {
        return Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            image: DecorationImage(image: image),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  Widget _titleWidget(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Name',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'two hours ago',
            style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _contentWidget(BuildContext context) {
    const keyword = '123';
    final textList = content.split(' ').toList();
    return Text.rich(
      TextSpan(
          children: textList.map((e) {
        return TextSpan(
          text: keyword == e
              ? keyword
              : (e == textList.first
                  ? '$e '
                  : e == textList.last
                      ? ' $e'
                      : ' $e '),
          style: TextStyle(
            background: Paint()..color = Colors.transparent,
          ),
        );
      }).toList()),
    );
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
