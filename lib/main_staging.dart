import 'package:audio_cult/app/app.dart';
import 'package:audio_cult/bootstrap.dart';

import 'app/utils/flavor/flavor.dart';
import 'global.dart';

void main() {
  bootstrap(
    () => MyGlobal(
      flavorConfig: FlavorConfig(
        flavor: Flavor.staging,
        values: FlavorValues(mainUrl: 'http://staging.audiocult.net', placeUrl: 'https://maps.googleapis.com'),
      ),
      child: const App(),
    ),
  );
}
