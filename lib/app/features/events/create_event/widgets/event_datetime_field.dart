import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/l10n/l10n.dart';
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

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      initialValue: initialDateTime ?? DateTime.now(),
      decoration: InputDecoration(
        filled: true,
        hintText: context.l10n.t_choose_date,
        suffixIcon: Container(
          padding: const EdgeInsets.all(18),
          child: SvgPicture.asset(
            AppAssets.calendarIcon,
            fit: BoxFit.cover,
          ),
        ),
        focusColor: AppColors.outlineBorderColor,
        hintStyle: TextStyle(color: AppColors.unActiveLabelItem),
        fillColor: AppColors.inputFillColor.withOpacity(0.4),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: AppColors.outlineBorderColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.4),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.4),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: AppColors.outlineBorderColor,
            width: 2,
          ),
        ),
      ),
      format: shouldIgnoreTime ? DateFormat('yyyy/MM/dd') : DateFormat('yyyy/MM/dd HH:mm'),
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
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
            lastDate: DateTime(2100));
        if (date != null && !shouldIgnoreTime) {
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
