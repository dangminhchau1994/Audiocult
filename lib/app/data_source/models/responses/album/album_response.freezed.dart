// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'album_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AlbumResponse _$AlbumResponseFromJson(Map<String, dynamic> json) {
  return _AlbumResponse.fromJson(json);
}

/// @nodoc
mixin _$AlbumResponse {
  String? get status => throw _privateConstructorUsedError;
  List<Album>? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  dynamic get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlbumResponseCopyWith<AlbumResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumResponseCopyWith<$Res> {
  factory $AlbumResponseCopyWith(
          AlbumResponse value, $Res Function(AlbumResponse) then) =
      _$AlbumResponseCopyWithImpl<$Res>;
  $Res call(
      {String? status, List<Album>? data, String? message, dynamic error});
}

/// @nodoc
class _$AlbumResponseCopyWithImpl<$Res>
    implements $AlbumResponseCopyWith<$Res> {
  _$AlbumResponseCopyWithImpl(this._value, this._then);

  final AlbumResponse _value;
  // ignore: unused_field
  final $Res Function(AlbumResponse) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Album>?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_AlbumResponseCopyWith<$Res>
    implements $AlbumResponseCopyWith<$Res> {
  factory _$$_AlbumResponseCopyWith(
          _$_AlbumResponse value, $Res Function(_$_AlbumResponse) then) =
      __$$_AlbumResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? status, List<Album>? data, String? message, dynamic error});
}

/// @nodoc
class __$$_AlbumResponseCopyWithImpl<$Res>
    extends _$AlbumResponseCopyWithImpl<$Res>
    implements _$$_AlbumResponseCopyWith<$Res> {
  __$$_AlbumResponseCopyWithImpl(
      _$_AlbumResponse _value, $Res Function(_$_AlbumResponse) _then)
      : super(_value, (v) => _then(v as _$_AlbumResponse));

  @override
  _$_AlbumResponse get _value => super._value as _$_AlbumResponse;

  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_AlbumResponse(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      data: data == freezed
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Album>?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AlbumResponse implements _AlbumResponse {
  _$_AlbumResponse(
      {this.status, final List<Album>? data, this.message, this.error})
      : _data = data;

  factory _$_AlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$$_AlbumResponseFromJson(json);

  @override
  final String? status;
  final List<Album>? _data;
  @override
  List<Album>? get data {
    final value = _data;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? message;
  @override
  final dynamic error;

  @override
  String toString() {
    return 'AlbumResponse(status: $status, data: $data, message: $message, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AlbumResponse &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$$_AlbumResponseCopyWith<_$_AlbumResponse> get copyWith =>
      __$$_AlbumResponseCopyWithImpl<_$_AlbumResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AlbumResponseToJson(this);
  }
}

abstract class _AlbumResponse implements AlbumResponse {
  factory _AlbumResponse(
      {final String? status,
      final List<Album>? data,
      final String? message,
      final dynamic error}) = _$_AlbumResponse;

  factory _AlbumResponse.fromJson(Map<String, dynamic> json) =
      _$_AlbumResponse.fromJson;

  @override
  String? get status => throw _privateConstructorUsedError;
  @override
  List<Album>? get data => throw _privateConstructorUsedError;
  @override
  String? get message => throw _privateConstructorUsedError;
  @override
  dynamic get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AlbumResponseCopyWith<_$_AlbumResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

LastIcon _$LastIconFromJson(Map<String, dynamic> json) {
  return _LastIcon.fromJson(json);
}

/// @nodoc
mixin _$LastIcon {
// ignore: invalid_annotation_target
  @JsonKey(name: 'like_type_id')
  String? get likeTypeId =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'image_path')
  String? get imagePath =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'count_icon')
  String? get countIcon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LastIconCopyWith<LastIcon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastIconCopyWith<$Res> {
  factory $LastIconCopyWith(LastIcon value, $Res Function(LastIcon) then) =
      _$LastIconCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'like_type_id') String? likeTypeId,
      @JsonKey(name: 'image_path') String? imagePath,
      @JsonKey(name: 'count_icon') String? countIcon});
}

/// @nodoc
class _$LastIconCopyWithImpl<$Res> implements $LastIconCopyWith<$Res> {
  _$LastIconCopyWithImpl(this._value, this._then);

  final LastIcon _value;
  // ignore: unused_field
  final $Res Function(LastIcon) _then;

  @override
  $Res call({
    Object? likeTypeId = freezed,
    Object? imagePath = freezed,
    Object? countIcon = freezed,
  }) {
    return _then(_value.copyWith(
      likeTypeId: likeTypeId == freezed
          ? _value.likeTypeId
          : likeTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      countIcon: countIcon == freezed
          ? _value.countIcon
          : countIcon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_LastIconCopyWith<$Res> implements $LastIconCopyWith<$Res> {
  factory _$$_LastIconCopyWith(
          _$_LastIcon value, $Res Function(_$_LastIcon) then) =
      __$$_LastIconCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'like_type_id') String? likeTypeId,
      @JsonKey(name: 'image_path') String? imagePath,
      @JsonKey(name: 'count_icon') String? countIcon});
}

/// @nodoc
class __$$_LastIconCopyWithImpl<$Res> extends _$LastIconCopyWithImpl<$Res>
    implements _$$_LastIconCopyWith<$Res> {
  __$$_LastIconCopyWithImpl(
      _$_LastIcon _value, $Res Function(_$_LastIcon) _then)
      : super(_value, (v) => _then(v as _$_LastIcon));

  @override
  _$_LastIcon get _value => super._value as _$_LastIcon;

  @override
  $Res call({
    Object? likeTypeId = freezed,
    Object? imagePath = freezed,
    Object? countIcon = freezed,
  }) {
    return _then(_$_LastIcon(
      likeTypeId: likeTypeId == freezed
          ? _value.likeTypeId
          : likeTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      countIcon: countIcon == freezed
          ? _value.countIcon
          : countIcon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LastIcon implements _LastIcon {
  _$_LastIcon(
      {@JsonKey(name: 'like_type_id') this.likeTypeId,
      @JsonKey(name: 'image_path') this.imagePath,
      @JsonKey(name: 'count_icon') this.countIcon});

  factory _$_LastIcon.fromJson(Map<String, dynamic> json) =>
      _$$_LastIconFromJson(json);

// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'like_type_id')
  final String? likeTypeId;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'image_path')
  final String? imagePath;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'count_icon')
  final String? countIcon;

  @override
  String toString() {
    return 'LastIcon(likeTypeId: $likeTypeId, imagePath: $imagePath, countIcon: $countIcon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LastIcon &&
            const DeepCollectionEquality()
                .equals(other.likeTypeId, likeTypeId) &&
            const DeepCollectionEquality().equals(other.imagePath, imagePath) &&
            const DeepCollectionEquality().equals(other.countIcon, countIcon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(likeTypeId),
      const DeepCollectionEquality().hash(imagePath),
      const DeepCollectionEquality().hash(countIcon));

  @JsonKey(ignore: true)
  @override
  _$$_LastIconCopyWith<_$_LastIcon> get copyWith =>
      __$$_LastIconCopyWithImpl<_$_LastIcon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LastIconToJson(this);
  }
}

abstract class _LastIcon implements LastIcon {
  factory _LastIcon(
      {@JsonKey(name: 'like_type_id') final String? likeTypeId,
      @JsonKey(name: 'image_path') final String? imagePath,
      @JsonKey(name: 'count_icon') final String? countIcon}) = _$_LastIcon;

  factory _LastIcon.fromJson(Map<String, dynamic> json) = _$_LastIcon.fromJson;

  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'like_type_id')
  String? get likeTypeId => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'image_path')
  String? get imagePath => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'count_icon')
  String? get countIcon => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_LastIconCopyWith<_$_LastIcon> get copyWith =>
      throw _privateConstructorUsedError;
}

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return _Album.fromJson(json);
}

/// @nodoc
mixin _$Album {
  bool? get isLiked =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'user_id')
  String? get userId =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'user_name')
  String? get userName =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'last_icon')
  LastIcon? get lastIcon =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get userImage => throw _privateConstructorUsedError;
  String? get isInvisible =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'album_id')
  String? get albumId => throw _privateConstructorUsedError;
  String? get viewId => throw _privateConstructorUsedError;
  String? get privacy => throw _privateConstructorUsedError;
  String? get privacyComment => throw _privateConstructorUsedError;
  String? get isFeatured => throw _privateConstructorUsedError;
  String? get isSponsor =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  String? get year => throw _privateConstructorUsedError;
  @JsonKey(name: 'genre_id')
  String? get genreId => throw _privateConstructorUsedError;
  String? get isDj => throw _privateConstructorUsedError;
  @JsonKey(name: 'license_type')
  String? get licenseType =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'image_path')
  String? get imagePath => throw _privateConstructorUsedError;
  String? get serverId => throw _privateConstructorUsedError;
  String? get totalTrack =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'total_play')
  String? get totalPlay =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'total_comment')
  String? get totalComment => throw _privateConstructorUsedError;
  String? get totalView =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'total_like')
  String? get totalLike => throw _privateConstructorUsedError;
  String? get totalDislike => throw _privateConstructorUsedError;
  String? get totalScore => throw _privateConstructorUsedError;
  String? get totalRating =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'total_attachment')
  String? get totalAttachment =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'time_stamp')
  String? get timeStamp => throw _privateConstructorUsedError;
  dynamic get moduleId => throw _privateConstructorUsedError;
  String? get itemId => throw _privateConstructorUsedError;
  dynamic get isDay => throw _privateConstructorUsedError;
  String? get artistId => throw _privateConstructorUsedError;
  String? get itunes => throw _privateConstructorUsedError;
  String? get amazon => throw _privateConstructorUsedError;
  String? get googleplay => throw _privateConstructorUsedError;
  dynamic get youtube => throw _privateConstructorUsedError;
  String? get soundcloud =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'label_user')
  ProfileData? get labelUser => throw _privateConstructorUsedError;
  String? get labelUserId =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'artist_user')
  ProfileData? get artistUser => throw _privateConstructorUsedError;
  String? get artistUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'collab_user')
  ProfileData? get collabUser => throw _privateConstructorUsedError;
  String? get collabUserId => throw _privateConstructorUsedError;
  bool? get canEdit => throw _privateConstructorUsedError;
  bool? get canAddSong => throw _privateConstructorUsedError;
  bool? get canDelete => throw _privateConstructorUsedError;
  bool? get canPurchaseSponsor => throw _privateConstructorUsedError;
  bool? get canSponsor => throw _privateConstructorUsedError;
  bool? get canFeature => throw _privateConstructorUsedError;
  bool? get hasPermission => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlbumCopyWith<Album> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumCopyWith<$Res> {
  factory $AlbumCopyWith(Album value, $Res Function(Album) then) =
      _$AlbumCopyWithImpl<$Res>;
  $Res call(
      {bool? isLiked,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'last_icon') LastIcon? lastIcon,
      @JsonKey(name: 'full_name') String? fullName,
      String? text,
      String? userImage,
      String? isInvisible,
      @JsonKey(name: 'album_id') String? albumId,
      String? viewId,
      String? privacy,
      String? privacyComment,
      String? isFeatured,
      String? isSponsor,
      @JsonKey(name: 'name') String? name,
      String? year,
      @JsonKey(name: 'genre_id') String? genreId,
      String? isDj,
      @JsonKey(name: 'license_type') String? licenseType,
      @JsonKey(name: 'image_path') String? imagePath,
      String? serverId,
      String? totalTrack,
      @JsonKey(name: 'total_play') String? totalPlay,
      @JsonKey(name: 'total_comment') String? totalComment,
      String? totalView,
      @JsonKey(name: 'total_like') String? totalLike,
      String? totalDislike,
      String? totalScore,
      String? totalRating,
      @JsonKey(name: 'total_attachment') String? totalAttachment,
      @JsonKey(name: 'time_stamp') String? timeStamp,
      dynamic moduleId,
      String? itemId,
      dynamic isDay,
      String? artistId,
      String? itunes,
      String? amazon,
      String? googleplay,
      dynamic youtube,
      String? soundcloud,
      @JsonKey(name: 'label_user') ProfileData? labelUser,
      String? labelUserId,
      @JsonKey(name: 'artist_user') ProfileData? artistUser,
      String? artistUserId,
      @JsonKey(name: 'collab_user') ProfileData? collabUser,
      String? collabUserId,
      bool? canEdit,
      bool? canAddSong,
      bool? canDelete,
      bool? canPurchaseSponsor,
      bool? canSponsor,
      bool? canFeature,
      bool? hasPermission});

  $LastIconCopyWith<$Res>? get lastIcon;
}

/// @nodoc
class _$AlbumCopyWithImpl<$Res> implements $AlbumCopyWith<$Res> {
  _$AlbumCopyWithImpl(this._value, this._then);

  final Album _value;
  // ignore: unused_field
  final $Res Function(Album) _then;

  @override
  $Res call({
    Object? isLiked = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? lastIcon = freezed,
    Object? fullName = freezed,
    Object? text = freezed,
    Object? userImage = freezed,
    Object? isInvisible = freezed,
    Object? albumId = freezed,
    Object? viewId = freezed,
    Object? privacy = freezed,
    Object? privacyComment = freezed,
    Object? isFeatured = freezed,
    Object? isSponsor = freezed,
    Object? name = freezed,
    Object? year = freezed,
    Object? genreId = freezed,
    Object? isDj = freezed,
    Object? licenseType = freezed,
    Object? imagePath = freezed,
    Object? serverId = freezed,
    Object? totalTrack = freezed,
    Object? totalPlay = freezed,
    Object? totalComment = freezed,
    Object? totalView = freezed,
    Object? totalLike = freezed,
    Object? totalDislike = freezed,
    Object? totalScore = freezed,
    Object? totalRating = freezed,
    Object? totalAttachment = freezed,
    Object? timeStamp = freezed,
    Object? moduleId = freezed,
    Object? itemId = freezed,
    Object? isDay = freezed,
    Object? artistId = freezed,
    Object? itunes = freezed,
    Object? amazon = freezed,
    Object? googleplay = freezed,
    Object? youtube = freezed,
    Object? soundcloud = freezed,
    Object? labelUser = freezed,
    Object? labelUserId = freezed,
    Object? artistUser = freezed,
    Object? artistUserId = freezed,
    Object? collabUser = freezed,
    Object? collabUserId = freezed,
    Object? canEdit = freezed,
    Object? canAddSong = freezed,
    Object? canDelete = freezed,
    Object? canPurchaseSponsor = freezed,
    Object? canSponsor = freezed,
    Object? canFeature = freezed,
    Object? hasPermission = freezed,
  }) {
    return _then(_value.copyWith(
      isLiked: isLiked == freezed
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastIcon: lastIcon == freezed
          ? _value.lastIcon
          : lastIcon // ignore: cast_nullable_to_non_nullable
              as LastIcon?,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: userImage == freezed
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isInvisible: isInvisible == freezed
          ? _value.isInvisible
          : isInvisible // ignore: cast_nullable_to_non_nullable
              as String?,
      albumId: albumId == freezed
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String?,
      viewId: viewId == freezed
          ? _value.viewId
          : viewId // ignore: cast_nullable_to_non_nullable
              as String?,
      privacy: privacy == freezed
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as String?,
      privacyComment: privacyComment == freezed
          ? _value.privacyComment
          : privacyComment // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: isFeatured == freezed
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as String?,
      isSponsor: isSponsor == freezed
          ? _value.isSponsor
          : isSponsor // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
      genreId: genreId == freezed
          ? _value.genreId
          : genreId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDj: isDj == freezed
          ? _value.isDj
          : isDj // ignore: cast_nullable_to_non_nullable
              as String?,
      licenseType: licenseType == freezed
          ? _value.licenseType
          : licenseType // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      serverId: serverId == freezed
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      totalTrack: totalTrack == freezed
          ? _value.totalTrack
          : totalTrack // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPlay: totalPlay == freezed
          ? _value.totalPlay
          : totalPlay // ignore: cast_nullable_to_non_nullable
              as String?,
      totalComment: totalComment == freezed
          ? _value.totalComment
          : totalComment // ignore: cast_nullable_to_non_nullable
              as String?,
      totalView: totalView == freezed
          ? _value.totalView
          : totalView // ignore: cast_nullable_to_non_nullable
              as String?,
      totalLike: totalLike == freezed
          ? _value.totalLike
          : totalLike // ignore: cast_nullable_to_non_nullable
              as String?,
      totalDislike: totalDislike == freezed
          ? _value.totalDislike
          : totalDislike // ignore: cast_nullable_to_non_nullable
              as String?,
      totalScore: totalScore == freezed
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as String?,
      totalRating: totalRating == freezed
          ? _value.totalRating
          : totalRating // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAttachment: totalAttachment == freezed
          ? _value.totalAttachment
          : totalAttachment // ignore: cast_nullable_to_non_nullable
              as String?,
      timeStamp: timeStamp == freezed
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
      moduleId: moduleId == freezed
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      itemId: itemId == freezed
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDay: isDay == freezed
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as dynamic,
      artistId: artistId == freezed
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String?,
      itunes: itunes == freezed
          ? _value.itunes
          : itunes // ignore: cast_nullable_to_non_nullable
              as String?,
      amazon: amazon == freezed
          ? _value.amazon
          : amazon // ignore: cast_nullable_to_non_nullable
              as String?,
      googleplay: googleplay == freezed
          ? _value.googleplay
          : googleplay // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube: youtube == freezed
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as dynamic,
      soundcloud: soundcloud == freezed
          ? _value.soundcloud
          : soundcloud // ignore: cast_nullable_to_non_nullable
              as String?,
      labelUser: labelUser == freezed
          ? _value.labelUser
          : labelUser // ignore: cast_nullable_to_non_nullable
              as ProfileData?,
      labelUserId: labelUserId == freezed
          ? _value.labelUserId
          : labelUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      artistUser: artistUser == freezed
          ? _value.artistUser
          : artistUser // ignore: cast_nullable_to_non_nullable
              as ProfileData?,
      artistUserId: artistUserId == freezed
          ? _value.artistUserId
          : artistUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      collabUser: collabUser == freezed
          ? _value.collabUser
          : collabUser // ignore: cast_nullable_to_non_nullable
              as ProfileData?,
      collabUserId: collabUserId == freezed
          ? _value.collabUserId
          : collabUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      canEdit: canEdit == freezed
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool?,
      canAddSong: canAddSong == freezed
          ? _value.canAddSong
          : canAddSong // ignore: cast_nullable_to_non_nullable
              as bool?,
      canDelete: canDelete == freezed
          ? _value.canDelete
          : canDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
      canPurchaseSponsor: canPurchaseSponsor == freezed
          ? _value.canPurchaseSponsor
          : canPurchaseSponsor // ignore: cast_nullable_to_non_nullable
              as bool?,
      canSponsor: canSponsor == freezed
          ? _value.canSponsor
          : canSponsor // ignore: cast_nullable_to_non_nullable
              as bool?,
      canFeature: canFeature == freezed
          ? _value.canFeature
          : canFeature // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasPermission: hasPermission == freezed
          ? _value.hasPermission
          : hasPermission // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  @override
  $LastIconCopyWith<$Res>? get lastIcon {
    if (_value.lastIcon == null) {
      return null;
    }

    return $LastIconCopyWith<$Res>(_value.lastIcon!, (value) {
      return _then(_value.copyWith(lastIcon: value));
    });
  }
}

/// @nodoc
abstract class _$$_AlbumCopyWith<$Res> implements $AlbumCopyWith<$Res> {
  factory _$$_AlbumCopyWith(_$_Album value, $Res Function(_$_Album) then) =
      __$$_AlbumCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool? isLiked,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'last_icon') LastIcon? lastIcon,
      @JsonKey(name: 'full_name') String? fullName,
      String? text,
      String? userImage,
      String? isInvisible,
      @JsonKey(name: 'album_id') String? albumId,
      String? viewId,
      String? privacy,
      String? privacyComment,
      String? isFeatured,
      String? isSponsor,
      @JsonKey(name: 'name') String? name,
      String? year,
      @JsonKey(name: 'genre_id') String? genreId,
      String? isDj,
      @JsonKey(name: 'license_type') String? licenseType,
      @JsonKey(name: 'image_path') String? imagePath,
      String? serverId,
      String? totalTrack,
      @JsonKey(name: 'total_play') String? totalPlay,
      @JsonKey(name: 'total_comment') String? totalComment,
      String? totalView,
      @JsonKey(name: 'total_like') String? totalLike,
      String? totalDislike,
      String? totalScore,
      String? totalRating,
      @JsonKey(name: 'total_attachment') String? totalAttachment,
      @JsonKey(name: 'time_stamp') String? timeStamp,
      dynamic moduleId,
      String? itemId,
      dynamic isDay,
      String? artistId,
      String? itunes,
      String? amazon,
      String? googleplay,
      dynamic youtube,
      String? soundcloud,
      @JsonKey(name: 'label_user') ProfileData? labelUser,
      String? labelUserId,
      @JsonKey(name: 'artist_user') ProfileData? artistUser,
      String? artistUserId,
      @JsonKey(name: 'collab_user') ProfileData? collabUser,
      String? collabUserId,
      bool? canEdit,
      bool? canAddSong,
      bool? canDelete,
      bool? canPurchaseSponsor,
      bool? canSponsor,
      bool? canFeature,
      bool? hasPermission});

  @override
  $LastIconCopyWith<$Res>? get lastIcon;
}

/// @nodoc
class __$$_AlbumCopyWithImpl<$Res> extends _$AlbumCopyWithImpl<$Res>
    implements _$$_AlbumCopyWith<$Res> {
  __$$_AlbumCopyWithImpl(_$_Album _value, $Res Function(_$_Album) _then)
      : super(_value, (v) => _then(v as _$_Album));

  @override
  _$_Album get _value => super._value as _$_Album;

  @override
  $Res call({
    Object? isLiked = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? lastIcon = freezed,
    Object? fullName = freezed,
    Object? text = freezed,
    Object? userImage = freezed,
    Object? isInvisible = freezed,
    Object? albumId = freezed,
    Object? viewId = freezed,
    Object? privacy = freezed,
    Object? privacyComment = freezed,
    Object? isFeatured = freezed,
    Object? isSponsor = freezed,
    Object? name = freezed,
    Object? year = freezed,
    Object? genreId = freezed,
    Object? isDj = freezed,
    Object? licenseType = freezed,
    Object? imagePath = freezed,
    Object? serverId = freezed,
    Object? totalTrack = freezed,
    Object? totalPlay = freezed,
    Object? totalComment = freezed,
    Object? totalView = freezed,
    Object? totalLike = freezed,
    Object? totalDislike = freezed,
    Object? totalScore = freezed,
    Object? totalRating = freezed,
    Object? totalAttachment = freezed,
    Object? timeStamp = freezed,
    Object? moduleId = freezed,
    Object? itemId = freezed,
    Object? isDay = freezed,
    Object? artistId = freezed,
    Object? itunes = freezed,
    Object? amazon = freezed,
    Object? googleplay = freezed,
    Object? youtube = freezed,
    Object? soundcloud = freezed,
    Object? labelUser = freezed,
    Object? labelUserId = freezed,
    Object? artistUser = freezed,
    Object? artistUserId = freezed,
    Object? collabUser = freezed,
    Object? collabUserId = freezed,
    Object? canEdit = freezed,
    Object? canAddSong = freezed,
    Object? canDelete = freezed,
    Object? canPurchaseSponsor = freezed,
    Object? canSponsor = freezed,
    Object? canFeature = freezed,
    Object? hasPermission = freezed,
  }) {
    return _then(_$_Album(
      isLiked: isLiked == freezed
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastIcon: lastIcon == freezed
          ? _value.lastIcon
          : lastIcon // ignore: cast_nullable_to_non_nullable
              as LastIcon?,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: userImage == freezed
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isInvisible: isInvisible == freezed
          ? _value.isInvisible
          : isInvisible // ignore: cast_nullable_to_non_nullable
              as String?,
      albumId: albumId == freezed
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String?,
      viewId: viewId == freezed
          ? _value.viewId
          : viewId // ignore: cast_nullable_to_non_nullable
              as String?,
      privacy: privacy == freezed
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as String?,
      privacyComment: privacyComment == freezed
          ? _value.privacyComment
          : privacyComment // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: isFeatured == freezed
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as String?,
      isSponsor: isSponsor == freezed
          ? _value.isSponsor
          : isSponsor // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
      genreId: genreId == freezed
          ? _value.genreId
          : genreId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDj: isDj == freezed
          ? _value.isDj
          : isDj // ignore: cast_nullable_to_non_nullable
              as String?,
      licenseType: licenseType == freezed
          ? _value.licenseType
          : licenseType // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      serverId: serverId == freezed
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      totalTrack: totalTrack == freezed
          ? _value.totalTrack
          : totalTrack // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPlay: totalPlay == freezed
          ? _value.totalPlay
          : totalPlay // ignore: cast_nullable_to_non_nullable
              as String?,
      totalComment: totalComment == freezed
          ? _value.totalComment
          : totalComment // ignore: cast_nullable_to_non_nullable
              as String?,
      totalView: totalView == freezed
          ? _value.totalView
          : totalView // ignore: cast_nullable_to_non_nullable
              as String?,
      totalLike: totalLike == freezed
          ? _value.totalLike
          : totalLike // ignore: cast_nullable_to_non_nullable
              as String?,
      totalDislike: totalDislike == freezed
          ? _value.totalDislike
          : totalDislike // ignore: cast_nullable_to_non_nullable
              as String?,
      totalScore: totalScore == freezed
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as String?,
      totalRating: totalRating == freezed
          ? _value.totalRating
          : totalRating // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAttachment: totalAttachment == freezed
          ? _value.totalAttachment
          : totalAttachment // ignore: cast_nullable_to_non_nullable
              as String?,
      timeStamp: timeStamp == freezed
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
      moduleId: moduleId == freezed
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      itemId: itemId == freezed
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDay: isDay == freezed
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as dynamic,
      artistId: artistId == freezed
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String?,
      itunes: itunes == freezed
          ? _value.itunes
          : itunes // ignore: cast_nullable_to_non_nullable
              as String?,
      amazon: amazon == freezed
          ? _value.amazon
          : amazon // ignore: cast_nullable_to_non_nullable
              as String?,
      googleplay: googleplay == freezed
          ? _value.googleplay
          : googleplay // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube: youtube == freezed
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as dynamic,
      soundcloud: soundcloud == freezed
          ? _value.soundcloud
          : soundcloud // ignore: cast_nullable_to_non_nullable
              as String?,
      labelUser: labelUser == freezed
          ? _value.labelUser
          : labelUser // ignore: cast_nullable_to_non_nullable
              as ProfileData?,
      labelUserId: labelUserId == freezed
          ? _value.labelUserId
          : labelUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      artistUser: artistUser == freezed
          ? _value.artistUser
          : artistUser // ignore: cast_nullable_to_non_nullable
              as ProfileData?,
      artistUserId: artistUserId == freezed
          ? _value.artistUserId
          : artistUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      collabUser: collabUser == freezed
          ? _value.collabUser
          : collabUser // ignore: cast_nullable_to_non_nullable
              as ProfileData?,
      collabUserId: collabUserId == freezed
          ? _value.collabUserId
          : collabUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      canEdit: canEdit == freezed
          ? _value.canEdit
          : canEdit // ignore: cast_nullable_to_non_nullable
              as bool?,
      canAddSong: canAddSong == freezed
          ? _value.canAddSong
          : canAddSong // ignore: cast_nullable_to_non_nullable
              as bool?,
      canDelete: canDelete == freezed
          ? _value.canDelete
          : canDelete // ignore: cast_nullable_to_non_nullable
              as bool?,
      canPurchaseSponsor: canPurchaseSponsor == freezed
          ? _value.canPurchaseSponsor
          : canPurchaseSponsor // ignore: cast_nullable_to_non_nullable
              as bool?,
      canSponsor: canSponsor == freezed
          ? _value.canSponsor
          : canSponsor // ignore: cast_nullable_to_non_nullable
              as bool?,
      canFeature: canFeature == freezed
          ? _value.canFeature
          : canFeature // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasPermission: hasPermission == freezed
          ? _value.hasPermission
          : hasPermission // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Album implements _Album {
  _$_Album(
      {this.isLiked,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(name: 'last_icon') this.lastIcon,
      @JsonKey(name: 'full_name') this.fullName,
      this.text,
      this.userImage,
      this.isInvisible,
      @JsonKey(name: 'album_id') this.albumId,
      this.viewId,
      this.privacy,
      this.privacyComment,
      this.isFeatured,
      this.isSponsor,
      @JsonKey(name: 'name') this.name,
      this.year,
      @JsonKey(name: 'genre_id') this.genreId,
      this.isDj,
      @JsonKey(name: 'license_type') this.licenseType,
      @JsonKey(name: 'image_path') this.imagePath,
      this.serverId,
      this.totalTrack,
      @JsonKey(name: 'total_play') this.totalPlay,
      @JsonKey(name: 'total_comment') this.totalComment,
      this.totalView,
      @JsonKey(name: 'total_like') this.totalLike,
      this.totalDislike,
      this.totalScore,
      this.totalRating,
      @JsonKey(name: 'total_attachment') this.totalAttachment,
      @JsonKey(name: 'time_stamp') this.timeStamp,
      this.moduleId,
      this.itemId,
      this.isDay,
      this.artistId,
      this.itunes,
      this.amazon,
      this.googleplay,
      this.youtube,
      this.soundcloud,
      @JsonKey(name: 'label_user') this.labelUser,
      this.labelUserId,
      @JsonKey(name: 'artist_user') this.artistUser,
      this.artistUserId,
      @JsonKey(name: 'collab_user') this.collabUser,
      this.collabUserId,
      this.canEdit,
      this.canAddSong,
      this.canDelete,
      this.canPurchaseSponsor,
      this.canSponsor,
      this.canFeature,
      this.hasPermission});

  factory _$_Album.fromJson(Map<String, dynamic> json) =>
      _$$_AlbumFromJson(json);

  @override
  final bool? isLiked;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'last_icon')
  final LastIcon? lastIcon;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'full_name')
  final String? fullName;
  @override
  final String? text;
  @override
  final String? userImage;
  @override
  final String? isInvisible;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'album_id')
  final String? albumId;
  @override
  final String? viewId;
  @override
  final String? privacy;
  @override
  final String? privacyComment;
  @override
  final String? isFeatured;
  @override
  final String? isSponsor;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  final String? year;
  @override
  @JsonKey(name: 'genre_id')
  final String? genreId;
  @override
  final String? isDj;
  @override
  @JsonKey(name: 'license_type')
  final String? licenseType;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'image_path')
  final String? imagePath;
  @override
  final String? serverId;
  @override
  final String? totalTrack;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'total_play')
  final String? totalPlay;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'total_comment')
  final String? totalComment;
  @override
  final String? totalView;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'total_like')
  final String? totalLike;
  @override
  final String? totalDislike;
  @override
  final String? totalScore;
  @override
  final String? totalRating;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'total_attachment')
  final String? totalAttachment;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'time_stamp')
  final String? timeStamp;
  @override
  final dynamic moduleId;
  @override
  final String? itemId;
  @override
  final dynamic isDay;
  @override
  final String? artistId;
  @override
  final String? itunes;
  @override
  final String? amazon;
  @override
  final String? googleplay;
  @override
  final dynamic youtube;
  @override
  final String? soundcloud;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'label_user')
  final ProfileData? labelUser;
  @override
  final String? labelUserId;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'artist_user')
  final ProfileData? artistUser;
  @override
  final String? artistUserId;
  @override
  @JsonKey(name: 'collab_user')
  final ProfileData? collabUser;
  @override
  final String? collabUserId;
  @override
  final bool? canEdit;
  @override
  final bool? canAddSong;
  @override
  final bool? canDelete;
  @override
  final bool? canPurchaseSponsor;
  @override
  final bool? canSponsor;
  @override
  final bool? canFeature;
  @override
  final bool? hasPermission;

  @override
  String toString() {
    return 'Album(isLiked: $isLiked, userId: $userId, userName: $userName, lastIcon: $lastIcon, fullName: $fullName, text: $text, userImage: $userImage, isInvisible: $isInvisible, albumId: $albumId, viewId: $viewId, privacy: $privacy, privacyComment: $privacyComment, isFeatured: $isFeatured, isSponsor: $isSponsor, name: $name, year: $year, genreId: $genreId, isDj: $isDj, licenseType: $licenseType, imagePath: $imagePath, serverId: $serverId, totalTrack: $totalTrack, totalPlay: $totalPlay, totalComment: $totalComment, totalView: $totalView, totalLike: $totalLike, totalDislike: $totalDislike, totalScore: $totalScore, totalRating: $totalRating, totalAttachment: $totalAttachment, timeStamp: $timeStamp, moduleId: $moduleId, itemId: $itemId, isDay: $isDay, artistId: $artistId, itunes: $itunes, amazon: $amazon, googleplay: $googleplay, youtube: $youtube, soundcloud: $soundcloud, labelUser: $labelUser, labelUserId: $labelUserId, artistUser: $artistUser, artistUserId: $artistUserId, collabUser: $collabUser, collabUserId: $collabUserId, canEdit: $canEdit, canAddSong: $canAddSong, canDelete: $canDelete, canPurchaseSponsor: $canPurchaseSponsor, canSponsor: $canSponsor, canFeature: $canFeature, hasPermission: $hasPermission)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Album &&
            const DeepCollectionEquality().equals(other.isLiked, isLiked) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.lastIcon, lastIcon) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.userImage, userImage) &&
            const DeepCollectionEquality()
                .equals(other.isInvisible, isInvisible) &&
            const DeepCollectionEquality().equals(other.albumId, albumId) &&
            const DeepCollectionEquality().equals(other.viewId, viewId) &&
            const DeepCollectionEquality().equals(other.privacy, privacy) &&
            const DeepCollectionEquality()
                .equals(other.privacyComment, privacyComment) &&
            const DeepCollectionEquality()
                .equals(other.isFeatured, isFeatured) &&
            const DeepCollectionEquality().equals(other.isSponsor, isSponsor) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.year, year) &&
            const DeepCollectionEquality().equals(other.genreId, genreId) &&
            const DeepCollectionEquality().equals(other.isDj, isDj) &&
            const DeepCollectionEquality()
                .equals(other.licenseType, licenseType) &&
            const DeepCollectionEquality().equals(other.imagePath, imagePath) &&
            const DeepCollectionEquality().equals(other.serverId, serverId) &&
            const DeepCollectionEquality()
                .equals(other.totalTrack, totalTrack) &&
            const DeepCollectionEquality().equals(other.totalPlay, totalPlay) &&
            const DeepCollectionEquality()
                .equals(other.totalComment, totalComment) &&
            const DeepCollectionEquality().equals(other.totalView, totalView) &&
            const DeepCollectionEquality().equals(other.totalLike, totalLike) &&
            const DeepCollectionEquality()
                .equals(other.totalDislike, totalDislike) &&
            const DeepCollectionEquality()
                .equals(other.totalScore, totalScore) &&
            const DeepCollectionEquality()
                .equals(other.totalRating, totalRating) &&
            const DeepCollectionEquality()
                .equals(other.totalAttachment, totalAttachment) &&
            const DeepCollectionEquality().equals(other.timeStamp, timeStamp) &&
            const DeepCollectionEquality().equals(other.moduleId, moduleId) &&
            const DeepCollectionEquality().equals(other.itemId, itemId) &&
            const DeepCollectionEquality().equals(other.isDay, isDay) &&
            const DeepCollectionEquality().equals(other.artistId, artistId) &&
            const DeepCollectionEquality().equals(other.itunes, itunes) &&
            const DeepCollectionEquality().equals(other.amazon, amazon) &&
            const DeepCollectionEquality()
                .equals(other.googleplay, googleplay) &&
            const DeepCollectionEquality().equals(other.youtube, youtube) &&
            const DeepCollectionEquality()
                .equals(other.soundcloud, soundcloud) &&
            const DeepCollectionEquality().equals(other.labelUser, labelUser) &&
            const DeepCollectionEquality()
                .equals(other.labelUserId, labelUserId) &&
            const DeepCollectionEquality()
                .equals(other.artistUser, artistUser) &&
            const DeepCollectionEquality()
                .equals(other.artistUserId, artistUserId) &&
            const DeepCollectionEquality()
                .equals(other.collabUser, collabUser) &&
            const DeepCollectionEquality()
                .equals(other.collabUserId, collabUserId) &&
            const DeepCollectionEquality().equals(other.canEdit, canEdit) &&
            const DeepCollectionEquality()
                .equals(other.canAddSong, canAddSong) &&
            const DeepCollectionEquality().equals(other.canDelete, canDelete) &&
            const DeepCollectionEquality()
                .equals(other.canPurchaseSponsor, canPurchaseSponsor) &&
            const DeepCollectionEquality()
                .equals(other.canSponsor, canSponsor) &&
            const DeepCollectionEquality()
                .equals(other.canFeature, canFeature) &&
            const DeepCollectionEquality()
                .equals(other.hasPermission, hasPermission));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(isLiked),
        const DeepCollectionEquality().hash(userId),
        const DeepCollectionEquality().hash(userName),
        const DeepCollectionEquality().hash(lastIcon),
        const DeepCollectionEquality().hash(fullName),
        const DeepCollectionEquality().hash(text),
        const DeepCollectionEquality().hash(userImage),
        const DeepCollectionEquality().hash(isInvisible),
        const DeepCollectionEquality().hash(albumId),
        const DeepCollectionEquality().hash(viewId),
        const DeepCollectionEquality().hash(privacy),
        const DeepCollectionEquality().hash(privacyComment),
        const DeepCollectionEquality().hash(isFeatured),
        const DeepCollectionEquality().hash(isSponsor),
        const DeepCollectionEquality().hash(name),
        const DeepCollectionEquality().hash(year),
        const DeepCollectionEquality().hash(genreId),
        const DeepCollectionEquality().hash(isDj),
        const DeepCollectionEquality().hash(licenseType),
        const DeepCollectionEquality().hash(imagePath),
        const DeepCollectionEquality().hash(serverId),
        const DeepCollectionEquality().hash(totalTrack),
        const DeepCollectionEquality().hash(totalPlay),
        const DeepCollectionEquality().hash(totalComment),
        const DeepCollectionEquality().hash(totalView),
        const DeepCollectionEquality().hash(totalLike),
        const DeepCollectionEquality().hash(totalDislike),
        const DeepCollectionEquality().hash(totalScore),
        const DeepCollectionEquality().hash(totalRating),
        const DeepCollectionEquality().hash(totalAttachment),
        const DeepCollectionEquality().hash(timeStamp),
        const DeepCollectionEquality().hash(moduleId),
        const DeepCollectionEquality().hash(itemId),
        const DeepCollectionEquality().hash(isDay),
        const DeepCollectionEquality().hash(artistId),
        const DeepCollectionEquality().hash(itunes),
        const DeepCollectionEquality().hash(amazon),
        const DeepCollectionEquality().hash(googleplay),
        const DeepCollectionEquality().hash(youtube),
        const DeepCollectionEquality().hash(soundcloud),
        const DeepCollectionEquality().hash(labelUser),
        const DeepCollectionEquality().hash(labelUserId),
        const DeepCollectionEquality().hash(artistUser),
        const DeepCollectionEquality().hash(artistUserId),
        const DeepCollectionEquality().hash(collabUser),
        const DeepCollectionEquality().hash(collabUserId),
        const DeepCollectionEquality().hash(canEdit),
        const DeepCollectionEquality().hash(canAddSong),
        const DeepCollectionEquality().hash(canDelete),
        const DeepCollectionEquality().hash(canPurchaseSponsor),
        const DeepCollectionEquality().hash(canSponsor),
        const DeepCollectionEquality().hash(canFeature),
        const DeepCollectionEquality().hash(hasPermission)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_AlbumCopyWith<_$_Album> get copyWith =>
      __$$_AlbumCopyWithImpl<_$_Album>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AlbumToJson(this);
  }
}

abstract class _Album implements Album {
  factory _Album(
      {final bool? isLiked,
      @JsonKey(name: 'user_id') final String? userId,
      @JsonKey(name: 'user_name') final String? userName,
      @JsonKey(name: 'last_icon') final LastIcon? lastIcon,
      @JsonKey(name: 'full_name') final String? fullName,
      final String? text,
      final String? userImage,
      final String? isInvisible,
      @JsonKey(name: 'album_id') final String? albumId,
      final String? viewId,
      final String? privacy,
      final String? privacyComment,
      final String? isFeatured,
      final String? isSponsor,
      @JsonKey(name: 'name') final String? name,
      final String? year,
      @JsonKey(name: 'genre_id') final String? genreId,
      final String? isDj,
      @JsonKey(name: 'license_type') final String? licenseType,
      @JsonKey(name: 'image_path') final String? imagePath,
      final String? serverId,
      final String? totalTrack,
      @JsonKey(name: 'total_play') final String? totalPlay,
      @JsonKey(name: 'total_comment') final String? totalComment,
      final String? totalView,
      @JsonKey(name: 'total_like') final String? totalLike,
      final String? totalDislike,
      final String? totalScore,
      final String? totalRating,
      @JsonKey(name: 'total_attachment') final String? totalAttachment,
      @JsonKey(name: 'time_stamp') final String? timeStamp,
      final dynamic moduleId,
      final String? itemId,
      final dynamic isDay,
      final String? artistId,
      final String? itunes,
      final String? amazon,
      final String? googleplay,
      final dynamic youtube,
      final String? soundcloud,
      @JsonKey(name: 'label_user') final ProfileData? labelUser,
      final String? labelUserId,
      @JsonKey(name: 'artist_user') final ProfileData? artistUser,
      final String? artistUserId,
      @JsonKey(name: 'collab_user') final ProfileData? collabUser,
      final String? collabUserId,
      final bool? canEdit,
      final bool? canAddSong,
      final bool? canDelete,
      final bool? canPurchaseSponsor,
      final bool? canSponsor,
      final bool? canFeature,
      final bool? hasPermission}) = _$_Album;

  factory _Album.fromJson(Map<String, dynamic> json) = _$_Album.fromJson;

  @override
  bool? get isLiked => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'last_icon')
  LastIcon? get lastIcon => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  @override
  String? get text => throw _privateConstructorUsedError;
  @override
  String? get userImage => throw _privateConstructorUsedError;
  @override
  String? get isInvisible => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'album_id')
  String? get albumId => throw _privateConstructorUsedError;
  @override
  String? get viewId => throw _privateConstructorUsedError;
  @override
  String? get privacy => throw _privateConstructorUsedError;
  @override
  String? get privacyComment => throw _privateConstructorUsedError;
  @override
  String? get isFeatured => throw _privateConstructorUsedError;
  @override
  String? get isSponsor => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get year => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'genre_id')
  String? get genreId => throw _privateConstructorUsedError;
  @override
  String? get isDj => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'license_type')
  String? get licenseType => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'image_path')
  String? get imagePath => throw _privateConstructorUsedError;
  @override
  String? get serverId => throw _privateConstructorUsedError;
  @override
  String? get totalTrack => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'total_play')
  String? get totalPlay => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'total_comment')
  String? get totalComment => throw _privateConstructorUsedError;
  @override
  String? get totalView => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'total_like')
  String? get totalLike => throw _privateConstructorUsedError;
  @override
  String? get totalDislike => throw _privateConstructorUsedError;
  @override
  String? get totalScore => throw _privateConstructorUsedError;
  @override
  String? get totalRating => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'total_attachment')
  String? get totalAttachment => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'time_stamp')
  String? get timeStamp => throw _privateConstructorUsedError;
  @override
  dynamic get moduleId => throw _privateConstructorUsedError;
  @override
  String? get itemId => throw _privateConstructorUsedError;
  @override
  dynamic get isDay => throw _privateConstructorUsedError;
  @override
  String? get artistId => throw _privateConstructorUsedError;
  @override
  String? get itunes => throw _privateConstructorUsedError;
  @override
  String? get amazon => throw _privateConstructorUsedError;
  @override
  String? get googleplay => throw _privateConstructorUsedError;
  @override
  dynamic get youtube => throw _privateConstructorUsedError;
  @override
  String? get soundcloud => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'label_user')
  ProfileData? get labelUser => throw _privateConstructorUsedError;
  @override
  String? get labelUserId => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'artist_user')
  ProfileData? get artistUser => throw _privateConstructorUsedError;
  @override
  String? get artistUserId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'collab_user')
  ProfileData? get collabUser => throw _privateConstructorUsedError;
  @override
  String? get collabUserId => throw _privateConstructorUsedError;
  @override
  bool? get canEdit => throw _privateConstructorUsedError;
  @override
  bool? get canAddSong => throw _privateConstructorUsedError;
  @override
  bool? get canDelete => throw _privateConstructorUsedError;
  @override
  bool? get canPurchaseSponsor => throw _privateConstructorUsedError;
  @override
  bool? get canSponsor => throw _privateConstructorUsedError;
  @override
  bool? get canFeature => throw _privateConstructorUsedError;
  @override
  bool? get hasPermission => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AlbumCopyWith<_$_Album> get copyWith =>
      throw _privateConstructorUsedError;
}
