import 'package:audio_cult/app/data_source/models/responses/page_template_response.dart';
import 'package:audio_cult/app/utils/constants/page_template_field_type.dart';
import 'package:collection/collection.dart';

class PageTemplateCustomField {
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
  List<String?>? customValue;
  String? value;
  String? isSearch;
  String? cgUserGroupId;
  String? cgIsActive;
  List<SelectableOption>? options;
  String? phrase;

  PageTemplateCustomField();

  factory PageTemplateCustomField.fromJson(Map<String, dynamic> json) {
    final profile = PageTemplateCustomField()
      ..fieldId = json['field_id'] as String?
      ..fieldName = json['field_name'] as String?
      ..moduleId = json['module_id'] as String?
      ..productId = json['product_id'] as String?
      ..userGroupId = json['user_group_id'] as String?
      ..typeId = json['type_id'] as String?
      ..groupId = json['group_id'] as String?
      ..phraseVarName = json['phrase_var_name'] as String?
      ..typeName = json['type_name'] as String?
      ..varType = PageTemplateFieldTypeExtension.init(json['var_type'] as String)
      ..isActive = json['is_active'] as String?
      ..isRequired = json['is_required'] as String?
      ..hasFeed = json['has_feed'] as String?
      ..onSignup = json['on_signup'] as String?
      ..ordering = json['ordering'] as String?
      ..value = json['value'] as String?
      ..isSearch = json['is_search'] as String?
      ..cgUserGroupId = json['cg_user_group_id'] as String?
      ..cgIsActive = json['cg_is_active'] as String?
      ..phrase = json['phrase'] as String?;
    if (json['customValue'].runtimeType == String) {
      profile.customValue = [json['customValue'] as String];
    } else {
      profile.customValue = (json['customValue'] as List<dynamic>?)?.map((e) => e as String?).toList();
    }
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
