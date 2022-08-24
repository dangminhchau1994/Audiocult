import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/features/ticket/w_ticket_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../w_components/error_empty/error_section.dart';
import '../../base/bloc_state.dart';
import '../../data_source/models/responses/productlist/productlist.dart';

class WBottomTicket extends StatefulWidget {
  final String? eventId;
  final String? userName;
  const WBottomTicket({Key? key, this.eventId, this.userName}) : super(key: key);

  @override
  State<WBottomTicket> createState() => _WBottomTicketState();
}

class _WBottomTicketState extends State<WBottomTicket> {
  final TicketBloc _ticketBloc = TicketBloc(locator.get());
  @override
  void initState() {
    super.initState();
    _ticketBloc.getListTicket(widget.eventId!, widget.userName!);
    _ticketBloc.addTicketsStream.listen((event) {
      Navigator.pushNamed(context, AppRoute.routePaymentTicket);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: _ticketBloc,
      child: Container(
        color: AppColors.mainColor,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: 4,
                width: 100,
                decoration: BoxDecoration(color: AppColors.subTitleColor, borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Text(
              'BUY TICKETS',
              style: context.headerStyle()?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: StreamBuilder<BlocState<TicketProductList>>(
                  initialData: const BlocState.loading(),
                  stream: _ticketBloc.getListTicketsStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data!;
                    return state.when(
                        success: (success) {
                          final data = success as TicketProductList;
                          final listItems = data.itemsByCategory?[0].items ?? [];
                          return Column(
                            children: [
                              Expanded(
                                child: ListView(
                                    shrinkWrap: true,
                                    children: listItems
                                        .map((e) => ProductItem(
                                              data: data,
                                              item: e,
                                            ))
                                        .toList()),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: CommonButton(
                                  color: AppColors.primaryButtonColor,
                                  text: 'Buy',
                                  onTap: () {
                                    final isCartAdded =
                                        listItems.where((element) => element.count! == 0).length == listItems.length;
                                    if (!isCartAdded) {
                                      final listAdded = List<Items>.from(listItems);
                                      listAdded.removeWhere((element) => element.count == 0);
                                      _ticketBloc.addTicketToCart(listAdded, widget.eventId!, widget.userName!);
                                    } else {
                                      ToastUtility.showError(context: context, message: 'Please order some Ticket!');
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        loading: LoadingWidget.new,
                        error: (error) {
                          return ErrorSectionWidget(
                            errorMessage: error,
                            onRetryTap: () {},
                          );
                        });
                  }),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.data,
    required this.item,
  }) : super(key: key);

  final TicketProductList data;
  final Items item;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.item.name ?? '', style: context.body1TextStyle()?.copyWith(fontSize: 18)),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.data.currency} - ${widget.item.price?.gross}',
                style: context.body1TextStyle()?.copyWith(color: AppColors.activeLabelItem)),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (_counter.value > 0) {
                      _counter.value -= 1;
                      widget.item.count = _counter.value;
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
                  valueListenable: _counter,
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
                    if (_counter.value < limit) {
                      _counter.value += 1;
                      widget.item.count = _counter.value;
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
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Divider(
          color: AppColors.subTitleColor,
        )
      ],
    );
  }
}
