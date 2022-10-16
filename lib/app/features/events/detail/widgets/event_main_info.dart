import 'dart:typed_data';

import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_artist.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_description.dart';
import 'package:audio_cult/app/features/events/detail/widgets/event_detail_map.dart';
import 'package:flutter/material.dart';

class EventMainInfo extends StatelessWidget {
  const EventMainInfo({
    Key? key,
    this.data,
    this.iconMarker,
  }) : super(key: key);

  final EventResponse? data;
  final Uint8List? iconMarker;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArtistLineUp(data: data),
        EventDetailDescription(data: data),
        EventDetailMap(iconMarker: iconMarker, data: data)
      ],
    );
  }
}
