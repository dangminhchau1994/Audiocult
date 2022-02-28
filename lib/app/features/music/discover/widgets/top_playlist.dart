import 'package:audio_cult/app/features/music/discover/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'album_item.dart';

class TopPlaylist extends StatelessWidget {
  const TopPlaylist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Top of Playlists',
          ),
          const SizedBox(
            height: 16,
          ),
          // SizedBox(
          //   height: 278,
          //   child: ListView.separated(
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) => AlbumItem(album: topPlaylists?[index]),
          //     separatorBuilder: (context, index) => const SizedBox(width: 16),
          //     itemCount: topPlaylists?.length ?? 0,
          //   ),
          // )
        ],
      ),
    );
  }
}
