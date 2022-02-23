import 'package:audio_cult/app/app.dart';
import 'package:audio_cult/bootstrap.dart';

import 'app/utils/flavor/flavor.dart';
import 'global.dart';

void main() {
  bootstrap(
    () => MyGlobal(
      flavorConfig: FlavorConfig(flavor: Flavor.dev, values: FlavorValues(mainUrl: 'http://staging.audiocult.net')),
      child: const App(),
    ),
  );
}
