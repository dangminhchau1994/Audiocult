import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class OrderConfirm extends StatelessWidget {
  const OrderConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: AppColors.greenColor, shape: BoxShape.circle),
            child: Icon(
              Icons.done_rounded,
              color: AppColors.mainColor,
              size: 50,
            ),
          ),
          Text(
            'Thank you!',
            style: context
                .bodyTextStyle()
                ?.copyWith(fontWeight: FontWeight.w700, fontSize: 48, color: AppColors.greenColor),
          ),
          const Text('We successfully received your payment. See below for details.'),
          const Text(
              'Please bookmark or save the link to this exact page if you want to access your order later. We also sent you an email containing the link to the address you specified.')
        ],
      ),
    );
  }
}
