import 'package:audio_cult/app/features/music/detail_playlist/detail_playlist_bloc.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';

import '../../../../data_source/models/responses/song/song_response.dart';
import '../../../../utils/route/app_route.dart';
import '../../../player_widgets/player_screen.dart';

class DetailPlayListPlayButton extends StatefulWidget {
  const DetailPlayListPlayButton({
    Key? key,
    this.detailPlayListBloc,
  }) : super(key: key);

  final DetailPlayListBloc? detailPlayListBloc;

  @override
  State<DetailPlayListPlayButton> createState() => _DetailPlayListPlayButtonState();
}

class _DetailPlayListPlayButtonState extends State<DetailPlayListPlayButton> {
  List<Song> songs = [];
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    widget.detailPlayListBloc?.getSongByIdStream.listen((event) {
      event.when(
        success: (success) {
          setState(() {
            songs = success as List<Song>;
          });
        },
        loading: () {},
        error: (_) {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 280,
      right: 30,
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
          child: const Icon(
            Icons.play_arrow,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
