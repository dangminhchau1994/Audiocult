import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/detail_album/detail_album_bloc.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';

import '../../../../utils/route/app_route.dart';
import '../../../player_widgets/player_screen.dart';

class DetailAlbumPlayButton extends StatefulWidget {
  final DetailAlbumBloc? albumBloc;
  const DetailAlbumPlayButton({Key? key, this.albumBloc}) : super(key: key);

  @override
  State<DetailAlbumPlayButton> createState() => _DetailAlbumPlayButtonState();
}

class _DetailAlbumPlayButtonState extends State<DetailAlbumPlayButton> {
  List<Song> songs = [];
  bool isPlay = false;
  @override
  void initState() {
    super.initState();
    widget.albumBloc!.getSongByIdStream.listen((event) {
      event.when(
          success: (success) {
            setState(() {
              songs = success as List<Song>;
            });
          },
          loading: () {},
          error: (_) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 276,
      end: 30,
      child: WButtonInkwell(
        onPressed: () {
          // ignore: cast_nullable_to_non_nullable
          if (songs.isNotEmpty) {
            setState(() {
              isPlay = true;
            });
            Navigator.pushNamed(
              context,
              AppRoute.routePlayerScreen,
              arguments: PlayerScreen.createArguments(listSong: songs, index: 0),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            !isPlay ? Icons.play_arrow : Icons.pause,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
