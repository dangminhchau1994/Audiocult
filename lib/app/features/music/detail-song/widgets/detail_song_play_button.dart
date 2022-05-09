import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';

import '../../../../data_source/models/responses/song/song_response.dart';
import '../../../../utils/route/app_route.dart';
import '../../../player_widgets/player_screen.dart';

class DetailSongPlayButton extends StatefulWidget {
  const DetailSongPlayButton({
    Key? key,
    this.song,
  }) : super(key: key);

  final Song? song;

  @override
  State<DetailSongPlayButton> createState() => _DetailSongPlayButtonState();
}

class _DetailSongPlayButtonState extends State<DetailSongPlayButton> {
  final List<Song>? songs = [];
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    songs?.add(widget.song ?? Song());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250,
      right: 30,
      child: WButtonInkwell(
        onPressed: () {
          if (songs!.isNotEmpty) {
            setState(() {
              isPlay = true;
            });
            Navigator.pushNamed(
              context,
              AppRoute.routePlayerScreen,
              arguments: PlayerScreen.createArguments(listSong: songs!, index: 0),
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
