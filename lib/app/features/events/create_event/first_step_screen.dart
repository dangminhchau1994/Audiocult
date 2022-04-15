import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/requests/create_event_request.dart';
import 'package:audio_cult/app/features/auth/register/register_bloc.dart';
import 'package:audio_cult/app/features/events/create_event/widgets/event_datetime_field.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';
import '../../../data_source/models/responses/place.dart';
import '../../../utils/constants/app_colors.dart';
import '../../auth/widgets/register_page.dart';

class FirstStepScreen extends StatefulWidget {
  const FirstStepScreen({
    Key? key,
    this.onNext,
    this.createEventRequest,
  }) : super(key: key);

  final Function()? onNext;
  final CreateEventRequest? createEventRequest;

  @override
  State<FirstStepScreen> createState() => _FirstStepScreenState();
}

class _FirstStepScreenState extends State<FirstStepScreen> {
  final RegisterBloc _registerBloc = RegisterBloc(locator.get(), locator.get());
  final _formKey = GlobalKey<FormState>();
  PlaceAndLocation? _placeAndLocation;
  TextEditingController _locationTextController = TextEditingController(text: '');
  String _errorTitle = '';
  String _errorLocation = '';

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    widget.createEventRequest?.startDate = DateTime.now().day.toString();
    widget.createEventRequest?.starMonth = DateTime.now().month.toString();
    widget.createEventRequest?.startYear = DateTime.now().year.toString();
    widget.createEventRequest?.startHour = DateTime.now().hour.toString();
    widget.createEventRequest?.startMinute = DateTime.now().minute.toString();

    widget.createEventRequest?.endDate = DateTime.now().day.toString();
    widget.createEventRequest?.endMonth = DateTime.now().month.toString();
    widget.createEventRequest?.endYear = DateTime.now().year.toString();
    widget.createEventRequest?.endHour = DateTime.now().hour.toString();
    widget.createEventRequest?.endMinute = DateTime.now().minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHorizontalSpacing,
          vertical: kVerticalSpacing,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.t_main_info,
                  style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.t_please_fill,
                  style: context.bodyTextStyle()?.copyWith(
                        color: AppColors.subTitleColor,
                      ),
                ),
                const SizedBox(height: 20),
                CommonInput(
                  hintText: context.l10n.t_event_title,
                  errorText: _errorTitle.isEmpty ? null : _errorTitle,
                  onChanged: (value) {
                    widget.createEventRequest?.title = value;
                  },
                ),
                const SizedBox(height: 20),
                CommonDropdown(
                  hint: context.l10n.t_category,
                  data: GlobalConstants.getSelectedMenu(context),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final result = await showSearch(context: context, delegate: AddressSearch(bloc: _registerBloc));
                    if (result != null) {
                      final placeDetails = await _registerBloc.getPlaceDetailFromId(result.placeId);
                      final location = await _registerBloc.getLatLng(result.description);
                      if (placeDetails != null) {
                        placeDetails.fullAddress = result.description;
                        setState(() {
                          _placeAndLocation = PlaceAndLocation(place: placeDetails, location: location);
                          widget.createEventRequest?.location = result.description;
                          widget.createEventRequest?.lat = _placeAndLocation?.location?.latitude.toString();
                          widget.createEventRequest?.lng = _placeAndLocation?.location?.longitude.toString();
                          _locationTextController.text = _placeAndLocation?.place?.fullAddress ?? '';
                        });
                      }
                    }
                  },
                  child: AbsorbPointer(
                    child: CommonInput(
                      editingController: _locationTextController,
                      hintText: context.l10n.t_location,
                      errorText: _errorLocation.isEmpty ? null : _errorLocation,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.t_start_time,
                  style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                EventDateTimeField(
                  onChanged: (date, month, year, hour, minute) {
                    widget.createEventRequest?.startDate = date.toString();
                    widget.createEventRequest?.starMonth = month.toString();
                    widget.createEventRequest?.startYear = year.toString();
                    widget.createEventRequest?.startHour = hour.toString();
                    widget.createEventRequest?.startMinute = minute.toString().padLeft(2, '0');
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.t_end_time,
                  style: context.bodyTextStyle()?.copyWith(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                EventDateTimeField(
                  onChanged: (date, month, year, hour, minute) {
                    widget.createEventRequest?.endDate = date.toString();
                    widget.createEventRequest?.endMonth = month.toString();
                    widget.createEventRequest?.endYear = year.toString();
                    widget.createEventRequest?.endHour = hour.toString();
                    widget.createEventRequest?.endMinute = minute.toString().padLeft(2, '0');
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CommonButton(
                    color: AppColors.primaryButtonColor,
                    text: context.l10n.btn_next,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onNext!();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
