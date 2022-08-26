import 'package:audio_cult/app/data_source/models/requests/profile_request.dart';
import 'package:audio_cult/app/data_source/models/requests/ticket_info_payment_request.dart';
import 'package:audio_cult/app/data_source/models/responses/productlist/productlist.dart';
import 'package:audio_cult/app/data_source/models/responses/question_ticket/question_ticket.dart';
import 'package:audio_cult/app/features/profile/profile_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/textfields/common_input.dart';
import '../../../base/state.dart';
import '../../../data_source/local/pref_provider.dart';
import '../../../data_source/models/responses/profile_data.dart';

class InforPage extends StatefulWidget {
  final TicketProductList? cart;
  final QuestionTicket? questionTicket;

  const InforPage({Key? key, this.cart, this.questionTicket}) : super(key: key);

  @override
  State<InforPage> createState() => InforPageState();
}

class InforPageState extends State<InforPage> {
  String _email = '';
  final TextEditingController _textEditingController = TextEditingController();
  String _phoneNumberSuffix = '';
  String _givenName = '';
  String _familyName = '';
  String _phonePrefix = '';
  Country? _country;
  Country? _nationalitySelect;
  final PrefProvider prefProvider = locator.get();
  final ProfileBloc _profileBloc = ProfileBloc(locator.get(), locator.get());

  @override
  void initState() {
    super.initState();
    getCurrentProfile();
  }

  void getCurrentProfile() {
    _profileBloc.requestData(params: ProfileRequest(userId: prefProvider.currentUserId!, query: 'general'));
    _profileBloc.appStream!.listen((data) {
      if (data is DataLoadedState) {
        final result = data.data as ProfileData;
        setState(() {
          _email = result.email ?? '';
          _textEditingController.text = _email;
        });
      }
    });
  }

  bool isValidateAll() {
    if (_email.isEmpty ||
        _phoneNumberSuffix.isEmpty ||
        _givenName.isEmpty ||
        _familyName.isEmpty ||
        _nationalitySelect == null ||
        _country == null) {
      ToastUtility.showPending(context: context, message: 'Please fill out all field');
      return false;
    }

    return true;
  }

  Map<String, dynamic> getData() {
    final body = <String, dynamic>{};
    final request = TicketInfoPaymentRequest();
    request.email = _email;
    request.phone = _phonePrefix + _phoneNumberSuffix;
    request.nationality = _nationalitySelect?.countryCode;
    request.givenName = _givenName;
    request.familyName = _familyName;
    widget.questionTicket!.itemQuestions!.forEach((element) {
      if (element.questions![0].name!.isNotEmpty) {
        body[element.questions![0].name!] = element.name;
      }
    });
    return request.toJson(body);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    Text('Email', style: context.bodyTextStyle()?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('*',
                        style: context.bodyTextStyle()?.copyWith(
                              color: AppColors.activeLabelItem,
                            ))
                  ],
                ),
              ),
              CommonInput(
                editingController: _textEditingController,
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
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    countryListTheme: CountryListThemeData(
                      flagSize: 25,
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                      bottomSheetHeight: 700, // Optional. Country list modal height
                      //Optional. Sets the border radius for the bottomsheet.
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      //Optional. Styles the search field.

                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    onSelect: (Country country) {
                      setState(() {
                        _phonePrefix = country.countryCode;
                        _country = country;
                      });
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.inputFillColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.outlineBorderColor, width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              child: _country == null
                                  ? const Text('')
                                  : Text('${_country?.name ?? ''} +${_country?.phoneCode ?? ''}'))),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
              ),
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
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    countryListTheme: CountryListThemeData(
                      flagSize: 25,
                      backgroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                      bottomSheetHeight: 700, // Optional. Country list modal height
                      //Optional. Sets the border radius for the bottomsheet.
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      //Optional. Styles the search field.

                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    onSelect: (Country country) {
                      setState(() {
                        _nationalitySelect = country;
                      });
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.inputFillColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.outlineBorderColor, width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                              child:
                                  _nationalitySelect == null ? const Text('') : Text(_nationalitySelect?.name ?? ''))),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ),
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
                              onChanged: (value) {
                                e.name = value;
                              },
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
