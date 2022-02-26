// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'song_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SongResponse _$SongResponseFromJson(Map<String, dynamic> json) {
  return _SongResponse.fromJson(json);
}

/// @nodoc
class _$SongResponseTearOff {
  const _$SongResponseTearOff();

  _SongResponse call(
      {String? status, List<Song>? data, String? message, String? error}) {
    return _SongResponse(
      status: status,
      data: data,
      message: message,
      error: error,
    );
  }

  SongResponse fromJson(Map<String, Object?> json) {
    return SongResponse.fromJson(json);
  }
}

/// @nodoc
const $SongResponse = _$SongResponseTearOff();

/// @nodoc
mixin _$SongResponse {
  String? get status => throw _privateConstructorUsedError;
  List<Song>? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongResponseCopyWith<SongResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongResponseCopyWith<$Res> {
  factory $SongResponseCopyWith(
          SongResponse value, $Res Function(SongResponse) then) =
      _$SongResponseCopyWithImpl<$Res>;
  $Res call({String? status, List<Song>? data, String? message, String? error});
}

/// @nodoc
class _$SongResponseCopyWithImpl<$Res> implements $SongResponseCopyWith<$Res> {
  _$SongResponseCopyWithImpl(this._value, this._then);

  final SongResponse _value;
  // ignore: unused_field
  final $Res Function(SongResponse) _then;

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
              as List<Song>?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$SongResponseCopyWith<$Res>
    implements $SongResponseCopyWith<$Res> {
  factory _$SongResponseCopyWith(
          _SongResponse value, $Res Function(_SongResponse) then) =
      __$SongResponseCopyWithImpl<$Res>;
  @override
  $Res call({String? status, List<Song>? data, String? message, String? error});
}

/// @nodoc
class __$SongResponseCopyWithImpl<$Res> extends _$SongResponseCopyWithImpl<$Res>
    implements _$SongResponseCopyWith<$Res> {
  __$SongResponseCopyWithImpl(
      _SongResponse _value, $Res Function(_SongResponse) _then)
      : super(_value, (v) => _then(v as _SongResponse));

  @override
  _SongResponse get _value => super._value as _SongResponse;

  @override
  $Res call({
    Object? status = freezed,
    Object? data = freezed,
    Object? message = freezed,
    Object? error = freezed,
  }) {
    return _then(_SongResponse(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Song>?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SongResponse implements _SongResponse {
  _$_SongResponse({this.status, this.data, this.message, this.error});

  factory _$_SongResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SongResponseFromJson(json);

  @override
  final String? status;
  @override
  final List<Song>? data;
  @override
  final String? message;
  @override
  final String? error;

  @override
  String toString() {
    return 'SongResponse(status: $status, data: $data, message: $message, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SongResponse &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  _$SongResponseCopyWith<_SongResponse> get copyWith =>
      __$SongResponseCopyWithImpl<_SongResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SongResponseToJson(this);
  }
}

abstract class _SongResponse implements SongResponse {
  factory _SongResponse(
      {String? status,
      List<Song>? data,
      String? message,
      String? error}) = _$_SongResponse;

  factory _SongResponse.fromJson(Map<String, dynamic> json) =
      _$_SongResponse.fromJson;

  @override
  String? get status;
  @override
  List<Song>? get data;
  @override
  String? get message;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$SongResponseCopyWith<_SongResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

Song _$SongFromJson(Map<String, dynamic> json) {
  return _Song.fromJson(json);
}

/// @nodoc
class _$SongTearOff {
  const _$SongTearOff();

  _Song call(
      {String? userId,
      String? artistTitle,
      String? albumName,
      String? songId,
      String? viewId,
      String? privacy,
      String? privacyComment,
      String? isFree,
      String? isFeatured,
      String? isSponsor,
      String? albumId,
      String? genreId,
      String? isDj,
      String? title,
      String? description,
      String? licenseType,
      String? songPath,
      String? explicit,
      int? duration,
      String? totalPlay,
      String? totalView,
      String? totalComment,
      String? totalLike,
      String? totalDislike,
      String? totalScore,
      String? totalRating,
      String? totalAttachment,
      @JsonKey(name: 'time_stamp') String? timeStamp,
      String? lyrics,
      String? cost,
      String? totalDownload,
      String? tags,
      @JsonKey(name: 'image_path') String? imagePath,
      @JsonKey(name: 'artist_user') ArtistUser? artistUser,
      String? peaksJsonUrl,
      int? noPhoto}) {
    return _Song(
      userId: userId,
      artistTitle: artistTitle,
      albumName: albumName,
      songId: songId,
      viewId: viewId,
      privacy: privacy,
      privacyComment: privacyComment,
      isFree: isFree,
      isFeatured: isFeatured,
      isSponsor: isSponsor,
      albumId: albumId,
      genreId: genreId,
      isDj: isDj,
      title: title,
      description: description,
      licenseType: licenseType,
      songPath: songPath,
      explicit: explicit,
      duration: duration,
      totalPlay: totalPlay,
      totalView: totalView,
      totalComment: totalComment,
      totalLike: totalLike,
      totalDislike: totalDislike,
      totalScore: totalScore,
      totalRating: totalRating,
      totalAttachment: totalAttachment,
      timeStamp: timeStamp,
      lyrics: lyrics,
      cost: cost,
      totalDownload: totalDownload,
      tags: tags,
      imagePath: imagePath,
      artistUser: artistUser,
      peaksJsonUrl: peaksJsonUrl,
      noPhoto: noPhoto,
    );
  }

  Song fromJson(Map<String, Object?> json) {
    return Song.fromJson(json);
  }
}

/// @nodoc
const $Song = _$SongTearOff();

/// @nodoc
mixin _$Song {
  String? get userId => throw _privateConstructorUsedError;
  String? get artistTitle => throw _privateConstructorUsedError;
  String? get albumName => throw _privateConstructorUsedError;
  String? get songId => throw _privateConstructorUsedError;
  String? get viewId => throw _privateConstructorUsedError;
  String? get privacy => throw _privateConstructorUsedError;
  String? get privacyComment => throw _privateConstructorUsedError;
  String? get isFree => throw _privateConstructorUsedError;
  String? get isFeatured => throw _privateConstructorUsedError;
  String? get isSponsor => throw _privateConstructorUsedError;
  String? get albumId => throw _privateConstructorUsedError;
  String? get genreId => throw _privateConstructorUsedError;
  String? get isDj => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get licenseType => throw _privateConstructorUsedError;
  String? get songPath => throw _privateConstructorUsedError;
  String? get explicit => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  String? get totalPlay => throw _privateConstructorUsedError;
  String? get totalView => throw _privateConstructorUsedError;
  String? get totalComment => throw _privateConstructorUsedError;
  String? get totalLike => throw _privateConstructorUsedError;
  String? get totalDislike => throw _privateConstructorUsedError;
  String? get totalScore => throw _privateConstructorUsedError;
  String? get totalRating => throw _privateConstructorUsedError;
  String? get totalAttachment =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'time_stamp')
  String? get timeStamp => throw _privateConstructorUsedError;
  String? get lyrics => throw _privateConstructorUsedError;
  String? get cost => throw _privateConstructorUsedError;
  String? get totalDownload => throw _privateConstructorUsedError;
  String? get tags =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'image_path')
  String? get imagePath =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'artist_user')
  ArtistUser? get artistUser => throw _privateConstructorUsedError;
  String? get peaksJsonUrl => throw _privateConstructorUsedError;
  int? get noPhoto => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongCopyWith<Song> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongCopyWith<$Res> {
  factory $SongCopyWith(Song value, $Res Function(Song) then) =
      _$SongCopyWithImpl<$Res>;
  $Res call(
      {String? userId,
      String? artistTitle,
      String? albumName,
      String? songId,
      String? viewId,
      String? privacy,
      String? privacyComment,
      String? isFree,
      String? isFeatured,
      String? isSponsor,
      String? albumId,
      String? genreId,
      String? isDj,
      String? title,
      String? description,
      String? licenseType,
      String? songPath,
      String? explicit,
      int? duration,
      String? totalPlay,
      String? totalView,
      String? totalComment,
      String? totalLike,
      String? totalDislike,
      String? totalScore,
      String? totalRating,
      String? totalAttachment,
      @JsonKey(name: 'time_stamp') String? timeStamp,
      String? lyrics,
      String? cost,
      String? totalDownload,
      String? tags,
      @JsonKey(name: 'image_path') String? imagePath,
      @JsonKey(name: 'artist_user') ArtistUser? artistUser,
      String? peaksJsonUrl,
      int? noPhoto});

  $ArtistUserCopyWith<$Res>? get artistUser;
}

/// @nodoc
class _$SongCopyWithImpl<$Res> implements $SongCopyWith<$Res> {
  _$SongCopyWithImpl(this._value, this._then);

  final Song _value;
  // ignore: unused_field
  final $Res Function(Song) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? artistTitle = freezed,
    Object? albumName = freezed,
    Object? songId = freezed,
    Object? viewId = freezed,
    Object? privacy = freezed,
    Object? privacyComment = freezed,
    Object? isFree = freezed,
    Object? isFeatured = freezed,
    Object? isSponsor = freezed,
    Object? albumId = freezed,
    Object? genreId = freezed,
    Object? isDj = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? licenseType = freezed,
    Object? songPath = freezed,
    Object? explicit = freezed,
    Object? duration = freezed,
    Object? totalPlay = freezed,
    Object? totalView = freezed,
    Object? totalComment = freezed,
    Object? totalLike = freezed,
    Object? totalDislike = freezed,
    Object? totalScore = freezed,
    Object? totalRating = freezed,
    Object? totalAttachment = freezed,
    Object? timeStamp = freezed,
    Object? lyrics = freezed,
    Object? cost = freezed,
    Object? totalDownload = freezed,
    Object? tags = freezed,
    Object? imagePath = freezed,
    Object? artistUser = freezed,
    Object? peaksJsonUrl = freezed,
    Object? noPhoto = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      artistTitle: artistTitle == freezed
          ? _value.artistTitle
          : artistTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      albumName: albumName == freezed
          ? _value.albumName
          : albumName // ignore: cast_nullable_to_non_nullable
              as String?,
      songId: songId == freezed
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
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
      isFree: isFree == freezed
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: isFeatured == freezed
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as String?,
      isSponsor: isSponsor == freezed
          ? _value.isSponsor
          : isSponsor // ignore: cast_nullable_to_non_nullable
              as String?,
      albumId: albumId == freezed
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String?,
      genreId: genreId == freezed
          ? _value.genreId
          : genreId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDj: isDj == freezed
          ? _value.isDj
          : isDj // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      licenseType: licenseType == freezed
          ? _value.licenseType
          : licenseType // ignore: cast_nullable_to_non_nullable
              as String?,
      songPath: songPath == freezed
          ? _value.songPath
          : songPath // ignore: cast_nullable_to_non_nullable
              as String?,
      explicit: explicit == freezed
          ? _value.explicit
          : explicit // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPlay: totalPlay == freezed
          ? _value.totalPlay
          : totalPlay // ignore: cast_nullable_to_non_nullable
              as String?,
      totalView: totalView == freezed
          ? _value.totalView
          : totalView // ignore: cast_nullable_to_non_nullable
              as String?,
      totalComment: totalComment == freezed
          ? _value.totalComment
          : totalComment // ignore: cast_nullable_to_non_nullable
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
      lyrics: lyrics == freezed
          ? _value.lyrics
          : lyrics // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as String?,
      totalDownload: totalDownload == freezed
          ? _value.totalDownload
          : totalDownload // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      artistUser: artistUser == freezed
          ? _value.artistUser
          : artistUser // ignore: cast_nullable_to_non_nullable
              as ArtistUser?,
      peaksJsonUrl: peaksJsonUrl == freezed
          ? _value.peaksJsonUrl
          : peaksJsonUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      noPhoto: noPhoto == freezed
          ? _value.noPhoto
          : noPhoto // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  @override
  $ArtistUserCopyWith<$Res>? get artistUser {
    if (_value.artistUser == null) {
      return null;
    }

    return $ArtistUserCopyWith<$Res>(_value.artistUser!, (value) {
      return _then(_value.copyWith(artistUser: value));
    });
  }
}

/// @nodoc
abstract class _$SongCopyWith<$Res> implements $SongCopyWith<$Res> {
  factory _$SongCopyWith(_Song value, $Res Function(_Song) then) =
      __$SongCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? userId,
      String? artistTitle,
      String? albumName,
      String? songId,
      String? viewId,
      String? privacy,
      String? privacyComment,
      String? isFree,
      String? isFeatured,
      String? isSponsor,
      String? albumId,
      String? genreId,
      String? isDj,
      String? title,
      String? description,
      String? licenseType,
      String? songPath,
      String? explicit,
      int? duration,
      String? totalPlay,
      String? totalView,
      String? totalComment,
      String? totalLike,
      String? totalDislike,
      String? totalScore,
      String? totalRating,
      String? totalAttachment,
      @JsonKey(name: 'time_stamp') String? timeStamp,
      String? lyrics,
      String? cost,
      String? totalDownload,
      String? tags,
      @JsonKey(name: 'image_path') String? imagePath,
      @JsonKey(name: 'artist_user') ArtistUser? artistUser,
      String? peaksJsonUrl,
      int? noPhoto});

  @override
  $ArtistUserCopyWith<$Res>? get artistUser;
}

/// @nodoc
class __$SongCopyWithImpl<$Res> extends _$SongCopyWithImpl<$Res>
    implements _$SongCopyWith<$Res> {
  __$SongCopyWithImpl(_Song _value, $Res Function(_Song) _then)
      : super(_value, (v) => _then(v as _Song));

  @override
  _Song get _value => super._value as _Song;

  @override
  $Res call({
    Object? userId = freezed,
    Object? artistTitle = freezed,
    Object? albumName = freezed,
    Object? songId = freezed,
    Object? viewId = freezed,
    Object? privacy = freezed,
    Object? privacyComment = freezed,
    Object? isFree = freezed,
    Object? isFeatured = freezed,
    Object? isSponsor = freezed,
    Object? albumId = freezed,
    Object? genreId = freezed,
    Object? isDj = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? licenseType = freezed,
    Object? songPath = freezed,
    Object? explicit = freezed,
    Object? duration = freezed,
    Object? totalPlay = freezed,
    Object? totalView = freezed,
    Object? totalComment = freezed,
    Object? totalLike = freezed,
    Object? totalDislike = freezed,
    Object? totalScore = freezed,
    Object? totalRating = freezed,
    Object? totalAttachment = freezed,
    Object? timeStamp = freezed,
    Object? lyrics = freezed,
    Object? cost = freezed,
    Object? totalDownload = freezed,
    Object? tags = freezed,
    Object? imagePath = freezed,
    Object? artistUser = freezed,
    Object? peaksJsonUrl = freezed,
    Object? noPhoto = freezed,
  }) {
    return _then(_Song(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      artistTitle: artistTitle == freezed
          ? _value.artistTitle
          : artistTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      albumName: albumName == freezed
          ? _value.albumName
          : albumName // ignore: cast_nullable_to_non_nullable
              as String?,
      songId: songId == freezed
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
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
      isFree: isFree == freezed
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: isFeatured == freezed
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as String?,
      isSponsor: isSponsor == freezed
          ? _value.isSponsor
          : isSponsor // ignore: cast_nullable_to_non_nullable
              as String?,
      albumId: albumId == freezed
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String?,
      genreId: genreId == freezed
          ? _value.genreId
          : genreId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDj: isDj == freezed
          ? _value.isDj
          : isDj // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      licenseType: licenseType == freezed
          ? _value.licenseType
          : licenseType // ignore: cast_nullable_to_non_nullable
              as String?,
      songPath: songPath == freezed
          ? _value.songPath
          : songPath // ignore: cast_nullable_to_non_nullable
              as String?,
      explicit: explicit == freezed
          ? _value.explicit
          : explicit // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPlay: totalPlay == freezed
          ? _value.totalPlay
          : totalPlay // ignore: cast_nullable_to_non_nullable
              as String?,
      totalView: totalView == freezed
          ? _value.totalView
          : totalView // ignore: cast_nullable_to_non_nullable
              as String?,
      totalComment: totalComment == freezed
          ? _value.totalComment
          : totalComment // ignore: cast_nullable_to_non_nullable
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
      lyrics: lyrics == freezed
          ? _value.lyrics
          : lyrics // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: cost == freezed
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as String?,
      totalDownload: totalDownload == freezed
          ? _value.totalDownload
          : totalDownload // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      artistUser: artistUser == freezed
          ? _value.artistUser
          : artistUser // ignore: cast_nullable_to_non_nullable
              as ArtistUser?,
      peaksJsonUrl: peaksJsonUrl == freezed
          ? _value.peaksJsonUrl
          : peaksJsonUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      noPhoto: noPhoto == freezed
          ? _value.noPhoto
          : noPhoto // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Song implements _Song {
  _$_Song(
      {this.userId,
      this.artistTitle,
      this.albumName,
      this.songId,
      this.viewId,
      this.privacy,
      this.privacyComment,
      this.isFree,
      this.isFeatured,
      this.isSponsor,
      this.albumId,
      this.genreId,
      this.isDj,
      this.title,
      this.description,
      this.licenseType,
      this.songPath,
      this.explicit,
      this.duration,
      this.totalPlay,
      this.totalView,
      this.totalComment,
      this.totalLike,
      this.totalDislike,
      this.totalScore,
      this.totalRating,
      this.totalAttachment,
      @JsonKey(name: 'time_stamp') this.timeStamp,
      this.lyrics,
      this.cost,
      this.totalDownload,
      this.tags,
      @JsonKey(name: 'image_path') this.imagePath,
      @JsonKey(name: 'artist_user') this.artistUser,
      this.peaksJsonUrl,
      this.noPhoto});

  factory _$_Song.fromJson(Map<String, dynamic> json) => _$$_SongFromJson(json);

  @override
  final String? userId;
  @override
  final String? artistTitle;
  @override
  final String? albumName;
  @override
  final String? songId;
  @override
  final String? viewId;
  @override
  final String? privacy;
  @override
  final String? privacyComment;
  @override
  final String? isFree;
  @override
  final String? isFeatured;
  @override
  final String? isSponsor;
  @override
  final String? albumId;
  @override
  final String? genreId;
  @override
  final String? isDj;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? licenseType;
  @override
  final String? songPath;
  @override
  final String? explicit;
  @override
  final int? duration;
  @override
  final String? totalPlay;
  @override
  final String? totalView;
  @override
  final String? totalComment;
  @override
  final String? totalLike;
  @override
  final String? totalDislike;
  @override
  final String? totalScore;
  @override
  final String? totalRating;
  @override
  final String? totalAttachment;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'time_stamp')
  final String? timeStamp;
  @override
  final String? lyrics;
  @override
  final String? cost;
  @override
  final String? totalDownload;
  @override
  final String? tags;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'image_path')
  final String? imagePath;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'artist_user')
  final ArtistUser? artistUser;
  @override
  final String? peaksJsonUrl;
  @override
  final int? noPhoto;

  @override
  String toString() {
    return 'Song(userId: $userId, artistTitle: $artistTitle, albumName: $albumName, songId: $songId, viewId: $viewId, privacy: $privacy, privacyComment: $privacyComment, isFree: $isFree, isFeatured: $isFeatured, isSponsor: $isSponsor, albumId: $albumId, genreId: $genreId, isDj: $isDj, title: $title, description: $description, licenseType: $licenseType, songPath: $songPath, explicit: $explicit, duration: $duration, totalPlay: $totalPlay, totalView: $totalView, totalComment: $totalComment, totalLike: $totalLike, totalDislike: $totalDislike, totalScore: $totalScore, totalRating: $totalRating, totalAttachment: $totalAttachment, timeStamp: $timeStamp, lyrics: $lyrics, cost: $cost, totalDownload: $totalDownload, tags: $tags, imagePath: $imagePath, artistUser: $artistUser, peaksJsonUrl: $peaksJsonUrl, noPhoto: $noPhoto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Song &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.artistTitle, artistTitle) &&
            const DeepCollectionEquality().equals(other.albumName, albumName) &&
            const DeepCollectionEquality().equals(other.songId, songId) &&
            const DeepCollectionEquality().equals(other.viewId, viewId) &&
            const DeepCollectionEquality().equals(other.privacy, privacy) &&
            const DeepCollectionEquality()
                .equals(other.privacyComment, privacyComment) &&
            const DeepCollectionEquality().equals(other.isFree, isFree) &&
            const DeepCollectionEquality()
                .equals(other.isFeatured, isFeatured) &&
            const DeepCollectionEquality().equals(other.isSponsor, isSponsor) &&
            const DeepCollectionEquality().equals(other.albumId, albumId) &&
            const DeepCollectionEquality().equals(other.genreId, genreId) &&
            const DeepCollectionEquality().equals(other.isDj, isDj) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.licenseType, licenseType) &&
            const DeepCollectionEquality().equals(other.songPath, songPath) &&
            const DeepCollectionEquality().equals(other.explicit, explicit) &&
            const DeepCollectionEquality().equals(other.duration, duration) &&
            const DeepCollectionEquality().equals(other.totalPlay, totalPlay) &&
            const DeepCollectionEquality().equals(other.totalView, totalView) &&
            const DeepCollectionEquality()
                .equals(other.totalComment, totalComment) &&
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
            const DeepCollectionEquality().equals(other.lyrics, lyrics) &&
            const DeepCollectionEquality().equals(other.cost, cost) &&
            const DeepCollectionEquality()
                .equals(other.totalDownload, totalDownload) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality().equals(other.imagePath, imagePath) &&
            const DeepCollectionEquality()
                .equals(other.artistUser, artistUser) &&
            const DeepCollectionEquality()
                .equals(other.peaksJsonUrl, peaksJsonUrl) &&
            const DeepCollectionEquality().equals(other.noPhoto, noPhoto));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(userId),
        const DeepCollectionEquality().hash(artistTitle),
        const DeepCollectionEquality().hash(albumName),
        const DeepCollectionEquality().hash(songId),
        const DeepCollectionEquality().hash(viewId),
        const DeepCollectionEquality().hash(privacy),
        const DeepCollectionEquality().hash(privacyComment),
        const DeepCollectionEquality().hash(isFree),
        const DeepCollectionEquality().hash(isFeatured),
        const DeepCollectionEquality().hash(isSponsor),
        const DeepCollectionEquality().hash(albumId),
        const DeepCollectionEquality().hash(genreId),
        const DeepCollectionEquality().hash(isDj),
        const DeepCollectionEquality().hash(title),
        const DeepCollectionEquality().hash(description),
        const DeepCollectionEquality().hash(licenseType),
        const DeepCollectionEquality().hash(songPath),
        const DeepCollectionEquality().hash(explicit),
        const DeepCollectionEquality().hash(duration),
        const DeepCollectionEquality().hash(totalPlay),
        const DeepCollectionEquality().hash(totalView),
        const DeepCollectionEquality().hash(totalComment),
        const DeepCollectionEquality().hash(totalLike),
        const DeepCollectionEquality().hash(totalDislike),
        const DeepCollectionEquality().hash(totalScore),
        const DeepCollectionEquality().hash(totalRating),
        const DeepCollectionEquality().hash(totalAttachment),
        const DeepCollectionEquality().hash(timeStamp),
        const DeepCollectionEquality().hash(lyrics),
        const DeepCollectionEquality().hash(cost),
        const DeepCollectionEquality().hash(totalDownload),
        const DeepCollectionEquality().hash(tags),
        const DeepCollectionEquality().hash(imagePath),
        const DeepCollectionEquality().hash(artistUser),
        const DeepCollectionEquality().hash(peaksJsonUrl),
        const DeepCollectionEquality().hash(noPhoto)
      ]);

  @JsonKey(ignore: true)
  @override
  _$SongCopyWith<_Song> get copyWith =>
      __$SongCopyWithImpl<_Song>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SongToJson(this);
  }
}

abstract class _Song implements Song {
  factory _Song(
      {String? userId,
      String? artistTitle,
      String? albumName,
      String? songId,
      String? viewId,
      String? privacy,
      String? privacyComment,
      String? isFree,
      String? isFeatured,
      String? isSponsor,
      String? albumId,
      String? genreId,
      String? isDj,
      String? title,
      String? description,
      String? licenseType,
      String? songPath,
      String? explicit,
      int? duration,
      String? totalPlay,
      String? totalView,
      String? totalComment,
      String? totalLike,
      String? totalDislike,
      String? totalScore,
      String? totalRating,
      String? totalAttachment,
      @JsonKey(name: 'time_stamp') String? timeStamp,
      String? lyrics,
      String? cost,
      String? totalDownload,
      String? tags,
      @JsonKey(name: 'image_path') String? imagePath,
      @JsonKey(name: 'artist_user') ArtistUser? artistUser,
      String? peaksJsonUrl,
      int? noPhoto}) = _$_Song;

  factory _Song.fromJson(Map<String, dynamic> json) = _$_Song.fromJson;

  @override
  String? get userId;
  @override
  String? get artistTitle;
  @override
  String? get albumName;
  @override
  String? get songId;
  @override
  String? get viewId;
  @override
  String? get privacy;
  @override
  String? get privacyComment;
  @override
  String? get isFree;
  @override
  String? get isFeatured;
  @override
  String? get isSponsor;
  @override
  String? get albumId;
  @override
  String? get genreId;
  @override
  String? get isDj;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get licenseType;
  @override
  String? get songPath;
  @override
  String? get explicit;
  @override
  int? get duration;
  @override
  String? get totalPlay;
  @override
  String? get totalView;
  @override
  String? get totalComment;
  @override
  String? get totalLike;
  @override
  String? get totalDislike;
  @override
  String? get totalScore;
  @override
  String? get totalRating;
  @override
  String? get totalAttachment;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'time_stamp')
  String? get timeStamp;
  @override
  String? get lyrics;
  @override
  String? get cost;
  @override
  String? get totalDownload;
  @override
  String? get tags;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'image_path')
  String? get imagePath;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'artist_user')
  ArtistUser? get artistUser;
  @override
  String? get peaksJsonUrl;
  @override
  int? get noPhoto;
  @override
  @JsonKey(ignore: true)
  _$SongCopyWith<_Song> get copyWith => throw _privateConstructorUsedError;
}

ArtistUser _$ArtistUserFromJson(Map<String, dynamic> json) {
  return _ArtistUser.fromJson(json);
}

/// @nodoc
class _$ArtistUserTearOff {
  const _$ArtistUserTearOff();

  _ArtistUser call(
      {String? userId,
      String? profilePageId,
      String? userServerId,
      @JsonKey(name: 'user_name') String? userName,
      String? fullName,
      String? gender,
      String? userImage,
      String? isInvisible,
      String? userGroupId,
      String? languageId,
      String? lastActivity,
      String? birthday,
      String? countryIso}) {
    return _ArtistUser(
      userId: userId,
      profilePageId: profilePageId,
      userServerId: userServerId,
      userName: userName,
      fullName: fullName,
      gender: gender,
      userImage: userImage,
      isInvisible: isInvisible,
      userGroupId: userGroupId,
      languageId: languageId,
      lastActivity: lastActivity,
      birthday: birthday,
      countryIso: countryIso,
    );
  }

  ArtistUser fromJson(Map<String, Object?> json) {
    return ArtistUser.fromJson(json);
  }
}

/// @nodoc
const $ArtistUser = _$ArtistUserTearOff();

/// @nodoc
mixin _$ArtistUser {
  String? get userId => throw _privateConstructorUsedError;
  String? get profilePageId => throw _privateConstructorUsedError;
  String? get userServerId =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get userImage => throw _privateConstructorUsedError;
  String? get isInvisible => throw _privateConstructorUsedError;
  String? get userGroupId => throw _privateConstructorUsedError;
  String? get languageId => throw _privateConstructorUsedError;
  String? get lastActivity => throw _privateConstructorUsedError;
  String? get birthday => throw _privateConstructorUsedError;
  String? get countryIso => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtistUserCopyWith<ArtistUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtistUserCopyWith<$Res> {
  factory $ArtistUserCopyWith(
          ArtistUser value, $Res Function(ArtistUser) then) =
      _$ArtistUserCopyWithImpl<$Res>;
  $Res call(
      {String? userId,
      String? profilePageId,
      String? userServerId,
      @JsonKey(name: 'user_name') String? userName,
      String? fullName,
      String? gender,
      String? userImage,
      String? isInvisible,
      String? userGroupId,
      String? languageId,
      String? lastActivity,
      String? birthday,
      String? countryIso});
}

/// @nodoc
class _$ArtistUserCopyWithImpl<$Res> implements $ArtistUserCopyWith<$Res> {
  _$ArtistUserCopyWithImpl(this._value, this._then);

  final ArtistUser _value;
  // ignore: unused_field
  final $Res Function(ArtistUser) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? profilePageId = freezed,
    Object? userServerId = freezed,
    Object? userName = freezed,
    Object? fullName = freezed,
    Object? gender = freezed,
    Object? userImage = freezed,
    Object? isInvisible = freezed,
    Object? userGroupId = freezed,
    Object? languageId = freezed,
    Object? lastActivity = freezed,
    Object? birthday = freezed,
    Object? countryIso = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePageId: profilePageId == freezed
          ? _value.profilePageId
          : profilePageId // ignore: cast_nullable_to_non_nullable
              as String?,
      userServerId: userServerId == freezed
          ? _value.userServerId
          : userServerId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: userImage == freezed
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isInvisible: isInvisible == freezed
          ? _value.isInvisible
          : isInvisible // ignore: cast_nullable_to_non_nullable
              as String?,
      userGroupId: userGroupId == freezed
          ? _value.userGroupId
          : userGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
      languageId: languageId == freezed
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastActivity: lastActivity == freezed
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      countryIso: countryIso == freezed
          ? _value.countryIso
          : countryIso // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ArtistUserCopyWith<$Res> implements $ArtistUserCopyWith<$Res> {
  factory _$ArtistUserCopyWith(
          _ArtistUser value, $Res Function(_ArtistUser) then) =
      __$ArtistUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? userId,
      String? profilePageId,
      String? userServerId,
      @JsonKey(name: 'user_name') String? userName,
      String? fullName,
      String? gender,
      String? userImage,
      String? isInvisible,
      String? userGroupId,
      String? languageId,
      String? lastActivity,
      String? birthday,
      String? countryIso});
}

/// @nodoc
class __$ArtistUserCopyWithImpl<$Res> extends _$ArtistUserCopyWithImpl<$Res>
    implements _$ArtistUserCopyWith<$Res> {
  __$ArtistUserCopyWithImpl(
      _ArtistUser _value, $Res Function(_ArtistUser) _then)
      : super(_value, (v) => _then(v as _ArtistUser));

  @override
  _ArtistUser get _value => super._value as _ArtistUser;

  @override
  $Res call({
    Object? userId = freezed,
    Object? profilePageId = freezed,
    Object? userServerId = freezed,
    Object? userName = freezed,
    Object? fullName = freezed,
    Object? gender = freezed,
    Object? userImage = freezed,
    Object? isInvisible = freezed,
    Object? userGroupId = freezed,
    Object? languageId = freezed,
    Object? lastActivity = freezed,
    Object? birthday = freezed,
    Object? countryIso = freezed,
  }) {
    return _then(_ArtistUser(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePageId: profilePageId == freezed
          ? _value.profilePageId
          : profilePageId // ignore: cast_nullable_to_non_nullable
              as String?,
      userServerId: userServerId == freezed
          ? _value.userServerId
          : userServerId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: userImage == freezed
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isInvisible: isInvisible == freezed
          ? _value.isInvisible
          : isInvisible // ignore: cast_nullable_to_non_nullable
              as String?,
      userGroupId: userGroupId == freezed
          ? _value.userGroupId
          : userGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
      languageId: languageId == freezed
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastActivity: lastActivity == freezed
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      countryIso: countryIso == freezed
          ? _value.countryIso
          : countryIso // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtistUser implements _ArtistUser {
  _$_ArtistUser(
      {this.userId,
      this.profilePageId,
      this.userServerId,
      @JsonKey(name: 'user_name') this.userName,
      this.fullName,
      this.gender,
      this.userImage,
      this.isInvisible,
      this.userGroupId,
      this.languageId,
      this.lastActivity,
      this.birthday,
      this.countryIso});

  factory _$_ArtistUser.fromJson(Map<String, dynamic> json) =>
      _$$_ArtistUserFromJson(json);

  @override
  final String? userId;
  @override
  final String? profilePageId;
  @override
  final String? userServerId;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  final String? fullName;
  @override
  final String? gender;
  @override
  final String? userImage;
  @override
  final String? isInvisible;
  @override
  final String? userGroupId;
  @override
  final String? languageId;
  @override
  final String? lastActivity;
  @override
  final String? birthday;
  @override
  final String? countryIso;

  @override
  String toString() {
    return 'ArtistUser(userId: $userId, profilePageId: $profilePageId, userServerId: $userServerId, userName: $userName, fullName: $fullName, gender: $gender, userImage: $userImage, isInvisible: $isInvisible, userGroupId: $userGroupId, languageId: $languageId, lastActivity: $lastActivity, birthday: $birthday, countryIso: $countryIso)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtistUser &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.profilePageId, profilePageId) &&
            const DeepCollectionEquality()
                .equals(other.userServerId, userServerId) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.userImage, userImage) &&
            const DeepCollectionEquality()
                .equals(other.isInvisible, isInvisible) &&
            const DeepCollectionEquality()
                .equals(other.userGroupId, userGroupId) &&
            const DeepCollectionEquality()
                .equals(other.languageId, languageId) &&
            const DeepCollectionEquality()
                .equals(other.lastActivity, lastActivity) &&
            const DeepCollectionEquality().equals(other.birthday, birthday) &&
            const DeepCollectionEquality()
                .equals(other.countryIso, countryIso));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(profilePageId),
      const DeepCollectionEquality().hash(userServerId),
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(gender),
      const DeepCollectionEquality().hash(userImage),
      const DeepCollectionEquality().hash(isInvisible),
      const DeepCollectionEquality().hash(userGroupId),
      const DeepCollectionEquality().hash(languageId),
      const DeepCollectionEquality().hash(lastActivity),
      const DeepCollectionEquality().hash(birthday),
      const DeepCollectionEquality().hash(countryIso));

  @JsonKey(ignore: true)
  @override
  _$ArtistUserCopyWith<_ArtistUser> get copyWith =>
      __$ArtistUserCopyWithImpl<_ArtistUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtistUserToJson(this);
  }
}

abstract class _ArtistUser implements ArtistUser {
  factory _ArtistUser(
      {String? userId,
      String? profilePageId,
      String? userServerId,
      @JsonKey(name: 'user_name') String? userName,
      String? fullName,
      String? gender,
      String? userImage,
      String? isInvisible,
      String? userGroupId,
      String? languageId,
      String? lastActivity,
      String? birthday,
      String? countryIso}) = _$_ArtistUser;

  factory _ArtistUser.fromJson(Map<String, dynamic> json) =
      _$_ArtistUser.fromJson;

  @override
  String? get userId;
  @override
  String? get profilePageId;
  @override
  String? get userServerId;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'user_name')
  String? get userName;
  @override
  String? get fullName;
  @override
  String? get gender;
  @override
  String? get userImage;
  @override
  String? get isInvisible;
  @override
  String? get userGroupId;
  @override
  String? get languageId;
  @override
  String? get lastActivity;
  @override
  String? get birthday;
  @override
  String? get countryIso;
  @override
  @JsonKey(ignore: true)
  _$ArtistUserCopyWith<_ArtistUser> get copyWith =>
      throw _privateConstructorUsedError;
}
