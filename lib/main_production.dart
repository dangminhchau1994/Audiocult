import 'package:audio_cult/app/app.dart';
import 'package:audio_cult/bootstrap.dart';

import 'app/utils/flavor/flavor.dart';
import 'global.dart';

void main() {
  bootstrap(
    () => MyGlobal(
      flavorConfig: FlavorConfig(
        flavor: Flavor.production,
        values: FlavorValues(
            stripePubkey: StripePaymentPublicKey.keyPro,
            mainUrl: 'https://audiocult.net',
            placeUrl: 'https://maps.googleapis.com',
            ticketUrl: 'https://tickets.audiocult.net'),
      ),
      child: const App(),
    ),
  );
}
