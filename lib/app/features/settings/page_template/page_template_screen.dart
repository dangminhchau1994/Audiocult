import 'dart:typed_data';

import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/page_template_response.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_category.dart';
import 'package:audio_cult/app/data_source/models/responses/country_response.dart';
import 'package:audio_cult/app/features/events/create_event/widgets/event_datetime_field.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_bloc.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_widgets/multi_selection_widget.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_widgets/radio_widget.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_widgets/single_selection_widget.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_widgets/textarea_widget.dart';
import 'package:audio_cult/app/features/settings/page_template/page_template_widgets/textfield_widget.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/gender_enum.dart';
import 'package:audio_cult/app/utils/constants/page_template_field_type.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/file/file_utils.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:audio_cult/w_components/textfields/common_input_tags_grid_checkbox.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class PageTemplateScreen extends StatefulWidget {
  const PageTemplateScreen({Key? key}) : super(key: key);

  @override
  State<PageTemplateScreen> createState() => _PageTemplateScreenState();
}

class _PageTemplateScreenState extends State<PageTemplateScreen> with AutomaticKeepAliveClientMixin {
  final _bloc = getIt.get<PageTemplateBloc>();
  final _zipCodeTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _webLinkTextController = TextEditingController();
  final _genderTextController = TextEditingController();
  final _cityTextController = TextEditingController();
  late Uint8List _iconMarker;

  @override
  void initState() {
    super.initState();
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        _iconMarker = value;
      });
    });
    _bloc.loadAllPageTemplates();
    _bloc.loadUserProfile();
  }

  @override
  void dispose() {
    _zipCodeTextController.dispose();
    _emailTextController.dispose();
    _webLinkTextController.dispose();
    _genderTextController.dispose();
    _cityTextController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WKeyboardDismiss(
      child: Container(
        color: AppColors.mainColor,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.t_basic_information,
                style: context.title1TextStyle()?.copyWith(fontWeight: FontWeight.w600),
              ),
              _countriesDropdownMenuWidget(),
              _cityAndPostalCodeWidget(),
              _genderDropDownWidget(),
              _dateOfBirthWidget(),
              _pageTemplatesWidget(),
              const SizedBox(height: 30),
              _aboutMeWidget(),
              const SizedBox(height: 30),
              _mapViewContainer(),
              const SizedBox(height: 30),
              _updateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cityAndPostalCodeWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Flexible(child: _cityWidget()),
          const SizedBox(width: 16),
          Flexible(child: _zipCodeWidget()),
        ],
      ),
    );
  }

  Widget _pageTemplatesWidget() {
    return StreamBuilder<BlocState<Tuple2<List<AtlasCategory>, AtlasCategory?>>>(
        initialData: const BlocState.loading(),
        stream: _bloc.loadCategoriesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final state = snapshot.data!;
          return state.when(
            success: (tupleData) {
              final data = tupleData as Tuple2<List<AtlasCategory>, AtlasCategory?>;
              final categories = data.item1;
              final selectedCategoryTitle = data.item2?.title?.toLowerCase();
              final options = categories
                  .map(
                    (e) => SelectMenuModel(
                      title: e.title,
                      isSelected: e.title?.toLowerCase() == selectedCategoryTitle,
                    ),
                  )
                  .toList();
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: _dropdownWidget(
                  context.l10n.t_page_template,
                  options,
                  options.firstWhereOrNull((element) => element.isSelected == true),
                  (p0) => null,
                  () => null,
                ),
              );
            },
            loading: LoadingWidget.new,
            error: (_) {
              return Container();
            },
          );
        });
  }

  Widget _cityWidget() {
    return StreamBuilder<BlocState<PageTemplateResponse?>>(
      initialData: const BlocState.loading(),
      stream: _bloc.userProfileStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.when(
            success: (data) {
              final field = data as PageTemplateResponse;
              return CommonInput(
                editingController: _cityTextController..text = field.cityLocation ?? '',
                hintText: '${context.l10n.t_city}...',
              );
            },
            loading: LoadingWidget.new,
            error: (e) {
              return CommonInput(editingController: _cityTextController, hintText: '${context.l10n.t_city}...');
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _countriesDropdownMenuWidget() {
    return StreamBuilder<BlocState<Tuple2<List<Country>, Country?>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.loadCountriesStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state != null) {
          return state.when(
            success: (data) {
              final castedData = data as Tuple2<List<Country>, Country?>;
              final options = castedData.item1
                  .map(
                    (e) => SelectMenuModel(
                      title: e.name,
                      isSelected: data.item2?.countryISO == e.countryISO,
                    ),
                  )
                  .toList();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _dropdownWidget(
                  context.l10n.t_choose_country,
                  options,
                  options.firstWhereOrNull((element) => element.isSelected == true),
                  (option) {
                    if (option == null) return;
                    _bloc.selectCountry(option);
                  },
                  () {},
                  hint: context.l10n.t_choose_country,
                ),
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
    Function() onTap, {
    String? hint,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.outlineBorderColor.withOpacity(0.4),
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
              backgroundColor: Colors.transparent,
              isBorderVisible: false,
              selection: selectedOption,
              onChanged: (value) => onChanged(value),
              onTap: onTap,
              data: options,
              hint: hint,
            ),
        ],
      ),
    );
  }

  Widget _zipCodeWidget() {
    return StreamBuilder<BlocState<PageTemplateResponse?>>(
      initialData: const BlocState.loading(),
      stream: _bloc.userProfileStream,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final state = snapshot.data!;
        return state.when(
          success: (profile) {
            return CommonInput(
              editingController: _zipCodeTextController..text = (profile as PageTemplateResponse).postalCode ?? '',
              hintText: context.l10n.t_podtal_code,
              textInputType: TextInputType.number,
            );
          },
          loading: LoadingWidget.new,
          error: (e) {
            return CommonInput(
              editingController: _zipCodeTextController,
              hintText: context.l10n.t_podtal_code,
              textInputType: TextInputType.number,
            );
          },
        );
      },
    );
  }

  Widget _genderDropDownWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: StreamBuilder<Gender>(
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
                data: options,
                selection: options.firstWhereOrNull((element) => element.isSelected),
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
      ),
    );
  }

  Widget _genderCustomInputWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: CommonInput(
        editingController: _genderTextController,
        hintText: '...',
      ),
    );
  }

  Widget _dateOfBirthWidget() {
    return StreamBuilder<BlocState<PageTemplateResponse?>>(
        stream: _bloc.userProfileStream,
        initialData: const BlocState.loading(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final state = snapshot.data!;
          return state.when(
              success: (data) {
                final profile = data as PageTemplateResponse;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.outlineBorderColor.withOpacity(0.4),
                    border: Border.all(color: AppColors.outlineBorderColor, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          context.l10n.t_birthday,
                          style: context.title1TextStyle()?.copyWith(color: AppColors.pealSky),
                        ),
                      ),
                      _birthday(profile.dateTimeBirthDay),
                    ],
                  ),
                );
              },
              loading: LoadingWidget.new,
              error: (exception) {
                return Container();
              });
        });
  }

  Widget _birthday(DateTime? dateTime) {
    return EventDateTimeField(
      backgroundColor: Colors.transparent,
      isBorderVisible: false,
      dateFormat: DateFormat('dd.MM.yyyy'),
      shouldIgnoreTime: true,
      initialDateTime: dateTime,
      onChanged: (day, month, year, _, __) {
        final dateTime = DateTime(year, month, day);
        _bloc.selectDateOfBirth(dateTime);
      },
    );
  }

  Widget _aboutMeWidget() {
    return StreamBuilder<BlocState<PageTemplateResponse?>>(
      initialData: const BlocState.loading(),
      stream: _bloc.userProfileStream,
      builder: (_, snapshot) {
        if (!snapshot.hasData) return Container();
        final state = snapshot.data!;
        return state.when(
            success: (data) {
              final profile = data as PageTemplateResponse;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.t_about_me,
                    style: context.title1TextStyle(),
                  ),
                  const SizedBox(height: 8),
                  Text(context.l10n.t_page_temlate_desc),
                  ..._aboutMeComponents(profile.customFields ?? [])
                ],
              );
            },
            loading: LoadingWidget.new,
            error: (exception) {
              return Container();
            });
      },
    );
  }

  List<Widget> _aboutMeComponents(List<PageTemplateCustomField> customFields) {
    return customFields.map((field) {
      switch (field.varType) {
        case PageTemplateFieldType.textarea:
          return _textAreaWidget(field);
        case PageTemplateFieldType.multiselect:
          final options = field.options;
          if (options?.isNotEmpty != true) {
            return Container();
          }
          return _multiSelectionWidget(field);
        case PageTemplateFieldType.text:
          return _textFieldWidget(field);
        case PageTemplateFieldType.radio:
          return _radioWidget(field);
        case PageTemplateFieldType.select:
          return _singleSelectionWidget(field);
        // ignore: no_default_cases
        default:
          return Container();
      }
    }).toList();
  }

  Widget _multiSelectionWidget(PageTemplateCustomField field) {
    final values = field.getValues;
    return MultiSelectionWidget(
      field.phrase ?? '',
      tagOnChanged: (tag) => _bloc.multiSelectionFieldOnChanged(field: field, title: tag.title),
      tags: field.options?.map((e) {
            return InputTagSelect(
              e.key,
              values?.contains(e.key),
              e.value ?? '',
            );
          }).toList() ??
          [],
      checkedTags: values == null || (values.length == 1 && values.first == null)
          ? []
          : values.map((value) {
              if (value != null) {
                return InputTagSelect(
                  value,
                  true,
                  field.options!.firstWhere((element) => element.key == value).value ?? '',
                );
              }
              return InputTagSelect(
                value,
                true,
                field.options!.firstWhere((element) => element.key == value).value ?? '',
              );
            }).toList(),
    );
  }

  Widget _singleSelectionWidget(PageTemplateCustomField field) {
    return SingleSelectionWidget(
      field.phrase ?? '',
      (field.options ?? [])
          .map(
            (e) => SelectMenuModel(
              title: e.value,
              isSelected: e.selected ?? field.getValues?.contains(e.value) ?? false,
            ),
          )
          .toList(),
      onSelected: (option) {
        _bloc.singleSelectionFieldOnChanged(field: field, value: option.title);
      },
    );
  }

  Widget _textAreaWidget(PageTemplateCustomField field) {
    return TextareaWidget(
      field.phrase ?? '',
      initialText: field.getValues?.first ?? '',
      onChanged: (string) {
        _bloc.textFieldOnChanged(field: field, string: string);
      },
    );
  }

  Widget _textFieldWidget(PageTemplateCustomField field) {
    return TextfieldWidget(
      field.phrase ?? '',
      onChanged: (string) {
        _bloc.textFieldOnChanged(field: field, string: string);
      },
    );
  }

  Widget _radioWidget(PageTemplateCustomField field) {
    return RadioWidget(
      field.phrase ?? '',
      field.options ?? [],
      onChanged: (selection) {
        _bloc.radioOnChanged(field: field, selection: selection);
      },
    );
  }

  Widget _mapViewContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.t_add_pin_on_map,
          style: context.title1TextStyle(),
        ),
        Text(context.l10n.t_page_temlate_desc),
        const SizedBox(height: 12),
        _mapStreamWidget(),
      ],
    );
  }

  Widget _mapStreamWidget() {
    return StreamBuilder<BlocState<PageTemplateResponse?>>(
        initialData: const BlocState.loading(),
        stream: _bloc.userProfileStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final state = snapshot.data!;
            return state.when(
              success: (data) {
                final profile = data as PageTemplateResponse;
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _mapWidget(profile.latlngPin),
                  ),
                );
              },
              loading: LoadingWidget.new,
              error: (exception) {
                return _mapWidget(const LatLng(0, 0));
              },
            );
          }
          return Container();
        });
  }

  Widget _mapWidget(LatLng latlng) {
    return GoogleMap(
      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          EagerGestureRecognizer.new,
        ),
      },
      onTap: (lng) {
        FocusManager.instance.primaryFocus?.unfocus();
        _bloc.pinLatLng(lng);
      },
      initialCameraPosition: CameraPosition(
        target: latlng,
        zoom: 10,
      ),
      markers: {
        Marker(
          markerId: const MarkerId(''),
          position: latlng,
          icon: BitmapDescriptor.fromBytes(_iconMarker),
        ),
      },
    );
  }

  Widget _updateButton() {
    return CommonButton(
      color: AppColors.primaryButtonColor,
      text: context.l10n.t_update,
      onTap: () {
        // TODO: handle update button
      },
    );
  }
}