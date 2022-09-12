import 'package:audio_cult/app/features/ticket/payments/payment_tickets_bloc.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../utils/toast/toast_utils.dart';

class CardPaymentPage extends StatefulWidget {
  final PaymentTicketsBloc? bloc;
  final String? username;
  final String? eventId;
  const CardPaymentPage({Key? key, this.bloc, this.eventId, this.username}) : super(key: key);

  @override
  State<CardPaymentPage> createState() => CardPaymentPageState();
}

class CardPaymentPageState extends State<CardPaymentPage> {
  final CardEditController _cardEditController = CardEditController();
  PaymentMethod? _paymentMethod;

  bool isDone() {
    final isCompleted = _cardEditController.complete;
    if (!isCompleted) {
      ToastUtility.showPending(context: context, message: 'Please fill card');
      return false;
    }
    return isCompleted;
  }

  Future<PaymentMethod> submitToStripe(Map<String, dynamic> data) async {
    if (_paymentMethod == null) {
      final billingDetails = BillingDetails(
        email: data['email'] as String,
        phone: data['phone'] as String,
        name: '${data['name_parts_0'] + data['name_parts_1']}',
      ); // mocked data for tests
      final result = await widget.bloc!.getStripeAccount(widget.username, widget.eventId);
      if (result != null) {
        Stripe.publishableKey = result.stripePubkey!;
      }
      _paymentMethod = await Stripe.instance.createPaymentMethod(
          PaymentMethodParams.card(paymentMethodData: PaymentMethodData(billingDetails: billingDetails)),
          {'stripeAccountId': result?.stripeConnectedAccountId ?? ''});
    }

    return _paymentMethod!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: _paymentMethod == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Please select how you want to pay.'),
                ),
                CardField(
                  controller: _cardEditController,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                      'Your payment will be processed by Stripe, Inc. Your credit card data will be transmitted directly to Stripe and never touches our servers.'),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('You already entered a card number that we will use to charge the payment amount.'),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _paymentMethod = null;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        'Use a different card',
                        style: context.bodyTextStyle()?.copyWith(color: Colors.black),
                      )),
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
    );
  }
}
