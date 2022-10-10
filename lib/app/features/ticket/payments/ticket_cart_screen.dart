import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/appbar/common_appbar.dart';
import '../../../data_source/models/responses/productlist/productlist.dart';
import '../../../utils/constants/app_colors.dart';

class TicketCartScreen extends StatefulWidget {
  final Map<String, dynamic> params;

  const TicketCartScreen({Key? key, required this.params}) : super(key: key);

  @override
  State<TicketCartScreen> createState() => _TicketCartScreenState();
  static Map<String, dynamic> createArguments({required TicketProductList? cart, bool? isShowToolbar = true}) =>
      {'cart': cart, 'isShowToolbar': isShowToolbar};
}

class _TicketCartScreenState extends State<TicketCartScreen> {
  TicketProductList? cart;
  List<Items> cartList = [];
  int totalProduct = 0;
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    cart = widget.params['cart'] as TicketProductList?;
    cartList = cart!.itemsByCategory![0].items ?? [];
    cartList.removeWhere((element) => element.count == 0);
    cartList.forEach((element) {
      totalProduct += element.count!;
      totalPrice += element.count! * double.tryParse(element.price?.gross ?? '0')!.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: widget.params['isShowToolbar'] as bool ? const CommonAppBar(title: 'Your cart') : null,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: SingleChildScrollView(
          child: CartBody(
            cart: cart,
          ),
        ),
      ),
    );
  }
}

class CartBody extends StatefulWidget {
  const CartBody({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final TicketProductList? cart;

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  TicketProductList? cart;
  List<Items> cartList = [];
  int totalProduct = 0;
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    cart = widget.cart;
    cartList = cart!.itemsByCategory![0].items ?? [];
    cartList.removeWhere((element) => element.count == 0);
    cartList.forEach((element) {
      totalProduct += element.count!;
      totalPrice += element.count! * double.tryParse(element.price?.gross ?? '0')!.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: cartList
              .map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.name ?? '',
                        style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${e.count ?? ''}'),
                          Row(
                            children: [Text(widget.cart?.currency ?? ''), Text('${e.price?.gross}')],
                          ),
                          Row(
                            children: [
                              Text(
                                widget.cart?.currency ?? '',
                                style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                              ),
                              Text(
                                '${e.count! * double.tryParse(e.price?.gross ?? '0')!.toDouble()}',
                                style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ))
              .toList(),
        ),
        const Divider(
          height: 4,
          color: Colors.white,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
            ),
            Row(
              children: [
                Text(
                  widget.cart?.currency ?? '',
                  style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                ),
                Text(
                  '$totalPrice',
                  style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                )
              ],
            ),
          ],
        ),
        Text('$totalProduct tickets')
      ],
    );
  }
}
