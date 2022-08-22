import 'package:audio_cult/app/data_source/models/requests/event_request.dart';
import 'package:audio_cult/app/features/events/filter/widgets/filter_distance.dart';
import 'package:audio_cult/app/features/events/filter/widgets/filter_when.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../utils/constants/app_colors.dart';

class FilterEventScreen extends StatefulWidget {
  const FilterEventScreen({Key? key}) : super(key: key);

  @override
  State<FilterEventScreen> createState() => _FilterEventScreenState();
}

class _FilterEventScreenState extends State<FilterEventScreen> {
  var _distanceSelectedIndex = -1;
  var _whenSelectedIndex = -1;
  var _distance = '';
  var _when = '';
  final _textController = TextEditingController();
  final _keyword = ValueNotifier<String>('');

  bool isValidated(String keyword) {
    return _distanceSelectedIndex != -1 ||
        _whenSelectedIndex != -1 ||
        _distance.isNotEmpty ||
        _when.isNotEmpty ||
        keyword.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.mainColor,
        appBar: CommonAppBar(
          title: context.l10n.t_filter,
          actions: [
            WButtonInkwell(
              borderRadius: BorderRadius.circular(8),
              onPressed: () {
                setState(() {
                  _distanceSelectedIndex = -1;
                  _whenSelectedIndex = -1;
                  _textController.text = '';
                  _keyword.value = '';
                  _distance = '';
                  _when = '';
                });
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    context.l10n.t_clear_filter,
                    style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlue),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: kVerticalSpacing,
                left: kHorizontalSpacing,
                right: kHorizontalSpacing,
                bottom: 80,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CommonInput(
                        editingController: _textController,
                        hintText: context.l10n.t_keyword,
                        onChanged: (value) {
                          _keyword.value = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 20),
                      FilterWhen(
                        selectedIndex: _whenSelectedIndex,
                        onChanged: (value, index) {
                          setState(() {
                            _when = value;
                            _whenSelectedIndex = index;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 20),
                      FilterDistance(
                        selectedIndex: _distanceSelectedIndex,
                        onChanged: (value, index) {
                          setState(() {
                            _distance = value;
                            _distanceSelectedIndex = index;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: kHorizontalSpacing,
                right: kHorizontalSpacing,
                bottom: 0,
                child: ValueListenableBuilder<String>(
                  valueListenable: _keyword,
                  builder: (context, value, child) {
                    return CommonButton(
                      text: context.l10n.t_apply,
                      color: isValidated(value) ? AppColors.activeLabelItem : Colors.grey,
                      onTap: isValidated(value)
                          ? () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.routeResultEvent,
                                arguments: {
                                  'event_result': EventRequest(
                                    query: _keyword.value,
                                    distance: _distance,
                                    when: _when,
                                  )
                                },
                              );
                            }
                          : null,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
