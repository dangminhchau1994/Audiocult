import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';

import '../../app/base/pair.dart';

class BottomAlertDialog extends StatelessWidget {
  final List<Pair<Pair<int,Widget>, String>>? listSelection;
  final Function(int id)? onTap;
  final bool isShowSelect;
  const BottomAlertDialog({Key? key, this.listSelection, this.onTap, this.isShowSelect = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.inputFillColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isShowSelect)
              const SizedBox.shrink()
            else
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16),
                child: const Text('Select:'),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: listSelection!
                  .map((e) => WButtonInkwell(
                        onPressed: () {
                          onTap?.call(e.first.first);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: e.first.second,
                              ),
                              Text(e.second),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
