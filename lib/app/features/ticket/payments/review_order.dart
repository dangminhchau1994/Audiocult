import 'package:audio_cult/app/features/ticket/payments/infor_page.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../data_source/models/responses/productlist/productlist.dart';
import 'ticket_cart_screen.dart';

class ReviewOrderPage extends StatefulWidget {
  const ReviewOrderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewOrderPage> createState() => ReviewOrderPageState();
}

class ReviewOrderPageState extends State<ReviewOrderPage> {
  TicketProductList? _cart;
  PaymentMethod? _paymentMethod;
  Map<String, dynamic>? _dataStep1;

  void updateData(TicketProductList? cart, PaymentMethod? paymentMethod, Map<String, dynamic> dataStep1) {
    setState(() {
      _cart = cart;
      _paymentMethod = paymentMethod;
      _dataStep1 = dataStep1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _cart == null && _paymentMethod == null
        ? Container(height: 800,)
        : Container(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Please review the details below and confirm your order.'),
                  const SizedBox(
                    height: 24,
                  ),
                  CardInfoHeader(
                    title: 'Your cart',
                    child: CartBody(
                      cart: _cart,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CardInfoHeader(
                      title: 'Payment',
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            const Text('The total amount will be withdrawn from your credit card.'),
                            Text(
                              'Card type',
                              style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                            ),
                            Text(
                              '${_paymentMethod!.card.brand}',
                              style: context.bodyTextStyle()?.copyWith(fontSize: 18),
                            ),
                            Text(
                              'Card number',
                              style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                            ),
                            Text(
                              '**** **** **** ${_paymentMethod!.card.last4}',
                              style: context.bodyTextStyle()?.copyWith(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  CardInfoHeader(
                    title: 'Contact information',
                    child: Container(
                    alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                          Text(
                            '${_dataStep1!['name_parts_0']} ${_dataStep1!['name_parts_1']}',
                            style: context.bodyTextStyle()?.copyWith(fontSize: 18),
                          ),
                          Text(
                            'Email',
                            style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                          Text(
                            '${_dataStep1!['email']}',
                            style: context.bodyTextStyle()?.copyWith(fontSize: 18),
                          ),
                          Text(
                            'Phone',
                            style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                          Text(
                            '${_dataStep1!['phone']}',
                            style: context.bodyTextStyle()?.copyWith(fontSize: 18),
                          ),
                          Text(
                            'Nationality',
                            style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                          Text(
                            '${_dataStep1!['DTCMcountry']}',
                            style: context.bodyTextStyle()?.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          );
  }
}
