import 'package:audio_cult/app/base/index_walker.dart';
import 'package:audio_cult/app/data_source/models/responses/page_template_response.dart';
import 'package:audio_cult/app/utils/constants/page_template_field_type.dart';
import 'package:collection/collection.dart';

class PageTemplateCustomFieldConfig {
  String? fieldId;
  String? fieldName;
  String? moduleId;
  String? productId;
  String? userGroupId;
  String? typeId;
  String? groupId;
  String? phraseVarName;
  String? typeName;
  PageTemplateFieldType? varType;
  String? isActive;
  String? isRequired;
  String? hasFeed;
  String? onSignup;
  String? ordering;
  String? value;
  String? isSearch;
  String? cgUserGroupId;
  String? cgIsActive;
  List<SelectableOption>? options;
  String? phrase;

  PageTemplateCustomFieldConfig();

  factory PageTemplateCustomFieldConfig.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    final profile = PageTemplateCustomFieldConfig()
      ..fieldId = iw['field_id'].get()
      ..fieldName = iw['field_name'].get()
      ..moduleId = iw['module_id'].get()
      ..productId = iw['product_id'].get()
      ..userGroupId = iw['user_group_id'].get()
      ..typeId = iw['type_id'].get()
      ..groupId = iw['group_id'].get()
      ..phraseVarName = iw['phrase_var_name'].get()
      ..typeName = iw['type_name'].get()
      ..varType = PageTemplateFieldTypeExtension.init(iw['var_type'].getString ?? '')
      ..isActive = iw['is_active'].get()
      ..isRequired = iw['is_required'].get()
      ..hasFeed = iw['has_feed'].get()
      ..onSignup = iw['on_signup'].get()
      ..ordering = iw['ordering'].get()
      ..value = iw['value'].get()
      ..isSearch = iw['is_search'].get()
      ..cgUserGroupId = iw['cg_user_group_id'].get()
      ..cgIsActive = iw['cg_is_active'].get()
      ..phrase = iw['phrase'].get();
    return profile;
  }

  List<SelectableOption?>? get getSelectedOptions {
    if (options?.isNotEmpty == true) {
      return options?.where((element) => element.selected == true).toList();
    }
    return null;
  }

  String? get getTextValue {
    return value;
  }

  void updateSelectedOption(SelectableOption option) {
    if (varType == PageTemplateFieldType.multiselect) {
      final selectedOption =
          options?.firstWhereOrNull((element) => element.value?.toLowerCase() == option.value?.toLowerCase());
      selectedOption?.selected = !(selectedOption.selected ?? false);
    } else if (varType == PageTemplateFieldType.select || varType == PageTemplateFieldType.radio) {
      final oldSelectedOption = options?.firstWhereOrNull((element) => element.selected == true);
      oldSelectedOption?.selected = false;
      final newSelectedOption =
          options?.firstWhereOrNull((element) => element.value?.toLowerCase() == option.value?.toLowerCase());
      newSelectedOption?.selected = true;
    }
  }

  // ignore: use_setters_to_change_properties
  void updateTextValue(String? string) {
    value = string;
  }
}
