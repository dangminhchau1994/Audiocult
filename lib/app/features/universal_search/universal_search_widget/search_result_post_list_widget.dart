import 'dart:math';

import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:tuple/tuple.dart';

class SearchResultPostListWidget extends StatelessWidget {
  const SearchResultPostListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
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
                _contentPost(context),
                const SizedBox(height: 16),
                _imagePost(),
              ],
            ),
          );
        },
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
      imageUrl:
          'https://staging-media.audiocult.net/file/pic/user/2022/05/1c3481046850d5013cc747291f134c4e_200_square.jpg',
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
            'AudiocultAudiocultAudiocultAudiocultAudiocultAudiocultAudiocultAudiocultAudiocultAudiocult',
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

  Widget _contentPost(BuildContext context) {
    // TODO: need to update later. currently not correct
    const keyword = 'risus';
    const string =
        'Quam est risus aenean sit in facilisis odio. A sagittis, nulla viverra a aliquam dictumst lectus urna. Ante eget euismod purus tellus, eget sit. Id phasellus mauris.';
    final textList = string.split(' ').toList();
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
            background: Paint()..color = keyword == e ? Colors.amber : Colors.transparent,
          ),
        );
      }).toList()),
    );
  }

  Widget _imagePost() {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: 'https://i.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      imageBuilder: (_, imageProvider) {
        return Container(
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(maxHeight: 350, minHeight: 200),
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
