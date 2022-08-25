import 'package:audio_cult/app/data_source/models/responses/productlist/productlist.dart';
import 'package:audio_cult/app/data_source/models/responses/question_ticket/question_ticket.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/textfields/common_input.dart';

class InforPage extends StatefulWidget {
  final TicketProductList? cart;
  final QuestionTicket? questionTicket;

  const InforPage({Key? key, this.cart, this.questionTicket}) : super(key: key);

  @override
  State<InforPage> createState() => InforPageState();
}

class InforPageState extends State<InforPage> {
  SelectMenuModel? _nationalitySelect;
  String _email = '';
  String _phoneNumberSuffix = '';
  String _givenName = '';
  String _familyName = '';
  bool isValidateAll() {
    if (_email.isEmpty ||
        _phoneNumberSuffix.isEmpty ||
        _givenName.isEmpty ||
        _familyName.isEmpty ||
        _nationalitySelect == null) {
      ToastUtility.showPending(context: context, message: 'Please fill out all field');
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
              'Before we continue, we need you to answer some questions.\nYou need to fill all fields that are marked with * to continue.'),
          const SizedBox(
            height: 16,
          ),
          CardInfoHeader(
            title: 'Contact information',
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text('Email',
                          style: context.bodyTextStyle()?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('*',
                          style: context.bodyTextStyle()?.copyWith(
                                color: AppColors.activeLabelItem,
                              ))
                    ],
                  ),
                ),
                CommonInput(
                  hintText: 'Email',
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                      'Make sure to enter a valid email address. We will send you an order confirmation including a link that you need to access your order later.'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text('Phone number',
                          style: context.bodyTextStyle()?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('*',
                          style: context.bodyTextStyle()?.copyWith(
                                color: AppColors.activeLabelItem,
                              ))
                    ],
                  ),
                ),
                // CommonDropdown(
                //   selection: _phonePrefixSelect,
                //   onChanged: (value) => {},
                //   onTap: () {},
                //   data: [],
                //   hint: '',
                // ),
                const SizedBox(
                  height: 4,
                ),
                CommonInput(
                  hintText: 'Phone number',
                  onChanged: (value) {
                    setState(() {
                      _phoneNumberSuffix = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text('Nationality',
                          style: context.bodyTextStyle()?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('*',
                          style: context.bodyTextStyle()?.copyWith(
                                color: AppColors.activeLabelItem,
                              ))
                    ],
                  ),
                ),
                CommonDropdown(
                  selection: _nationalitySelect,
                  onChanged: (value) => {},
                  onTap: () {},
                  data: [],
                  hint: '',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text('Name', style: context.bodyTextStyle()?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('*',
                          style: context.bodyTextStyle()?.copyWith(
                                color: AppColors.activeLabelItem,
                              ))
                    ],
                  ),
                ),
                CommonInput(
                  hintText: 'Given name',
                  onChanged: (value) {
                    setState(() {
                      _givenName = value;
                    });
                  },
                ),
                CommonInput(
                  hintText: 'Family name',
                  onChanged: (value) {
                    setState(() {
                      _familyName = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.questionTicket!.itemQuestions!
                .map((e) => Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: CardInfoHeader(
                        title: e.item!.name ?? '',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.questions![0].label ?? '',
                                style: context.bodyTextStyle()?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CommonInput(
                                hintText: e.questions![0].fieldParts![0].label ?? '',
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

class CardInfoHeader extends StatelessWidget {
  final Widget child;
  final String title;
  const CardInfoHeader({Key? key, required this.child, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(color: AppColors.cartColor, borderRadius: BorderRadius.circular(4)),
            child: Text(
              title,
              style: context.headerStyle()?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ],
      ),
    );
  }
}
