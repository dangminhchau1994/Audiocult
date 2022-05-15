import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/privacy_settings/privacy_settings_response.dart';
import 'package:audio_cult/app/features/settings/privacy_settings/privacy_settings_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/expandable_wrapper_widget.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({Key? key}) : super(key: key);

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  final _bloc = getIt.get<PrivacySettingsBloc>();
  final _expandableProfileSectionController = ExpandableController(initialExpanded: false);
  final _expandableAppSharingSectionController = ExpandableController(initialExpanded: false);
  final _expandableBlockedSectionController = ExpandableController(initialExpanded: false);

  @override
  void initState() {
    super.initState();
    _bloc.loadPrivacySettings();
    _expandableProfileSectionController.addListener(() {
      _bloc.repushPrivacyProfileStreamIfNeed(_expandableProfileSectionController.value);
      if (_expandableProfileSectionController.value && _expandableAppSharingSectionController.value) {
        _expandableAppSharingSectionController.toggle();
      }
    });
    _expandableAppSharingSectionController.addListener(() {
      _bloc.repushPrivacyItemStreamIfNeed(_expandableAppSharingSectionController.value);
      if (_expandableAppSharingSectionController.value && _expandableProfileSectionController.value) {
        _expandableProfileSectionController.toggle();
      }
    });

    _expandableBlockedSectionController.addListener(() {
      _bloc.repushPrivacyItemStreamIfNeed(_expandableAppSharingSectionController.value);
      if (_expandableAppSharingSectionController.value && _expandableProfileSectionController.value) {
        _expandableProfileSectionController.toggle();
      }
    });
  }

  @override
  void dispose() {
    _expandableProfileSectionController.dispose();
    _expandableAppSharingSectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WKeyboardDismiss(
      child: BlocHandle(
        bloc: _bloc,
        child: Container(color: AppColors.mainColor, child: _body()),
      ),
    );
  }

  Widget _body() {
    return ExpandableTheme(
        data: const ExpandableThemeData(useInkWell: true),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _profileSectionWidget(),
            _appSharingItemsSectionWidget(),
            _blockedSectionWidget(),
          ],
        ));
  }

  Widget _profileSectionWidget() {
    return ExpandableWrapperWidget(
      context.l10n.t_profile,
      _profileSectionContent(),
      description: context.l10n.t_profile_desc,
      controller: _expandableProfileSectionController,
    );
  }

  Widget _profileSectionContent() {
    return StreamBuilder<BlocState<List<PrivacySettingItem>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.loadPrivacyProfileStream,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return ErrorSectionWidget(
            errorMessage: context.l10n.t_no_data_found,
            onRetryTap: _bloc.loadPrivacySettings,
          );
        }
        final state = snapshot.data;
        return state?.when(
              success: (data) {
                final items = data as List<PrivacySettingItem>;
                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return _listViewItemWidget(items[index]);
                  },
                );
              },
              loading: LoadingWidget.new,
              error: (error) {
                return ErrorSectionWidget(
                  errorMessage: error,
                  onRetryTap: _bloc.loadPrivacySettings,
                );
              },
            ) ??
            Container();
      },
    );
  }

  Widget _listViewItemWidget(PrivacySettingItem item, {bool isUppercase = false}) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputFillColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.outlineBorderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              isUppercase ? item.phrase?.toUpperCase() ?? '' : item.phrase ?? '',
              style: context.body1TextStyle(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          _eventViewButton(item.options ?? []),
        ],
      ),
    );
  }

  Widget _eventViewButton(List<PrivacyOption> options) {
    return PopupMenuButton(
      color: AppColors.mainColor,
      child: Container(
        decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets.icGlobe),
            const SizedBox(width: 8),
            Text(
              context.l10n.t_everyone,
              style: context.body3TextStyle(),
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        ..._dropdownOptions(options),
      ],
    );
  }

  List<PopupMenuEntry> _dropdownOptions(List<PrivacyOption> options) {
    return options
        .map(
          (e) => PopupMenuItem(
            onTap: () {},
            child: Text(
              e.phrase ?? '',
              style: context.body1TextStyle()?.copyWith(color: AppColors.activeLabelItem),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList();
  }

  Widget _appSharingItemsSectionWidget() {
    return ExpandableWrapperWidget(
      context.l10n.t_app_sharing_items,
      _appSharingItemsSectionContent(),
      description: context.l10n.t_app_sharing_items_desc,
      controller: _expandableAppSharingSectionController,
    );
  }

  Widget _appSharingItemsSectionContent() {
    return StreamBuilder<BlocState<List<PrivacySettingItem>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.loadPrivacyItemStream,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return ErrorSectionWidget(
            errorMessage: context.l10n.t_no_data_found,
            onRetryTap: _bloc.loadPrivacySettings,
          );
        }
        final state = snapshot.data;
        return state?.when(
              success: (data) {
                final items = data as List<PrivacySettingItem>;
                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return _listViewItemWidget(items[index]);
                  },
                );
              },
              loading: LoadingWidget.new,
              error: (error) {
                return ErrorSectionWidget(
                  errorMessage: error,
                  onRetryTap: _bloc.loadPrivacySettings,
                );
              },
            ) ??
            Container();
      },
    );
  }

  Widget _blockedSectionWidget() {
    return ExpandableWrapperWidget(
      context.l10n.t_blocked,
      Column(
        children: [
          Text(context.l10n.t_blocked_desc),
          ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.red,
                  ),
                );
              })
        ],
      ),
    );
  }
}
