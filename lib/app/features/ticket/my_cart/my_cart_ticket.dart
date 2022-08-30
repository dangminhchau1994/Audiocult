import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../w_components/appbar/common_appbar.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../data_source/models/responses/productlist/productlist.dart';
import '../../../utils/constants/app_colors.dart';

class MyCartTicket extends StatefulWidget {
  final Map<String, dynamic> params;

  const MyCartTicket({Key? key, required this.params}) : super(key: key);

  @override
  State<MyCartTicket> createState() => _MyCartTicketState();
  static Map<String, dynamic> createArguments({required List<Items> cart, required String? currency}) =>
      {'cart': cart, 'currency': currency};
}

class _MyCartTicketState extends State<MyCartTicket> {
  List<Items> listCart = [];
  String? currency;
  double total = 0;
  @override
  void initState() {
    super.initState();
    listCart.addAll(List.from(widget.params['cart'] as List<Items>));
    currency = widget.params['currency'] as String;
    listCart.forEach((element) {
      total += element.count! * double.tryParse(element.price?.gross ?? '0')!.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: const CommonAppBar(title: 'My cart'),
      body: Container(
        padding: const EdgeInsets.only(bottom: 24, left: 8, right: 8, top: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: listCart
                    .map((e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  width: 100,
                                  height: 100,
                                  errorWidget: (_, error, __) => const Icon(Icons.error),
                                  placeholder: (_, __) => const LoadingWidget(),
                                  imageUrl: e.imagePath ??
                                      'https://static4.depositphotos.com/1012407/370/v/950/depositphotos_3707681-stock-illustration-yellow-ticket.jpg',
                                  imageBuilder: (_, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(e.eventTitle ?? '',
                                            style: context
                                                .bodyTextStyle()
                                                ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold)),
                                        Row(
                                          children: [
                                            Text(e.name ?? ''),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Container(
                                                height: 2,
                                                width: 2,
                                                decoration:
                                                    const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                              ),
                                            ),
                                            Text('${e.price?.gross ?? '0'} $currency'),
                                          ],
                                        ),
                                        CountItemCart(
                                          item: e,
                                          currency: currency,
                                          onRemove: (value) {
                                            listCart.removeWhere((element) => element.id == value.id);
                                            setState(() {});
                                          },
                                          onChanged: () {
                                            total = 0;
                                            listCart.forEach((element) {
                                              if (element.count! > 0) {
                                                total += element.count! *
                                                    double.tryParse(element.price?.gross ?? '0')!.toDouble();
                                              }
                                            });

                                            setState(() {});
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Divider(
                              color: AppColors.subTitleColor,
                            )
                          ],
                        ))
                    .toList(),
              ),
            ),
            Row(
              children: [
                const Text('Ticket:'),
                const SizedBox(
                  width: 16,
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    Text(
                      total.toStringAsFixed(2),
                      style: context.body1TextStyle()?.copyWith(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('$currency'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text('Total:'),
                const SizedBox(
                  width: 16,
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    Text(
                      total.toStringAsFixed(2),
                      style: context
                          .body1TextStyle()
                          ?.copyWith(color: AppColors.activeLabelItem, fontWeight: FontWeight.w800, fontSize: 28),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('$currency'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            CommonButton(
              text: '${listCart.isNotEmpty ? 'Checkout' : 'Back to by Tickets'} ',
              color: AppColors.activeLabelItem,
              onTap: () {
                if (listCart.isNotEmpty) {
                  Navigator.pop(context, listCart);
                } else {
                  Navigator.pop(
                    context,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CountItemCart extends StatefulWidget {
  const CountItemCart({Key? key, required this.item, required this.currency, this.onRemove, this.onChanged})
      : super(key: key);

  final Items item;
  final String? currency;
  final Function(Items item)? onRemove;
  final Function()? onChanged;

  @override
  State<CountItemCart> createState() => _ProductItemState();
}

class _ProductItemState extends State<CountItemCart> {
  ValueNotifier<int>? _counter;

  @override
  void initState() {
    super.initState();
    _counter = ValueNotifier<int>(widget.item.count!);
  }

  @override
  void didUpdateWidget(covariant CountItemCart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _counter = ValueNotifier<int>(widget.item.count!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Row(
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: _counter!,
                  builder: (_, int value, Widget? child) => Text(
                    value > 0
                        // ignore: noop_primitive_operations
                        ? (value * double.tryParse(widget.item.price?.gross ?? '0')!.toDouble()).toStringAsFixed(2)
                        : '${widget.item.price?.gross}',
                    style: context.bodyTextStyle()?.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(widget.currency ?? ''),
              ],
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (_counter!.value > 0) {
                  _counter!.value -= 1;
                  widget.item.count = _counter!.value;
                  if (_counter!.value == 0) {
                    widget.onRemove?.call(widget.item);
                  }
                  widget.onChanged?.call();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.inputFillColor, borderRadius: BorderRadius.circular(8)),
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
            ValueListenableBuilder<int>(
              key: Key(const Uuid().v4()),
              valueListenable: _counter!,
              builder: (_, int value, Widget? child) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$value',
                  style: context.body2TextStyle()?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                var limit = 10;
                if (widget.item.avail != null && widget.item.avail!.isNotEmpty) {
                  limit = widget.item.avail![0];
                }
                if (_counter!.value < limit) {
                  _counter!.value += 1;
                  widget.item.count = _counter!.value;
                  widget.onChanged?.call();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.inputFillColor, borderRadius: BorderRadius.circular(8)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
