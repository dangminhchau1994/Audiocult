import 'package:freezed_annotation/freezed_annotation.dart';

part 'background_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BackgroundResponse {
  String? collectionId;
  String? title;
  String? isActive;
  String? isDefault;
  String? isDeleted;
  String? mainImageId;
  String? timeStamp;
  String? viewId;
  String? totalBackground;
  List<BackgroundsList>? backgroundsList;

  BackgroundResponse({
    this.collectionId,
    this.title,
    this.isActive,
    this.isDefault,
    this.isDeleted,
    this.mainImageId,
    this.timeStamp,
    this.viewId,
    this.totalBackground,
    this.backgroundsList,
  });

  factory BackgroundResponse.fromJson(Map<String, dynamic> json) => _$BackgroundResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BackgroundsList {
  String? backgroundId;
  String? collectionId;
  String? imagePath;
  String? serverId;
  String? ordering;
  String? isDeleted;
  String? timeStamp;
  String? viewId;
  String? fullPath;
  String? imageUrl;

  BackgroundsList({
    this.backgroundId,
    this.collectionId,
    this.imagePath,
    this.serverId,
    this.ordering,
    this.isDeleted,
    this.timeStamp,
    this.viewId,
    this.fullPath,
    this.imageUrl,
  });

  factory BackgroundsList.fromJson(Map<String, dynamic> json) => _$BackgroundsListFromJson(json);
}
