import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';

class PlaceLocation extends StatefulWidget {
  const PlaceLocation({Key? key}) : super(key: key);

  @override
  State<PlaceLocation> createState() => _PlaceLocationState();
}

class _PlaceLocationState extends State<PlaceLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: context.localize.t_search_your_location),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
