import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

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
