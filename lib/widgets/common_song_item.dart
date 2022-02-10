import 'package:flutter/material.dart';

class CommonSongItem extends StatelessWidget {
  const CommonSongItem({
    Key? key,
    this.imageUrl,
    this.title,
    this.subTitle,
    this.showMenu,
  }) : super(key: key);

  final String? imageUrl;
  final String? title;
  final String? subTitle;
  final bool? showMenu;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
