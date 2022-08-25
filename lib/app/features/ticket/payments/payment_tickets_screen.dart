import 'package:audio_cult/app/data_source/models/responses/productlist/productlist.dart';
import 'package:audio_cult/app/features/ticket/payments/ticket_cart_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';
import 'payment_tickets_bloc.dart';

class PaymentTicketsScreen extends StatefulWidget {
  final Map<String, dynamic> params;

  const PaymentTicketsScreen({Key? key, required this.params}) : super(key: key);
  static Map<String, dynamic> createArguments(
          {required String eventId,
          required String userName,
          required TicketProductList? cart,
          required String eventName}) =>
      {'event_id': eventId, 'user_name': userName, 'cart': cart, 'event_name': eventName};

  @override
  State<PaymentTicketsScreen> createState() => _PaymentTicketsScreenState();
}

class _PaymentTicketsScreenState extends State<PaymentTicketsScreen> {
  final PaymentTicketsBloc _paymentTicketsBloc = PaymentTicketsBloc(locator.get());
  TicketProductList? cart;
  @override
  void initState() {
    super.initState();
    cart = widget.params['cart'] as TicketProductList?;
    _paymentTicketsBloc.getListPaymentTickets(
        widget.params['event_id'] as String, widget.params['user_name'] as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: const CommonAppBar(title: 'Check out'),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(widget.params['event_name'] as String,
                      style: context.bodyTextStyle()?.copyWith(color: AppColors.activeLabelItem, fontSize: 24)),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(cart?.dateRange ?? '')
                ],
              ),
              const Divider(
                color: Colors.white,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.routeTicketCart,
                      arguments: TicketCartScreen.createArguments(cart: cart));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColors.cartColor, borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Your cart',
                          style: context.body1TextStyle()?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded)
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}
