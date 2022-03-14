import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_comment.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_description.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_navbar.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_photo.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_play_button.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_recommended.dart';
import 'package:audio_cult/app/features/music/detail-song/widgets/detail_song_title.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';

class DetailSongScreen extends StatefulWidget {
  const DetailSongScreen({Key? key}) : super(key: key);

  @override
  State<DetailSongScreen> createState() => _DetailSongScreenState();
}

class _DetailSongScreenState extends State<DetailSongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: const [
                //Photo
                DetailPhotoSong(),
                //Navbar
                DetailSongNavBar(),
                //Title
                DetailSongTitle(),
                // Play Button
                DetailSongPlayButton(),
              ],
            ),
            //Description
            const DetailSongDescription(),
            //Comment
            const DetailSongComment(),
            //Recommended Songs
            const DetailSongRecommeded(),
          ],
        ),
      ),
    );
  }
}
