import 'package:audio_cult/app/app.dart';
import 'package:audio_cult/bootstrap.dart';

import 'app/utils/flavor/flavor.dart';
import 'global.dart';

void main() {
  bootstrap(
    () => MyGlobal(
      flavorConfig: FlavorConfig(
        flavor: Flavor.production,
        values: FlavorValues(mainUrl: 'http://production.com', placeUrl: 'https://maps.googleapis.com'),
      ),
      child: const App(),
    ),
  );
}
