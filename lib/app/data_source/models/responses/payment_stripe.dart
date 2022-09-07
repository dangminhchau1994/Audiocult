import '../../../base/index_walker.dart';

class PaymentStripe {
  String? status;
  String? stripeConnectedAccountId;
  String? stripeMerchantCountry;
  String? stripePubkey;

  PaymentStripe({this.status, this.stripeConnectedAccountId, this.stripeMerchantCountry, this.stripePubkey});

  PaymentStripe.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);

    status = iw['status'].get();
    stripeConnectedAccountId = iw['stripe_connected_account_id'].get();
    stripeMerchantCountry = iw['stripe_merchant_country'].get();
    stripePubkey = iw['stripe_pubkey'].get();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['stripe_connected_account_id'] = stripeConnectedAccountId;
    data['stripe_merchant_country'] = stripeMerchantCountry;
    data['stripe_pubkey'] = stripePubkey;
    return data;
  }
}
