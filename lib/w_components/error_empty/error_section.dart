import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:flutter/material.dart';

class ErrorSectionWidget extends StatelessWidget {
  final String errorMessage;
  final String? retryText;
  final VoidCallback? onRetryTap;

  const ErrorSectionWidget({Key? key, required this.errorMessage, this.retryText, this.onRetryTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing, vertical: kHorizontalSpacing / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  errorMessage,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          TextButton(onPressed: () => onRetryTap?.call(), child: Text(retryText ?? context.localize.t_retry)),
        ],
      ),
    );
  }
}
