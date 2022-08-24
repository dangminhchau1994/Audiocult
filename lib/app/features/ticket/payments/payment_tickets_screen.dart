import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';

class PaymentTicketsScreen extends StatefulWidget {
  const PaymentTicketsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentTicketsScreen> createState() => _PaymentTicketsScreenState();
}

class _PaymentTicketsScreenState extends State<PaymentTicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const CommonAppBar(title: 'Check out'), body: Container());
  }
}
