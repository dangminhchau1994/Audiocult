import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/blocked_user.dart';
import 'package:audio_cult/app/data_source/models/responses/privacy_settings/privacy_settings_response.dart';
import 'package:audio_cult/app/features/settings/privacy_settings/privacy_settings_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/error_empty/widget_state.dart';
import 'package:audio_cult/w_components/expandable_wrapper_widget.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
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
      if (_expandableProfileSectionController.value) {
        closeExpandableWidgetIfOpen(_expandableAppSharingSectionController);
        closeExpandableWidgetIfOpen(_expandableBlockedSectionController);
      }
    });
    _expandableAppSharingSectionController.addListener(() {
      _bloc.repushAppSharingStreamIfNeed(_expandableAppSharingSectionController.value);
      if (_expandableAppSharingSectionController.value) {
        closeExpandableWidgetIfOpen(_expandableProfileSectionController);
        closeExpandableWidgetIfOpen(_expandableBlockedSectionController);
      }
    });
    _expandableBlockedSectionController.addListener(() {
      _bloc.repushBlockedUsersStreamIfNeed(_expandableBlockedSectionController.value);
      if (_expandableBlockedSectionController.value) {
        closeExpandableWidgetIfOpen(_expandableProfileSectionController);
        closeExpandableWidgetIfOpen(_expandableAppSharingSectionController);
      }
    });
  }

  void closeExpandableWidgetIfOpen(ExpandableController controller) {
    if (!controller.value) return;
    controller.toggle();
  }

  @override
  void dispose() {
    _expandableProfileSectionController.dispose();
    _expandableAppSharingSectionController.dispose();
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
            _blockedUsersSectionWidget(),
          ],
        ));
  }

  Widget _profileSectionWidget() {
    return ExpandableWrapperWidget(
      context.localize.t_profile,
      _profileSectionContent(),
      description: context.localize.t_profile_desc,
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
            errorMessage: context.localize.t_no_data_found,
            onRetryTap: _bloc.loadPrivacySettings,
          );
        }
        final state = snapshot.data;
        return state?.when(
              success: (data) {
                final items = data as List<PrivacySettingItem>;
                return Column(
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _listViewItemWidget(items[index], PrivacySettingsSection.profile);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: _updateButtonProfile(),
                    ),
                  ],
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

  Widget _updateButtonProfile() {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _bloc.enableUpdateProfileStream,
      builder: (_, snapshot) {
        final isEnable = snapshot.data!;
        return CommonButton(
          text: context.localize.t_update,
          onTap: isEnable ? _bloc.saveDataProfileSection : null,
          color: AppColors.primaryButtonColor,
        );
      },
    );
  }

  Widget _listViewItemWidget(
    PrivacySettingItem item,
    PrivacySettingsSection section, {
    bool isUppercase = false,
  }) {
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
          _eventViewButton(
            item.options ?? [],
            (option) {
              _bloc.selectOption(section: section, item: item, option: option);
            },
            item.defaultValue ?? 1,
          ),
        ],
      ),
    );
  }

  Widget _eventViewButton(
    List<PrivacyOption> options,
    Function(PrivacyOption) callback,
    int selectedValue,
  ) {
    return PopupMenuButton(
      color: AppColors.mainColor,
      child: Container(
        width: 120,
        decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets.icGlobe),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                options.firstWhereOrNull((element) => element.value == selectedValue)?.phrase ?? '',
                style: context.body3TextStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        ..._dropdownOptions(options, callback, selectedValue),
      ],
    );
  }

  List<PopupMenuEntry> _dropdownOptions(
    List<PrivacyOption> options,
    Function(PrivacyOption) callback,
    int selectedValue,
  ) {
    return options
        .map(
          (e) => PopupMenuItem(
            onTap: () => callback(e),
            child: Text(
              e.phrase ?? '',
              style: context
                  .body1TextStyle()
                  ?.copyWith(color: e.value == selectedValue ? AppColors.activeLabelItem : Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList();
  }

  Widget _appSharingItemsSectionWidget() {
    return ExpandableWrapperWidget(
      context.localize.t_app_sharing_items,
      _appSharingItemsSectionContent(),
      description: context.localize.t_app_sharing_items_desc,
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
            errorMessage: context.localize.t_no_data_found,
            onRetryTap: _bloc.loadPrivacySettings,
          );
        }
        final state = snapshot.data;
        return state?.when(
              success: (data) {
                final items = data as List<PrivacySettingItem>;
                return Column(
                  children: [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _listViewItemWidget(items[index], PrivacySettingsSection.appSharing);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: _updateButtonAppSharing(),
                    ),
                  ],
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

  Widget _updateButtonAppSharing() {
    return StreamBuilder<bool>(
      stream: _bloc.enableUpdateAppSharingStream,
      initialData: false,
      builder: (_, snapshot) {
        final isEnable = snapshot.data!;
        return CommonButton(
          text: context.localize.t_update,
          onTap: isEnable ? _bloc.saveDataAppSharingSection : null,
          color: AppColors.primaryButtonColor,
        );
      },
    );
  }

  Widget _blockedUsersSectionWidget() {
    return ExpandableWrapperWidget(
      context.localize.t_blocked,
      _blockedUsersSectionContent(),
      description: context.localize.t_blocked_desc,
      controller: _expandableBlockedSectionController,
    );
  }

  Widget _blockedUsersSectionContent() {
    return StreamBuilder<BlocState<List<BlockedUser>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.loadBlockedUsersStream,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return ErrorSectionWidget(
            errorMessage: context.localize.t_no_data_found,
            onRetryTap: _bloc.loadPrivacySettings,
          );
        }
        final state = snapshot.data;
        return state?.when(
              success: (data) {
                final items = data as List<BlockedUser>;
                if (items.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: EmptyDataStateWidget(context.localize.t_no_data),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (_, index) => _blockedUserWidget(items[index], index == items.length - 1),
                  ),
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

  Widget _blockedUserWidget(BlockedUser user, bool isLast) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.square(
              dimension: 50,
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                fit: BoxFit.cover,
                errorWidget: (BuildContext context, _, __) => const Image(
                  fit: BoxFit.cover,
                  image: AssetImage(AppAssets.imagePlaceholder),
                ),
                placeholder: (BuildContext context, _) => const LoadingWidget(),
                imageUrl: user.userImageUrl ?? '',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.fullName ?? '', style: context.headerStyle1()?.copyWith(fontWeight: FontWeight.w400)),
                    Text(
                      user.userGroupTitle ?? '',
                      style: context.bodyTextStyle()?.copyWith(color: AppColors.subTitleColor),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.inputFillColor,
                ),
                child: Text(
                  context.localize.t_unblock,
                  style: context.body2TextStyle()?.copyWith(color: Colors.white),
                ),
              ),
              onPressed: () => _bloc.unblockUser(user),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: isLast ? Container() : Divider(color: AppColors.inputFillColor),
        )
      ],
    );
  }
}
