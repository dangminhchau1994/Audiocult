import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';

import 'payment_tickets_bloc.dart';

class PaymentTicketsScreen extends StatefulWidget {
  final Map<String, dynamic> params;

  const PaymentTicketsScreen({Key? key, required this.params}) : super(key: key);
  static Map<String, dynamic> createArguments({required String eventId, required String userName}) =>
      {'event_id': eventId, 'user_name': userName};

  @override
  State<PaymentTicketsScreen> createState() => _PaymentTicketsScreenState();
}

class _PaymentTicketsScreenState extends State<PaymentTicketsScreen> {
  final PaymentTicketsBloc _paymentTicketsBloc = PaymentTicketsBloc(locator.get());

  @override
  void initState() {
    super.initState();
    _paymentTicketsBloc.getListPaymentTickets(
        widget.params['event_id'] as String, widget.params['user_name'] as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const CommonAppBar(title: 'Check out'), body: Container());
  }
}
