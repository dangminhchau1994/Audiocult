import 'package:flutter/material.dart';

import '../../../utils/constants/app_dimens.dart';

class MyAlbum extends StatelessWidget {
  const MyAlbum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kHorizontalSpacing,
        vertical: kVerticalSpacing,
      ),
      // child: ListView.separated(
      //   shrinkWrap: true,
      //   itemCount: songs.length,
      //   separatorBuilder: (context, index) => const SizedBox(height: 24),
      //   itemBuilder: (context, index) {
      //     return Container();
      //   },
      // ),
    );
  }
}
