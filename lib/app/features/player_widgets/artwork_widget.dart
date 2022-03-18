import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../audio_player/audio_player.dart';
import '../audio_player/queue_state.dart';

class ArtWorkWidget extends StatefulWidget {
  final GlobalKey<FlipCardState> cardKey;
  final MediaItem mediaItem;
  final AudioPlayerHandler audioHandler;
  final double width;
  const ArtWorkWidget({
    Key? key,
    required this.cardKey,
    required this.mediaItem,
    required this.audioHandler,
    required this.width,
  }) : super(key: key);

  @override
  State<ArtWorkWidget> createState() => _ArtWorkWidgetState();
}

class _ArtWorkWidgetState extends State<ArtWorkWidget> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'currentArtwork',
      child: FlipCard(
        key: widget.cardKey,
        flipOnTouch: false,
        back: Container(),
        front: StreamBuilder<QueueState>(
          stream: widget.audioHandler.queueState,
          builder: (context, snapshot) {
            // final queueState = snapshot.data ?? QueueState.empty;
            return Stack(
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (BuildContext context, _, __) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/cover.jpg'),
                    ),
                    placeholder: (BuildContext context, _) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/cover.jpg'),
                    ),
                    imageUrl: widget.mediaItem.artUri.toString(),
                    height: widget.width * 0.9,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
