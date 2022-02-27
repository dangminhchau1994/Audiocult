import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../app/utils/constants/app_colors.dart';
import 'custom_dropdown_button2.dart';

class CommonDropdown extends StatefulWidget {
  final String? hint;
  final List<SelectMenuModel>? data;
  final Function()? onTap;
  final Function(SelectMenuModel? value)? onChanged;
  const CommonDropdown({Key? key, this.hint, this.data, this.onTap, this.onChanged}) : super(key: key);

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  SelectMenuModel? selection;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputFillColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.outlineBorderColor, width: 2),
      ),
      child: CustomDropdownButton2(
        onTap: widget.onTap,
        hintAlignment: Alignment.centerLeft,
        icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: Colors.white),
        buttonDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.semiMainColor),
        buttonWidth: double.infinity,
        dropdownWidth: MediaQuery.of(context).size.width - 32,
        hint: widget.hint ?? '',
        dropdownItems: widget.data ?? [],
        value: selection,
        selectedItemBuilder: (_) => widget.data!
            .map(
              (e) => Center(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    e.title ?? '',
                    style: context.bodyTextStyle()?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            selection = value;
          });
          widget.onChanged?.call(value);
        },
      ),
    );
  }
}

class SelectMenuModel {
  int? id;
  String? title;
  bool isSelected;
  SelectMenuModel({this.id, this.title, this.isSelected = false});
}
