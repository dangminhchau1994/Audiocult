import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/account_settings.dart';
import 'package:audio_cult/app/data_source/models/responses/language_response.dart';
import 'package:audio_cult/app/data_source/models/responses/timezone/timezone_response.dart';
import 'package:audio_cult/app/data_source/models/update_account_settings_response.dart';
import 'package:audio_cult/app/features/settings/account_settings/account_settings_bloc.dart';
import 'package:audio_cult/app/features/settings/page_template_widgets/single_selection_widget.dart';
import 'package:audio_cult/app/features/settings/page_template_widgets/textfield_widget.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/expandable_wrapper_widget.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tuple/tuple.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> with AutomaticKeepAliveClientMixin {
  final _bloc = getIt.get<AccountSettingsBloc>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc.loadUserProfile();
    _bloc.updateAccountStream.listen((event) {
      event.when(
        success: (data) {
          final tupleData = data as Tuple2<UpdateAccountSettingsResponse?, bool?>;
          final response = tupleData.item1;
          final shouldBackHome = tupleData.item2 ?? false;
          if (tupleData.item1?.error == null) {
            ToastUtility.showSuccess(context: context, message: response?.message);
            if (shouldBackHome) {
              Phoenix.rebirth(context);
            }
          } else {
            ToastUtility.showError(context: context, message: response?.error);
          }
        },
        loading: () {},
        error: (error) {
          ToastUtility.showError(context: context, message: error);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WKeyboardDismiss(
        child: BlocHandle(
      bloc: _bloc,
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        color: AppColors.mainColor,
        child: ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: Colors.blue,
            useInkWell: false,
          ),
          child: StreamBuilder<BlocState<AccountSettings?>>(
            initialData: const BlocState.loading(),
            stream: _bloc.loadProfileStream,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final state = snapshot.data;
                return state?.when(
                      success: (data) {
                        final account = data as AccountSettings;
                        return _body(account);
                      },
                      loading: LoadingWidget.new,
                      error: (error) {
                        return Container();
                      },
                    ) ??
                    Container();
              }
              return Container();
            },
          ),
        ),
      ),
    ));
  }

  Widget _body(AccountSettings account) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        ExpandableWrapperWidget(
          context.localize.t_account_settings,
          _accountSettingsWidget(context, account),
          headerPadding: EdgeInsets.zero,
          headerColor: Colors.transparent,
        ),
        ExpandableWrapperWidget(
          context.localize.t_change_password,
          _changePasswordWidget(context, account: account),
          headerPadding: EdgeInsets.zero,
          headerColor: Colors.transparent,
        ),
        ExpandableWrapperWidget(
          context.localize.t_payment_methods,
          _paymentMethodsWidget(context, account: account),
          headerPadding: EdgeInsets.zero,
          headerColor: Colors.transparent,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: CommonButton(
            color: AppColors.primaryButtonColor,
            text: context.localize.t_cancel_account,
            onTap: () {
              Navigator.pushNamed(context, AppRoute.routeDeleteAccount);
            },
          ),
        )
      ],
    );
  }

  Widget _accountSettingsWidget(BuildContext context, AccountSettings account) {
    final tempAccount = account.clone();
    return Container(
      color: AppColors.mainColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextfieldWidget(
            context.localize.t_full_name,
            initialText: tempAccount.fullName,
            onChanged: (string) {
              account.fullName = string;
              _bloc.accountSettingsDataOnChanged(account.clone());
            },
          ),
          TextfieldWidget(
            context.localize.t_email,
            initialText: tempAccount.email,
            onChanged: (string) {
              account.email = string;
              _bloc.accountSettingsDataOnChanged(account.clone());
            },
          ),
          const SizedBox(height: 24),
          _languageWidget(),
          _timezoneWidget(),
          const SizedBox(height: 24),
          _updateAccountButton(),
        ],
      ),
    );
  }

  Widget _updateAccountButton() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _bloc.accountUpdatedStream,
      builder: (_, snapshot) {
        return CommonButton(
          text: context.localize.t_update,
          color: AppColors.primaryButtonColor,
          onTap: snapshot.data == true ? _bloc.updateAccountSettings : null,
        );
      },
    );
  }

  Widget _languageWidget() {
    return StreamBuilder<BlocState<Tuple2<List<Language>, Language?>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.loadLanguagesStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data;
          return state?.when(
                  success: (data) {
                    final languages = data.item1 as List<Language>;
                    final selectedLanguage = data.item2 as Language;
                    final options = languages.map((e) {
                      return SelectMenuModel(title: e.title, isSelected: e.languageId == selectedLanguage.languageId);
                    }).toList();
                    return SingleSelectionWidget(
                      context.localize.t_primary_language,
                      options,
                      onSelected: (selection) {
                        _bloc.languageOnChanged(languages.firstWhereOrNull(
                          (element) => element.title == selection.title,
                        ));
                      },
                    );
                  },
                  loading: LoadingWidget.new,
                  error: (_) => Container()) ??
              Container();
        }
        return Container();
      },
    );
  }

  Widget _timezoneWidget() {
    return StreamBuilder<BlocState<Tuple2<List<TimeZone>, TimeZone?>>>(
      stream: _bloc.loadTimeZonesStream,
      initialData: const BlocState.loading(),
      builder: (_, snapshot) {
        final state = snapshot.data;
        return state?.when(
                success: (data) {
                  final timeZones = data.item1 as List<TimeZone>;
                  final selectedTimeZone = data.item2 as TimeZone;
                  final options = timeZones.map((e) {
                    return SelectMenuModel(
                      title: e.value,
                      isSelected: e.value?.toLowerCase() == selectedTimeZone.value?.toLowerCase(),
                    );
                  }).toList();
                  return SingleSelectionWidget(
                    context.localize.t_timezone,
                    options,
                    onSelected: (selection) {
                      _bloc.timezoneOnChanged(timeZones.firstWhereOrNull(
                        (element) => element.value == selection.title,
                      ));
                    },
                  );
                },
                loading: LoadingWidget.new,
                error: (error) {
                  return ErrorWidget(error);
                }) ??
            Container();
      },
    );
  }

  Widget _changePasswordWidget(BuildContext context, {AccountSettings? account}) {
    final tempProfile = account;
    return Container(
      color: AppColors.mainColor,
      width: double.infinity,
      child: Column(
        children: [
          Text(context.localize.t_change_password_note),
          TextfieldWidget(
            context.localize.t_change_password,
            onChanged: (currentPass) {
              tempProfile?.currentPass = currentPass;
              _bloc.accountSettingsDataOnChanged(tempProfile);
            },
          ),
          TextfieldWidget(
            context.localize.t_new_password,
            onChanged: (newPass) {
              tempProfile?.newPass = newPass;
              _bloc.accountSettingsDataOnChanged(tempProfile);
            },
          ),
          TextfieldWidget(
            context.localize.t_confirm_new_password,
            onChanged: (confirmPass) {
              tempProfile?.confirmPass = confirmPass;
              _bloc.accountSettingsDataOnChanged(tempProfile);
            },
          ),
          const SizedBox(height: 24),
          _changePasswordButton(),
        ],
      ),
    );
  }

  Widget _changePasswordButton() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _bloc.passwordUpdatedStream,
      builder: (_, snapshot) {
        return CommonButton(
          text: context.localize.t_update,
          color: AppColors.primaryButtonColor,
          onTap: snapshot.data == true ? _bloc.updateAccountSettings : null,
        );
      },
    );
  }

  Widget _paymentMethodsWidget(BuildContext context, {AccountSettings? account}) {
    return Column(
      children: [
        Text(context.localize.t_payment_methods_note),
        TextfieldWidget(
          context.localize.t_paypal_email,
          onChanged: (email) {
            account?.paypalEmail = email;
            _bloc.accountSettingsDataOnChanged(account);
          },
        ),
        const SizedBox(height: 24),
        _changePaymentMethodButton(),
      ],
    );
  }

  Widget _changePaymentMethodButton() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _bloc.paymentMethodStream,
      builder: (_, snapshot) {
        return CommonButton(
          text: context.localize.t_update,
          color: AppColors.primaryButtonColor,
          onTap: snapshot.data == true ? _bloc.updateAccountSettings : null,
        );
      },
    );
  }
}
