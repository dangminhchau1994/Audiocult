import 'package:json_annotation/json_annotation.dart';

part 'atlas_category.g.dart';

@JsonSerializable()
class AtlasCategory {
  @JsonKey(name: 'user_group_id')
  String? userGroupId;
  @JsonKey(name: 'inherit_id')
  String? inheritId;
  String? title;
  @JsonKey(name: 'is_special')
  String? isSpecial;
  String? prefix;
  String? suffix;
  @JsonKey(name: 'icon_ext')
  String? iconExt;
  @JsonKey(name: 'is_new_signup')
  String? isNewSignup;
  @JsonKey(name: 'sub_category')
  List<AtlasSubCategory>? subCategories;

  AtlasCategory();

  factory AtlasCategory.fromJson(Map<String, dynamic> json) => _$AtlasCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AtlasCategoryToJson(this);
}

@JsonSerializable()
class AtlasSubCategory {
  @JsonKey(name: 'option_id')
  String? optionId;
  String? title;

  AtlasSubCategory();

  factory AtlasSubCategory.fromJson(Map<String, dynamic> json) => _$AtlasSubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AtlasSubCategoryToJson(this);
}
