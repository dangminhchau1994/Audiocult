import 'package:audio_cult/app/data_source/models/responses/question_ticket/question_ticket.dart';
import 'package:audio_cult/app/data_source/networks/exceptions/app_exception.dart';
import 'package:audio_cult/app/features/ticket/payments/card_payment_page.dart';
import 'package:audio_cult/app/features/ticket/payments/payment_tickets_bloc.dart';
import 'package:audio_cult/app/features/ticket/payments/review_order.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/stepper/my_stepper.dart' as stepper;
import 'package:flutter/material.dart';

import '../../../data_source/models/responses/productlist/productlist.dart';
import '../../../utils/route/app_route.dart';
import 'infor_page.dart';
import 'order_confirm.dart';

class CheckoutTicket extends StatefulWidget {
  final TicketProductList? cart;
  final QuestionTicket? questionTicket;
  final PaymentTicketsBloc? bloc;
  final String? eventId;
  final String? userName;
  const CheckoutTicket({Key? key, this.cart, this.questionTicket, this.bloc, this.eventId, this.userName})
      : super(key: key);

  @override
  State<CheckoutTicket> createState() => _CheckoutTicketState();
}

class _CheckoutTicketState extends State<CheckoutTicket> {
  int _currentStep = 0;
  List<stepper.Step> steps = [];
  Map<String, bool> completedStep = {'0': false, '1': false, '2': false, '3': false};
  final GlobalKey<InforPageState> _informationPageKey = GlobalKey();
  final GlobalKey<CardPaymentPageState> _cardPageKey = GlobalKey();
  final GlobalKey<ReviewOrderPageState> _reviewOrderPageKey = GlobalKey();

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
        content: CardPaymentPage(
          key: _cardPageKey,
          bloc: widget.bloc,
          username: widget.userName,
          eventId: widget.eventId,
        ),
        isActive: _currentStep >= 1,
        state: validate(1),
      ),
      stepper.Step(
        title: const SizedBox.shrink(),
        icon: Icon(
          Icons.remove_red_eye,
          color: AppColors.subTitleColor,
        ),
        content: ReviewOrderPage(
          key: _reviewOrderPageKey,
        ),
        isActive: _currentStep >= 2,
        state: validate(2),
      ),
      stepper.Step(
        title: const SizedBox.shrink(),
        icon: Icon(
          Icons.confirmation_num_outlined,
          color: AppColors.subTitleColor,
        ),
        content: const OrderConfirm(),
        isActive: _currentStep >= 3,
        state: _currentStep >= 3 ? stepper.StepState.complete : stepper.StepState.disabled,
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
                  if (detail.currentStep < 3)
                    CommonButton(
                      color: Colors.white,
                      colorText: Colors.black,
                      text: 'Go back',
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        detail.onStepCancel?.call();
                      },
                    )
                  else
                    Container(),
                  const SizedBox(
                    height: 8,
                  ),
                  if (detail.currentStep < 3)
                    CommonButton(
                      text: 'Continue',
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        detail.onStepContinue?.call();
                      },
                    )
                  else
                    CommonButton(
                      text: 'Completed',
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoute.routeMain, (Route<dynamic> route) => false,
                            arguments: {'payment': true});
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

  void continued() async {
    if (_currentStep < 3) {
      if (_currentStep == 0) {
        final isPass = _informationPageKey.currentState!.isValidateAll();
        if (!isPass) {
          return;
        } else {
          final dataStep1 = _informationPageKey.currentState!.getData();
          //call api submit info;
          final step1Result = await widget.bloc?.submitStep1(dataStep1, widget.eventId!, widget.userName!);
          if (!step1Result!) {
            return;
          }
        }
      } else if (_currentStep == 1) {
        final isPassCard = _cardPageKey.currentState!.isDone();
        if (!isPassCard) {
          return;
        } else {
          //call api submit stripe;
          try {
            widget.bloc!.showOverLayLoading();
            final dataStep1 = _informationPageKey.currentState!.getData();

            final paymentMethod = await _cardPageKey.currentState!.submitToStripe(dataStep1);
            //submit to server
            final step2Result = await widget.bloc?.submitStep2(paymentMethod, widget.eventId!, widget.userName!);
            if (!step2Result!) {
              return;
            }
          } catch (e) {
            widget.bloc!.showError(AppException(e.toString()));
          }

          widget.bloc!.hideOverlayLoading();
          completedStep['$_currentStep'] = true;
          setState(() => _currentStep += 1);
          final dataStep1 = _informationPageKey.currentState!.getData();
          final paymentMethod = await _cardPageKey.currentState!.submitToStripe(dataStep1);
          _reviewOrderPageKey.currentState!.updateData(widget.cart, paymentMethod, dataStep1);
          return;
        }
      } else if (_currentStep == 2) {
        final step3Result = await widget.bloc?.confirmPayment(widget.eventId!, widget.userName!);
        if (!step3Result!) {
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
