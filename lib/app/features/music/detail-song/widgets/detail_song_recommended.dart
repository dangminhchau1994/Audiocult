import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_item.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../utils/constants/app_colors.dart';

class DetailSongRecommeded extends StatelessWidget {
  const DetailSongRecommeded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songs = [
      Song(
        title: 'Abyss',
        imagePath: 'https://staging-media.audiocult.net/file/pic/music/2021/04/1a9284a03cd8aee00cd1e86e84eec8f5.jpg',
        artistUser: ArtistUser(userName: 'dronevndope'),
        timeStamp: '1619664556',
      ),
      Song(
        title: 'Abyss',
        imagePath: 'https://staging-media.audiocult.net/file/pic/music/2021/04/1a9284a03cd8aee00cd1e86e84eec8f5.jpg',
        artistUser: ArtistUser(userName: 'dronevndope'),
        timeStamp: '1619664556',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.t_recommended_song,
                style: context.buttonTextStyle()!.copyWith(
                      fontSize: 18,
                    ),
              ),
              WButtonInkwell(
                onPressed: () {},
                child: Text(
                  'Find more',
                  style: context.bodyTextPrimaryStyle()!.copyWith(
                        fontSize: 16,
                        color: AppColors.lightBlue,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),
            child: ListView.separated(
              itemCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => SongItem(
                song: songs[index],
                fromDetail: true,
                hasMenu: true,
              ),
              separatorBuilder: (context, index) => const Divider(height: 40),
            ),
          ),
        ],
      ),
    );
  }
}
