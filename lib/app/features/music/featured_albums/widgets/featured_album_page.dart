import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:flutter/material.dart';

import '../../discover/widgets/song_item.dart';

class FeaturedAlbumPage extends StatelessWidget {
  const FeaturedAlbumPage({
    Key? key,
    this.onPageChange,
    this.pageController,
    this.onRetry,
  }) : super(key: key);

  final Function(int index)? onPageChange;
  final Function()? onRetry;
  final PageController? pageController;

  List<Song> getSongs() {
    return [
      Song(
        title: 'mua la dau',
        artistUser: ArtistUser(userName: 'chau dang'),
        timeStamp: '1619664556',
        imagePath: 'https://ctmobile.vn/upload/dims.jpg',
      ),
      Song(
        title: 'mua la dau',
        artistUser: ArtistUser(userName: 'chau dang'),
        timeStamp: '1619664556',
        imagePath: 'https://ctmobile.vn/upload/dims.jpg',
      ),
      Song(
        title: 'mua la khoai',
        artistUser: ArtistUser(userName: 'chau minh'),
        timeStamp: '1619664556',
        imagePath: 'https://ctmobile.vn/upload/dims.jpg',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 196,
      child: PageView.builder(
        onPageChanged: onPageChange,
        controller: pageController,
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: getSongs().length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final songs = getSongs();

              return SongItem(
                song: songs[index],
                onMenuClick: () {},
              );
            },
          );
        },
      ),
    );
  }
}
