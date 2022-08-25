import 'package:audio_cult/app/data_source/models/responses/question_ticket/question_ticket.dart';
import 'package:audio_cult/app/features/ticket/payments/card_payment_page.dart';
import 'package:audio_cult/app/features/ticket/payments/review_order.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/stepper/my_stepper.dart' as stepper;
import 'package:flutter/material.dart';

import '../../../data_source/models/responses/productlist/productlist.dart';
import 'infor_page.dart';

class CheckoutTicket extends StatefulWidget {
  final TicketProductList? cart;
  final QuestionTicket? questionTicket;
  const CheckoutTicket({Key? key, this.cart, this.questionTicket}) : super(key: key);

  @override
  State<CheckoutTicket> createState() => _CheckoutTicketState();
}

class _CheckoutTicketState extends State<CheckoutTicket> {
  int _currentStep = 0;
  List<stepper.Step> steps = [];
  Map<String, bool> completedStep = {'0': false, '1': false, '2': false, '3': false};
  GlobalKey<InforPageState> _informationPageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  stepper.StepState validate(int index) {
    return _currentStep >= index
        ? completedStep['$index'] == true
            ? stepper.StepState.complete
            : stepper.StepState.editing
        : stepper.StepState.disabled;
  }

  @override
  Widget build(BuildContext context) {
    steps = [
      stepper.Step(
        title: const SizedBox.shrink(),
        content: InforPage(
          key: _informationPageKey,
          cart: widget.cart,
          questionTicket: widget.questionTicket,
        ),
        isActive: _currentStep >= 0,
        state: validate(0),
      ),
      stepper.Step(
        title: const SizedBox.shrink(),
        icon: Icon(
          Icons.credit_card_rounded,
          color: AppColors.subTitleColor,
        ),
        content: CardPaymentPage(),
        isActive: _currentStep >= 1,
        state: validate(1),
      ),
      stepper.Step(
        title: const SizedBox.shrink(),
        icon: Icon(
          Icons.remove_red_eye,
          color: AppColors.subTitleColor,
        ),
        content: const ReviewOrderPage(),
        isActive: _currentStep >= 2,
        state: validate(2),
      ),
      stepper.Step(
        title: const SizedBox.shrink(),
        icon: Icon(
          Icons.confirmation_num_outlined,
          color: AppColors.subTitleColor,
        ),
        content: Container(),
        isActive: _currentStep >= 3,
        state: validate(3),
      )
    ];
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: AppColors.mainColor,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppColors.activeLabelItem,
              )),
      child: stepper.Stepper(
          controlsBuilder: (_, detail) {
            return Container(
              child: Column(
                children: [
                  CommonButton(
                    color: Colors.white,
                    colorText: Colors.black,
                    text: 'Go back',
                    onTap: () {
                      detail.onStepCancel?.call();
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CommonButton(
                    text: 'Continue',
                    onTap: () {
                      detail.onStepContinue?.call();
                    },
                  )
                ],
              ),
            );
          },
          type: stepper.StepperType.horizontal,
          currentStep: _currentStep,
          onStepTapped: (step) => tapped(step),
          onStepContinue: continued,
          onStepCancel: cancel,
          steps: steps),
    );
  }

  void tapped(int step) {
    for (var i = 0; i < 4; i++) {
      completedStep['$i'] = i < step ? true : false;
    }
    setState(() => _currentStep = step);
  }

  void continued() {
    if (_currentStep < 3) {
      if (_currentStep == 0) {
        var isPass = _informationPageKey.currentState!.isValidateAll();
        if (!isPass) {
          return;
        }
      }
      completedStep['$_currentStep'] = true;
      setState(() => _currentStep += 1);
    } else {
      completedStep['$_currentStep'] = true;
      setState(() {});
    }
  }

  void cancel() {
    if (_currentStep > 0) {
      completedStep['$_currentStep'] = false;
      setState(() => _currentStep -= 1);
    } else {
      completedStep['$_currentStep'] = false;
      setState(() {});
    }
  }
}
