import 'package:audio_cult/app/app.dart';
import 'package:audio_cult/bootstrap.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/utils/flavor/flavor.dart';
import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await bootstrap(
    () => MyGlobal(
      flavorConfig: FlavorConfig(
        flavor: Flavor.dev,
        values: FlavorValues(
          mainUrl: 'http://staging.audiocult.net',
          placeUrl: 'https://maps.googleapis.com',
        ),
      ),
      child: const App(),
    ),
  );
}
