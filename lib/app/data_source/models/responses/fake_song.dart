class FakeSong {
  final String? title;
  final String? date;
  final String? imageUrl;

  const FakeSong({
    this.title,
    this.date,
    this.imageUrl,
  });

  static List<FakeSong> generateSongs() {
    return const [
      FakeSong(
        title: 'Abyss',
        imageUrl: 'https://staging-media.audiocult.net/file/pic/music/2021/04/1a9284a03cd8aee00cd1e86e84eec8f5.jpg',
        date: 'May 7 2021',
      ),
      FakeSong(
        title: '"LOVE (Extended Version) D# 138bpm',
        imageUrl: 'https://staging-media.audiocult.net/file/pic/music/2021/05/d1c96f0a3d590ff25d125a2f075009da.jpg',
        date: 'May 7 2021',
      ),
      FakeSong(
        title: 'In Control',
        imageUrl: 'https://staging-media.audiocult.net/file/pic/music/2021/04/6d3dec21a750b0badf5559acb67117d7.jpg',
        date: 'May 7 2021',
      ),
    ];
  }

  static List<FakeSong> generateAlbums() {
    return const [
      FakeSong(
        title: 'ManMadeMan',
        imageUrl:
            'https://staging-media.audiocult.net/file/pic/music/2021/10/8c0abfc4cb3503bae716fd95f9549058_200_square.jpg',
        date: 'May 7 2021',
      ),
      FakeSong(
        title: 'ManMadeMan',
        imageUrl:
            'https://staging-media.audiocult.net/file/pic/music/2021/10/8c0abfc4cb3503bae716fd95f9549058_200_square.jpg',
        date: 'May 4 2021',
      ),
    ];
  }
}
