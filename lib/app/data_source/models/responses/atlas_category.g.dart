// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atlas_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtlasCategory _$AtlasCategoryFromJson(Map<String, dynamic> json) =>
    AtlasCategory()
      ..userGroupId = json['user_group_id'] as String?
      ..inheritId = json['inherit_id'] as String?
      ..title = json['title'] as String?
      ..isSpecial = json['is_special'] as String?
      ..prefix = json['prefix'] as String?
      ..suffix = json['suffix'] as String?
      ..iconExt = json['icon_ext'] as String?
      ..isNewSignup = json['is_new_signup'] as String?
      ..subCategories = (json['sub_category'] as List<dynamic>?)
          ?.map((e) => AtlasSubCategory.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$AtlasCategoryToJson(AtlasCategory instance) =>
    <String, dynamic>{
      'user_group_id': instance.userGroupId,
      'inherit_id': instance.inheritId,
      'title': instance.title,
      'is_special': instance.isSpecial,
      'prefix': instance.prefix,
      'suffix': instance.suffix,
      'icon_ext': instance.iconExt,
      'is_new_signup': instance.isNewSignup,
      'sub_category': instance.subCategories,
    };

AtlasSubCategory _$AtlasSubCategoryFromJson(Map<String, dynamic> json) =>
    AtlasSubCategory()
      ..optionId = json['option_id'] as String?
      ..title = json['title'] as String?;

Map<String, dynamic> _$AtlasSubCategoryToJson(AtlasSubCategory instance) =>
    <String, dynamic>{
      'option_id': instance.optionId,
      'title': instance.title,
    };
