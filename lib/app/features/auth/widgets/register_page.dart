import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/register_request.dart';
import 'package:audio_cult/app/data_source/models/responses/user_group.dart';
import 'package:audio_cult/app/features/auth/register/register_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/checkbox/common_checkbox.dart';
import 'package:audio_cult/w_components/error_empty/widget_state.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../../w_components/textfields/common_input.dart';
import '../../../data_source/models/responses/place.dart';
import '../../../injections.dart';
import '../../../utils/debouncer.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';
import '../../../utils/toast/toast_utils.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onSuccess;
  const RegisterPage({Key? key, this.onSuccess}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with DisposableStateMixin, AutomaticKeepAliveClientMixin {
  bool isCheck = false;
  String _fullName = '';
  String _userName = '';
  String _email = '';
  String _password = '';
  SelectMenuModel? _selectMenuModel;
  PlaceAndLocation? _placeAndLocation;
  final RegisterBloc _registerBloc = RegisterBloc(locator.get(), locator.get());
  bool isHiddenPassword = true;
  // ignore: prefer_typing_uninitialized_variables
  var _roles;

  @override
  void initState() {
    super.initState();
    _registerBloc.navigateMainStream.listen((data) {
      ToastUtility.showSuccess(context: context, message: 'Register successful!');
      widget.onSuccess?.call();
    }).disposeOn(disposeBag);
    _registerBloc.getRole();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocHandle(
        bloc: _registerBloc,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing / 2),
          child: Column(
            children: [
              StreamBuilder<List<UserGroup>>(
                stream: _registerBloc.rolesStream,
                builder: (context, snapshot) {
                  _roles ??= snapshot.data?.map((e) => SelectMenuModel(id: e.userGroupId, title: e.title)).toList();
                  return GestureDetector(
                    onTap: () {
                      if (snapshot.data == null || snapshot.data?.isEmpty == true) {
                        _registerBloc.getRole();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.only(top: kVerticalSpacing),
                      child: CommonDropdown(
                        selection: _selectMenuModel,
                        onChanged: (value) {
                          setState(() {
                            _selectMenuModel = value;
                          });
                        },
                        onTap: () {},
                        data: snapshot.hasData ? _roles as List<SelectMenuModel> : [],
                        hint: context.l10n.t_choose_your_role,
                      ),
                    ),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
                child: CommonInput(
                  hintText: context.l10n.t_full_name,
                  onChanged: (value) {
                    setState(() {
                      _fullName = value;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.only(bottom: kVerticalSpacing / 2),
                child: CommonInput(
                  hintText: context.l10n.t_user_name,
                  onChanged: (value) {
                    setState(() {
                      _userName = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: kVerticalSpacing / 2,
                  bottom: kVerticalSpacing,
                  left: kVerticalSpacing / 2,
                  right: kVerticalSpacing / 2,
                ),
                child: GestureDetector(
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
                        });
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.inputFillColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.outlineBorderColor, width: 2),
                    ),
                    child: Text(
                      _placeAndLocation != null ? '${_placeAndLocation?.place?.fullAddress}' : context.l10n.t_location,
                      style: context.body1TextStyle()?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.only(bottom: kVerticalSpacing),
                child: CommonInput(
                  hintText: context.l10n.t_email,
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.only(bottom: kVerticalSpacing),
                child: CommonInput(
                  togglePassword: () {
                    setState(() {
                      isHiddenPassword = !isHiddenPassword;
                    });
                  },
                  hintText: context.l10n.t_password,
                  isHidden: isHiddenPassword,
                  isPasswordField: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
              ),
              CommonCheckbox(
                isChecked: isCheck,
                title: context.l10n.t_sub_register_checkbox,
                onChanged: (value) {
                  setState(() {
                    isCheck = value;
                  });
                },
              ),
              Text.rich(
                TextSpan(
                  text: context.l10n.t_register_text,
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
                  children: <TextSpan>[
                    TextSpan(
                      text: context.l10n.t_term,
                      style: context.bodyTextStyle()?.copyWith(
                            color: AppColors.unActiveLabelItem,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                    // can add more TextSpans here...
                  ],
                ),
              ),
              const SizedBox(
                height: kVerticalSpacing,
              ),
              CommonButton(
                color: isCheck ? AppColors.activeLabelItem : AppColors.primaryButtonColor,
                text: context.l10n.t_sign_up,
                onTap: !isCheck
                    ? null
                    : () {
                        final registerRequest = RegisterRequest()
                          ..valFullName = _fullName
                          ..valEmail = _email
                          ..valUserName = _userName
                          ..valCountryIso = _placeAndLocation?.place?.zipCode
                          ..valCityLocation = _placeAndLocation?.place?.city
                          ..valRegisterLocationLat = _placeAndLocation?.location?.latitude
                          ..valRegisterLocationLng = _placeAndLocation?.location?.longitude
                          ..valPassword = _password
                          ..valRole = _selectMenuModel?.id;
                        _registerBloc.submitRegister(registerRequest);
                      },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}

class AddressSearch extends SearchDelegate<Suggestion?> {
  RegisterBloc? bloc;
  AddressSearch({this.bloc});
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
      ),
      scaffoldBackgroundColor: AppColors.mainColor,
      appBarTheme: AppBarTheme(
        color: AppColors.semiMainColor,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(headline6: const TextStyle(color: Colors.white)),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
    );
  }

  void queryChanged(String q, BuildContext context) async {
    _debouncer.run(() {
      bloc?.fetchSuggestions(query, Localizations.localeOf(context).languageCode);
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    queryChanged(query, context);
    return StreamBuilder<List<Suggestion>?>(
      key: const Key('1'),
      stream: bloc?.suggestionStream,
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: const EdgeInsets.all(16),
              child: const Text('Enter your address'),
            )
          : snapshot.hasData
              ? snapshot.data?.isEmpty == true
                  ? const EmptyDataStateWidget('Empty data!')
                  : ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        // ignore: cast_nullable_to_non_nullable
                        title: Text((snapshot.data?[index] as Suggestion).description),
                        onTap: () {
                          // ignore: cast_nullable_to_non_nullable
                          close(context, snapshot.data?[index] as Suggestion);
                        },
                      ),
                      itemCount: snapshot.data?.length,
                    )
              : const LoadingWidget(),
    );
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
