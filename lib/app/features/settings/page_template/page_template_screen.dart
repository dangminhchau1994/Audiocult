import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/country_response.dart';
import 'package:audio_cult/app/features/events/create_event/widgets/event_datetime_field.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/gender_enum.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/menus/common_fab_menu.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';

class PageTemplateScreen extends StatefulWidget {
  const PageTemplateScreen({Key? key}) : super(key: key);

  @override
  State<PageTemplateScreen> createState() => _PageTemplateScreenState();
}

class _PageTemplateScreenState extends State<PageTemplateScreen> {
  final _bloc = getIt.get<PageTemplateBloc>();
  final _zipCodeTextController = TextEditingController();
  final _genderCustomTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _bloc.loadAllCountries();
  }

  @override
  void dispose() {
    _zipCodeTextController.dispose();
    _genderCustomTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic information',
            style: context.title1TextStyle()?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _countriesDropdownMenuWidget(),
          _cityDropdownMenuWidget(),
          const SizedBox(height: 16),
          _zipCodeWidget(),
          const SizedBox(height: 30),
          _genderDropDownWidget(),
          const SizedBox(height: 30),
          _dateOfBirthWidget(),
        ],
      ),
    );
  }

  Widget _cityDropdownMenuWidget() {
    return StreamBuilder<List<City>>(
      initialData: const <City>[],
      stream: _bloc.loadCitiesStream,
      builder: (context, snapshot) {
        final options = snapshot.data?.map((e) => SelectMenuModel(title: e.name)).toList();
        if (options?.isEmpty == true) {
          return Container();
        }
        return _dropdownWidget(
          context.l10n.t_choose_country,
          options,
          options?.first,
          (option) {
            // _bloc.selectCountryOption(options.first);
          },
          () {},
        );
      },
    );
  }

  Widget _countriesDropdownMenuWidget() {
    return StreamBuilder<BlocState<List<Country>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.loadCountriesStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state != null) {
          return state.when(
            success: (countries) {
              final options = (countries as List<Country>).map((e) => SelectMenuModel(title: e.name)).toList();
              return _dropdownWidget(
                context.l10n.t_choose_country,
                options,
                options.first,
                (option) {
                  _bloc.selectCountry(options.first);
                },
                () {},
              );
            },
            error: (error) => Container(),
            loading: () => const LoadingWidget(),
          )!;
        }
        return Container();
      },
    );
  }

  Widget _dropdownWidget(
    String? title,
    List<SelectMenuModel>? options,
    SelectMenuModel? selectedOption,
    Function(SelectMenuModel?) onChanged,
    Function() onTap,
  ) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.outlineBorderColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              title ?? '',
              style: context.title1TextStyle()?.copyWith(color: AppColors.pealSky),
            ),
          ),
          if (options?.isNotEmpty != true)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(context.l10n.t_no_data),
              ),
            )
          else
            CommonDropdown(
              isBorderVisible: false,
              selection: selectedOption,
              onChanged: (value) => onChanged(value),
              onTap: onTap,
              data: options,
              hint: '',
            ),
        ],
      ),
    );
  }

  Widget _zipCodeWidget() {
    return CommonInput(
      editingController: _zipCodeTextController,
      hintText: 'ZIP/Postap Code',
    );
  }

  Widget _genderDropDownWidget() {
    return StreamBuilder<Gender>(
      stream: _bloc.genderChangedStream,
      initialData: Gender.none,
      builder: (context, snapshot) {
        final gender = snapshot.data ?? Gender.none;
        final selectedOption = SelectMenuModel(id: gender.index, title: gender.title(context), isSelected: true);
        final options = _bloc.allGenders
            .map(
              (e) => SelectMenuModel(
                id: e.index,
                title: e.title(context),
                isSelected: e.index == selectedOption.id,
              ),
            )
            .toList();

        return Column(
          children: [
            CommonDropdown(
              hint: selectedOption.title,
              data: options,
              selection: selectedOption,
              onChanged: (option) {
                if (option == null) {
                  return;
                }
                _bloc.selectGender(option);
              },
            ),
            if (gender == Gender.custom) _genderCustomInputWidget() else Container(),
          ],
        );
      },
    );
  }

  Widget _genderCustomInputWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: CommonInput(
        editingController: _genderCustomTextController,
        hintText: 'Email info',
      ),
    );
  }

  Widget _dateOfBirthWidget() {
    return EventDateTimeField(
      shouldIgnoreTime: true,
      // initialDateTime: ,
      onChanged: (day, month, year, _, __) {
        final dateTime = DateTime(year, month, day);
        _bloc.selectDateOfBirth(dateTime);
      },
    );
  }
}
