import 'package:audio_cult/app/features/ticket/w_ticket_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:flutter/material.dart';

import '../../../w_components/error_empty/error_section.dart';
import '../../base/bloc_state.dart';
import '../../data_source/models/responses/productlist/productlist.dart';

class WBottomTicket extends StatefulWidget {
  final String? eventId;
  final String? userName;
  WBottomTicket({Key? key, this.eventId, this.userName}) : super(key: key);

  @override
  State<WBottomTicket> createState() => _WBottomTicketState();
}

class _WBottomTicketState extends State<WBottomTicket> {
  final TicketBloc _ticketBloc = TicketBloc(locator.get());
  @override
  void initState() {
    super.initState();
    _ticketBloc.getListTicket(widget.eventId!, widget.userName!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        return ListView(
                            shrinkWrap: true,
                            children: listItems
                                .map((e) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(e.name ?? '', style: context.body1TextStyle()?.copyWith(fontSize: 18)),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${data.currency} - ${e.price?.gross}',
                                                style: context
                                                    .body1TextStyle()
                                                    ?.copyWith(color: AppColors.activeLabelItem)),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.inputFillColor,
                                                      borderRadius: BorderRadius.circular(8)),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                  child: Text(
                                                    '0',
                                                    style: context
                                                        .body2TextStyle()
                                                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.inputFillColor,
                                                      borderRadius: BorderRadius.circular(8)),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
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
                                    ))
                                .toList());
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: CommonButton(
              color: AppColors.primaryButtonColor,
              text: 'Buy',
              onTap: () {},
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
