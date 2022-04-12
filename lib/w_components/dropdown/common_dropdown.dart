import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import '../../app/utils/constants/app_colors.dart';
import 'custom_dropdown_button2.dart';

// ignore: must_be_immutable
class CommonDropdown extends StatefulWidget {
  final String? hint;
  SelectMenuModel? selection;
  final List<SelectMenuModel>? data;
  final Function()? onTap;
  final Function(SelectMenuModel? value)? onChanged;
  final Color? backgroundColor;
  EdgeInsets? padding;
  double? dropDownWith;
  bool isValidate;
  bool isBorderVisible;

  CommonDropdown({
    Key? key,
    this.hint,
    this.data,
    this.onTap,
    this.onChanged,
    this.selection,
    this.padding,
    this.dropDownWith,
    this.backgroundColor,
    this.isBorderVisible = true,
    this.isValidate = false,
  }) : super(key: key);

  @override
  State<CommonDropdown> createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: widget.padding ??= const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppColors.inputFillColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: widget.selection == null && widget.isValidate
                  ? Colors.red.withOpacity(0.6)
                  : widget.isBorderVisible
                      ? AppColors.outlineBorderColor
                      : Colors.transparent,
            ),
          ),
          child: CustomDropdownButton2(
            onTap: widget.onTap,
            hintAlignment: Alignment.centerLeft,
            icon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: AppColors.unActiveLabelItem),
            buttonDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            dropdownDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.secondaryButtonColor),
            buttonWidth: double.infinity,
            dropdownWidth: widget.dropDownWith ??= MediaQuery.of(context).size.width - 32,
            hint: widget.hint ?? '',
            dropdownItems: widget.data ?? [],
            value: widget.selection,
            selectedItemBuilder: (_) => widget.data!
                .map(
                  (e) => Center(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (e.icon != null)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: e.icon,
                          )
                        else
                          const SizedBox.shrink(),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            e.title ?? '',
                            style: context.bodyTextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              widget.onChanged?.call(value);
            },
          ),
        ),
        if (widget.selection == null && widget.isValidate)
          Container(
            margin: const EdgeInsets.only(left: 8, top: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              'Please select an item in the list',
              style: context.body1TextStyle()?.copyWith(color: Colors.red, fontSize: 12),
            ),
          )
        else
          const SizedBox.shrink()
      ],
    );
  }
}

class SelectMenuModel {
  int? id;
  String? title;
  bool isSelected;
  Widget? icon;
  SelectMenuModel({this.id, this.title, this.isSelected = false, this.icon});
  @override
  String toString() {
    return '$id $title $isSelected';
  }

  dynamic toDynamic() {
    final dynamic data = {};
    data['id'] = id as dynamic;
    data['title'] = title as dynamic;
    data['isSelected'] = isSelected as dynamic;
    return data;
  }
}
