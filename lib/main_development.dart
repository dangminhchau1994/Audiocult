import 'package:audio_cult/app/app.dart';
import 'package:audio_cult/bootstrap.dart';

import 'app/utils/flavor/flavor.dart';
import 'global.dart';

void main() async {
  await bootstrap(
    () => MyGlobal(
      flavorConfig: FlavorConfig(
        flavor: Flavor.dev,
        values: FlavorValues(
            stripePubkey: StripePaymentPublicKey.keyTest,
            mainUrl: 'http://staging.audiocult.net',
            placeUrl: 'https://maps.googleapis.com',
            ticketUrl: 'https://tickets.staging.audiocult.net'),
      ),
      child: const App(),
    ),
  );
}
