import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/app_colors.dart';

class EventDateTimeField extends StatelessWidget {
  const EventDateTimeField({
    Key? key,
    this.onChanged,
    this.shouldIgnoreTime = false,
    this.initialDateTime,
    this.dateFormat,
    this.isBorderVisible = true,
    this.backgroundColor,
    this.hintText,
  }) : super(key: key);

  final Function(
    int date,
    int month,
    int year,
    int hour,
    int minute,
  )? onChanged;
  final bool shouldIgnoreTime;
  final DateTime? initialDateTime;
  final DateFormat? dateFormat;
  final bool isBorderVisible;
  final Color? backgroundColor;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      initialValue: initialDateTime,
      decoration: InputDecoration(
        filled: true,
        hintText: context.localize.t_choose_date,
        suffixIcon: Container(
          padding: const EdgeInsets.all(18),
          child: SvgPicture.asset(
            AppAssets.calendarIcon,
            fit: BoxFit.cover,
          ),
        ),
        focusColor: AppColors.outlineBorderColor,
        hintStyle: TextStyle(color: AppColors.unActiveLabelItem),
        fillColor: backgroundColor ?? AppColors.inputFillColor.withOpacity(0.4),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: isBorderVisible
              ? BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                )
              : BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: isBorderVisible
              ? BorderSide(
                  color: Colors.red.withOpacity(0.4),
                  width: 2,
                )
              : BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: isBorderVisible
              ? BorderSide(
                  color: Colors.red.withOpacity(0.4),
                  width: 2,
                )
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: isBorderVisible
              ? BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                )
              : BorderSide.none,
        ),
      ),
      format: dateFormat ?? (shouldIgnoreTime ? DateFormat('yyyy/MM/dd') : DateFormat('yyyy/MM/dd HH:mm')),
      onShowPicker: (context, currentValue) async {
        final localeParts = context.language!.locale!.split('_');
        final date = await showDatePicker(
          locale: Locale(localeParts.first, localeParts.last),
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primaryButtonColor, // header background color
                  // body text color
                ),
              ),
              child: child!,
            );
          },
          lastDate: DateTime(2100),
        );

        if (date != null) {
          if (shouldIgnoreTime) {
            onChanged!(date.day, date.month, date.year, 0, 0);
            return DateTimeField.combine(
              DateTime(date.year, date.month, date.day),
              const TimeOfDay(hour: 0, minute: 0),
            );
          }
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primaryButtonColor, // header background color
                    // body text color
                  ),
                ),
                child: child!,
              );
            },
          );
          onChanged!(date.day, date.month, date.year, time!.hour, time.minute);
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );
  }
}
