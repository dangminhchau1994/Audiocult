// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'playlist_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlaylistResponse _$PlaylistResponseFromJson(Map<String, dynamic> json) {
  return _PlaylistResponse.fromJson(json);
}

/// @nodoc
mixin _$PlaylistResponse {
  String? get isLiked =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  String? get profilePageId => throw _privateConstructorUsedError;
  String? get userServerId =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'user_name')
  String? get userName =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get userImage => throw _privateConstructorUsedError;
  String? get isInvisible => throw _privateConstructorUsedError;
  String? get userGroupId => throw _privateConstructorUsedError;
  String? get languageId => throw _privateConstructorUsedError;
  String? get lastActivity => throw _privateConstructorUsedError;
  String? get birthday => throw _privateConstructorUsedError;
  String? get countryIso =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'playlist_id')
  String? get playlistId =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'title')
  String? get title =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'description')
  String? get description =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'time_stamp')
  String? get timeStamp =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'total_likes')
  String? get totalLikes =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'total_comments')
  String? get totalComments => throw _privateConstructorUsedError;
  bool? get isFeatured =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'image_path')
  String? get imagePath => throw _privateConstructorUsedError;
  bool? get isDay =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'total_view')
  String? get totalView =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'last_icon')
  LastIcon? get lastIcon => throw _privateConstructorUsedError;
  String? get artistId => throw _privateConstructorUsedError;
  List<Songs>? get songs =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'count_songs')
  int? get countSongs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaylistResponseCopyWith<PlaylistResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistResponseCopyWith<$Res> {
  factory $PlaylistResponseCopyWith(
          PlaylistResponse value, $Res Function(PlaylistResponse) then) =
      _$PlaylistResponseCopyWithImpl<$Res>;
  $Res call(
      {String? isLiked,
      @JsonKey(name: 'user_id') String? userId,
      String? profilePageId,
      String? userServerId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'full_name') String? fullName,
      String? gender,
      String? userImage,
      String? isInvisible,
      String? userGroupId,
      String? languageId,
      String? lastActivity,
      String? birthday,
      String? countryIso,
      @JsonKey(name: 'playlist_id') String? playlistId,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'time_stamp') String? timeStamp,
      @JsonKey(name: 'total_likes') String? totalLikes,
      @JsonKey(name: 'total_comments') String? totalComments,
      bool? isFeatured,
      @JsonKey(name: 'image_path') String? imagePath,
      bool? isDay,
      @JsonKey(name: 'total_view') String? totalView,
      @JsonKey(name: 'last_icon') LastIcon? lastIcon,
      String? artistId,
      List<Songs>? songs,
      @JsonKey(name: 'count_songs') int? countSongs});

  $LastIconCopyWith<$Res>? get lastIcon;
}

/// @nodoc
class _$PlaylistResponseCopyWithImpl<$Res>
    implements $PlaylistResponseCopyWith<$Res> {
  _$PlaylistResponseCopyWithImpl(this._value, this._then);

  final PlaylistResponse _value;
  // ignore: unused_field
  final $Res Function(PlaylistResponse) _then;

  @override
  $Res call({
    Object? isLiked = freezed,
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
    Object? playlistId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? timeStamp = freezed,
    Object? totalLikes = freezed,
    Object? totalComments = freezed,
    Object? isFeatured = freezed,
    Object? imagePath = freezed,
    Object? isDay = freezed,
    Object? totalView = freezed,
    Object? lastIcon = freezed,
    Object? artistId = freezed,
    Object? songs = freezed,
    Object? countSongs = freezed,
  }) {
    return _then(_value.copyWith(
      isLiked: isLiked == freezed
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as String?,
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
      playlistId: playlistId == freezed
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      timeStamp: timeStamp == freezed
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
      totalLikes: totalLikes == freezed
          ? _value.totalLikes
          : totalLikes // ignore: cast_nullable_to_non_nullable
              as String?,
      totalComments: totalComments == freezed
          ? _value.totalComments
          : totalComments // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: isFeatured == freezed
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      isDay: isDay == freezed
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      totalView: totalView == freezed
          ? _value.totalView
          : totalView // ignore: cast_nullable_to_non_nullable
              as String?,
      lastIcon: lastIcon == freezed
          ? _value.lastIcon
          : lastIcon // ignore: cast_nullable_to_non_nullable
              as LastIcon?,
      artistId: artistId == freezed
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String?,
      songs: songs == freezed
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Songs>?,
      countSongs: countSongs == freezed
          ? _value.countSongs
          : countSongs // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$_PlaylistResponseCopyWith<$Res>
    implements $PlaylistResponseCopyWith<$Res> {
  factory _$$_PlaylistResponseCopyWith(
          _$_PlaylistResponse value, $Res Function(_$_PlaylistResponse) then) =
      __$$_PlaylistResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? isLiked,
      @JsonKey(name: 'user_id') String? userId,
      String? profilePageId,
      String? userServerId,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'full_name') String? fullName,
      String? gender,
      String? userImage,
      String? isInvisible,
      String? userGroupId,
      String? languageId,
      String? lastActivity,
      String? birthday,
      String? countryIso,
      @JsonKey(name: 'playlist_id') String? playlistId,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'time_stamp') String? timeStamp,
      @JsonKey(name: 'total_likes') String? totalLikes,
      @JsonKey(name: 'total_comments') String? totalComments,
      bool? isFeatured,
      @JsonKey(name: 'image_path') String? imagePath,
      bool? isDay,
      @JsonKey(name: 'total_view') String? totalView,
      @JsonKey(name: 'last_icon') LastIcon? lastIcon,
      String? artistId,
      List<Songs>? songs,
      @JsonKey(name: 'count_songs') int? countSongs});

  @override
  $LastIconCopyWith<$Res>? get lastIcon;
}

/// @nodoc
class __$$_PlaylistResponseCopyWithImpl<$Res>
    extends _$PlaylistResponseCopyWithImpl<$Res>
    implements _$$_PlaylistResponseCopyWith<$Res> {
  __$$_PlaylistResponseCopyWithImpl(
      _$_PlaylistResponse _value, $Res Function(_$_PlaylistResponse) _then)
      : super(_value, (v) => _then(v as _$_PlaylistResponse));

  @override
  _$_PlaylistResponse get _value => super._value as _$_PlaylistResponse;

  @override
  $Res call({
    Object? isLiked = freezed,
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
    Object? playlistId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? timeStamp = freezed,
    Object? totalLikes = freezed,
    Object? totalComments = freezed,
    Object? isFeatured = freezed,
    Object? imagePath = freezed,
    Object? isDay = freezed,
    Object? totalView = freezed,
    Object? lastIcon = freezed,
    Object? artistId = freezed,
    Object? songs = freezed,
    Object? countSongs = freezed,
  }) {
    return _then(_$_PlaylistResponse(
      isLiked: isLiked == freezed
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as String?,
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
      playlistId: playlistId == freezed
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      timeStamp: timeStamp == freezed
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
      totalLikes: totalLikes == freezed
          ? _value.totalLikes
          : totalLikes // ignore: cast_nullable_to_non_nullable
              as String?,
      totalComments: totalComments == freezed
          ? _value.totalComments
          : totalComments // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: isFeatured == freezed
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      isDay: isDay == freezed
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      totalView: totalView == freezed
          ? _value.totalView
          : totalView // ignore: cast_nullable_to_non_nullable
              as String?,
      lastIcon: lastIcon == freezed
          ? _value.lastIcon
          : lastIcon // ignore: cast_nullable_to_non_nullable
              as LastIcon?,
      artistId: artistId == freezed
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
              as String?,
      songs: songs == freezed
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Songs>?,
      countSongs: countSongs == freezed
          ? _value.countSongs
          : countSongs // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlaylistResponse implements _PlaylistResponse {
  _$_PlaylistResponse(
      {this.isLiked,
      @JsonKey(name: 'user_id') this.userId,
      this.profilePageId,
      this.userServerId,
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(name: 'full_name') this.fullName,
      this.gender,
      this.userImage,
      this.isInvisible,
      this.userGroupId,
      this.languageId,
      this.lastActivity,
      this.birthday,
      this.countryIso,
      @JsonKey(name: 'playlist_id') this.playlistId,
      @JsonKey(name: 'title') this.title,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'time_stamp') this.timeStamp,
      @JsonKey(name: 'total_likes') this.totalLikes,
      @JsonKey(name: 'total_comments') this.totalComments,
      this.isFeatured,
      @JsonKey(name: 'image_path') this.imagePath,
      this.isDay,
      @JsonKey(name: 'total_view') this.totalView,
      @JsonKey(name: 'last_icon') this.lastIcon,
      this.artistId,
      final List<Songs>? songs,
      @JsonKey(name: 'count_songs') this.countSongs})
      : _songs = songs;

  factory _$_PlaylistResponse.fromJson(Map<String, dynamic> json) =>
      _$$_PlaylistResponseFromJson(json);

  @override
  final String? isLiked;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  final String? profilePageId;
  @override
  final String? userServerId;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'full_name')
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
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'playlist_id')
  final String? playlistId;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'title')
  final String? title;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'description')
  final String? description;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'time_stamp')
  final String? timeStamp;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'total_likes')
  final String? totalLikes;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'total_comments')
  final String? totalComments;
  @override
  final bool? isFeatured;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'image_path')
  final String? imagePath;
  @override
  final bool? isDay;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'total_view')
  final String? totalView;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'last_icon')
  final LastIcon? lastIcon;
  @override
  final String? artistId;
  final List<Songs>? _songs;
  @override
  List<Songs>? get songs {
    final value = _songs;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'count_songs')
  final int? countSongs;

  @override
  String toString() {
    return 'PlaylistResponse(isLiked: $isLiked, userId: $userId, profilePageId: $profilePageId, userServerId: $userServerId, userName: $userName, fullName: $fullName, gender: $gender, userImage: $userImage, isInvisible: $isInvisible, userGroupId: $userGroupId, languageId: $languageId, lastActivity: $lastActivity, birthday: $birthday, countryIso: $countryIso, playlistId: $playlistId, title: $title, description: $description, timeStamp: $timeStamp, totalLikes: $totalLikes, totalComments: $totalComments, isFeatured: $isFeatured, imagePath: $imagePath, isDay: $isDay, totalView: $totalView, lastIcon: $lastIcon, artistId: $artistId, songs: $songs, countSongs: $countSongs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlaylistResponse &&
            const DeepCollectionEquality().equals(other.isLiked, isLiked) &&
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
                .equals(other.countryIso, countryIso) &&
            const DeepCollectionEquality()
                .equals(other.playlistId, playlistId) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.timeStamp, timeStamp) &&
            const DeepCollectionEquality()
                .equals(other.totalLikes, totalLikes) &&
            const DeepCollectionEquality()
                .equals(other.totalComments, totalComments) &&
            const DeepCollectionEquality()
                .equals(other.isFeatured, isFeatured) &&
            const DeepCollectionEquality().equals(other.imagePath, imagePath) &&
            const DeepCollectionEquality().equals(other.isDay, isDay) &&
            const DeepCollectionEquality().equals(other.totalView, totalView) &&
            const DeepCollectionEquality().equals(other.lastIcon, lastIcon) &&
            const DeepCollectionEquality().equals(other.artistId, artistId) &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            const DeepCollectionEquality()
                .equals(other.countSongs, countSongs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(isLiked),
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
        const DeepCollectionEquality().hash(countryIso),
        const DeepCollectionEquality().hash(playlistId),
        const DeepCollectionEquality().hash(title),
        const DeepCollectionEquality().hash(description),
        const DeepCollectionEquality().hash(timeStamp),
        const DeepCollectionEquality().hash(totalLikes),
        const DeepCollectionEquality().hash(totalComments),
        const DeepCollectionEquality().hash(isFeatured),
        const DeepCollectionEquality().hash(imagePath),
        const DeepCollectionEquality().hash(isDay),
        const DeepCollectionEquality().hash(totalView),
        const DeepCollectionEquality().hash(lastIcon),
        const DeepCollectionEquality().hash(artistId),
        const DeepCollectionEquality().hash(_songs),
        const DeepCollectionEquality().hash(countSongs)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_PlaylistResponseCopyWith<_$_PlaylistResponse> get copyWith =>
      __$$_PlaylistResponseCopyWithImpl<_$_PlaylistResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlaylistResponseToJson(this);
  }
}

abstract class _PlaylistResponse implements PlaylistResponse {
  factory _PlaylistResponse(
          {final String? isLiked,
          @JsonKey(name: 'user_id') final String? userId,
          final String? profilePageId,
          final String? userServerId,
          @JsonKey(name: 'user_name') final String? userName,
          @JsonKey(name: 'full_name') final String? fullName,
          final String? gender,
          final String? userImage,
          final String? isInvisible,
          final String? userGroupId,
          final String? languageId,
          final String? lastActivity,
          final String? birthday,
          final String? countryIso,
          @JsonKey(name: 'playlist_id') final String? playlistId,
          @JsonKey(name: 'title') final String? title,
          @JsonKey(name: 'description') final String? description,
          @JsonKey(name: 'time_stamp') final String? timeStamp,
          @JsonKey(name: 'total_likes') final String? totalLikes,
          @JsonKey(name: 'total_comments') final String? totalComments,
          final bool? isFeatured,
          @JsonKey(name: 'image_path') final String? imagePath,
          final bool? isDay,
          @JsonKey(name: 'total_view') final String? totalView,
          @JsonKey(name: 'last_icon') final LastIcon? lastIcon,
          final String? artistId,
          final List<Songs>? songs,
          @JsonKey(name: 'count_songs') final int? countSongs}) =
      _$_PlaylistResponse;

  factory _PlaylistResponse.fromJson(Map<String, dynamic> json) =
      _$_PlaylistResponse.fromJson;

  @override
  String? get isLiked => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @override
  String? get profilePageId => throw _privateConstructorUsedError;
  @override
  String? get userServerId => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'user_name')
  String? get userName => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  @override
  String? get gender => throw _privateConstructorUsedError;
  @override
  String? get userImage => throw _privateConstructorUsedError;
  @override
  String? get isInvisible => throw _privateConstructorUsedError;
  @override
  String? get userGroupId => throw _privateConstructorUsedError;
  @override
  String? get languageId => throw _privateConstructorUsedError;
  @override
  String? get lastActivity => throw _privateConstructorUsedError;
  @override
  String? get birthday => throw _privateConstructorUsedError;
  @override
  String? get countryIso => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'playlist_id')
  String? get playlistId => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'time_stamp')
  String? get timeStamp => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'total_likes')
  String? get totalLikes => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'total_comments')
  String? get totalComments => throw _privateConstructorUsedError;
  @override
  bool? get isFeatured => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'image_path')
  String? get imagePath => throw _privateConstructorUsedError;
  @override
  bool? get isDay => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'total_view')
  String? get totalView => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'last_icon')
  LastIcon? get lastIcon => throw _privateConstructorUsedError;
  @override
  String? get artistId => throw _privateConstructorUsedError;
  @override
  List<Songs>? get songs => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'count_songs')
  int? get countSongs => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PlaylistResponseCopyWith<_$_PlaylistResponse> get copyWith =>
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

Songs _$SongsFromJson(Map<String, dynamic> json) {
  return _Songs.fromJson(json);
}

/// @nodoc
mixin _$Songs {
  String? get id => throw _privateConstructorUsedError;
  String? get songId => throw _privateConstructorUsedError;
  String? get playlistId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get timeStamp => throw _privateConstructorUsedError;
  String? get profilePageId => throw _privateConstructorUsedError;
  String? get serverId => throw _privateConstructorUsedError;
  String? get userGroupId => throw _privateConstructorUsedError;
  String? get statusId => throw _privateConstructorUsedError;
  String? get viewId => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get passwordSalt => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get birthday => throw _privateConstructorUsedError;
  String? get birthdaySearch => throw _privateConstructorUsedError;
  String? get countryIso => throw _privateConstructorUsedError;
  String? get languageId => throw _privateConstructorUsedError;
  String? get styleId => throw _privateConstructorUsedError;
  dynamic get timeZone => throw _privateConstructorUsedError;
  String? get dstCheck => throw _privateConstructorUsedError;
  String? get joined => throw _privateConstructorUsedError;
  String? get lastLogin => throw _privateConstructorUsedError;
  String? get lastActivity => throw _privateConstructorUsedError;
  String? get userImage => throw _privateConstructorUsedError;
  String? get hideTip => throw _privateConstructorUsedError;
  dynamic get status => throw _privateConstructorUsedError;
  String? get footerBar => throw _privateConstructorUsedError;
  String? get inviteUserId => throw _privateConstructorUsedError;
  String? get imBeep => throw _privateConstructorUsedError;
  String? get imHide => throw _privateConstructorUsedError;
  String? get isInvisible => throw _privateConstructorUsedError;
  String? get totalSpam => throw _privateConstructorUsedError;
  String? get lastIpAddress => throw _privateConstructorUsedError;
  String? get feedSort => throw _privateConstructorUsedError;
  String? get customGender => throw _privateConstructorUsedError;
  String? get totalProfileLike => throw _privateConstructorUsedError;
  String? get isVerified => throw _privateConstructorUsedError;
  String? get reminderDate => throw _privateConstructorUsedError;
  double? get blogRating => throw _privateConstructorUsedError;
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
  String? get descriptionParsed => throw _privateConstructorUsedError;
  String? get licenseType => throw _privateConstructorUsedError;
  String? get songPath => throw _privateConstructorUsedError;
  String? get explicit => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  String? get ordering => throw _privateConstructorUsedError;
  String? get imageServerId => throw _privateConstructorUsedError;
  String? get totalPlay => throw _privateConstructorUsedError;
  String? get totalView => throw _privateConstructorUsedError;
  String? get totalComment => throw _privateConstructorUsedError;
  String? get totalLike => throw _privateConstructorUsedError;
  String? get totalDislike => throw _privateConstructorUsedError;
  String? get totalScore => throw _privateConstructorUsedError;
  String? get totalRating => throw _privateConstructorUsedError;
  String? get totalAttachment => throw _privateConstructorUsedError;
  int? get moduleId => throw _privateConstructorUsedError;
  String? get itemId => throw _privateConstructorUsedError;
  String? get disableDownload => throw _privateConstructorUsedError;
  String? get isrc => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get isDay => throw _privateConstructorUsedError;
  String? get artistId => throw _privateConstructorUsedError;
  String? get lyrics => throw _privateConstructorUsedError;
  String? get cost => throw _privateConstructorUsedError;
  int? get totalDownload => throw _privateConstructorUsedError;
  String? get tags => throw _privateConstructorUsedError;
  String? get itunes => throw _privateConstructorUsedError;
  String? get amazon => throw _privateConstructorUsedError;
  String? get googleplay => throw _privateConstructorUsedError;
  String? get youtube => throw _privateConstructorUsedError;
  String? get soundcloud => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  String? get labelUser => throw _privateConstructorUsedError;
  String? get labelUserId => throw _privateConstructorUsedError;
  String? get artistUser => throw _privateConstructorUsedError;
  String? get artistUserId => throw _privateConstructorUsedError;
  String? get collabUser => throw _privateConstructorUsedError;
  String? get collabUserId => throw _privateConstructorUsedError;
  String? get peaksJsonUrl => throw _privateConstructorUsedError;
  String? get titleTruncate => throw _privateConstructorUsedError;
  int? get noPhoto => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongsCopyWith<Songs> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongsCopyWith<$Res> {
  factory $SongsCopyWith(Songs value, $Res Function(Songs) then) =
      _$SongsCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? songId,
      String? playlistId,
      String? userId,
      String? timeStamp,
      String? profilePageId,
      String? serverId,
      String? userGroupId,
      String? statusId,
      String? viewId,
      String? userName,
      String? fullName,
      String? password,
      String? passwordSalt,
      String? email,
      String? gender,
      String? birthday,
      String? birthdaySearch,
      String? countryIso,
      String? languageId,
      String? styleId,
      dynamic timeZone,
      String? dstCheck,
      String? joined,
      String? lastLogin,
      String? lastActivity,
      String? userImage,
      String? hideTip,
      dynamic status,
      String? footerBar,
      String? inviteUserId,
      String? imBeep,
      String? imHide,
      String? isInvisible,
      String? totalSpam,
      String? lastIpAddress,
      String? feedSort,
      String? customGender,
      String? totalProfileLike,
      String? isVerified,
      String? reminderDate,
      double? blogRating,
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
      String? descriptionParsed,
      String? licenseType,
      String? songPath,
      String? explicit,
      String? duration,
      String? ordering,
      String? imageServerId,
      String? totalPlay,
      String? totalView,
      String? totalComment,
      String? totalLike,
      String? totalDislike,
      String? totalScore,
      String? totalRating,
      String? totalAttachment,
      int? moduleId,
      String? itemId,
      String? disableDownload,
      String? isrc,
      String? url,
      String? isDay,
      String? artistId,
      String? lyrics,
      String? cost,
      int? totalDownload,
      String? tags,
      String? itunes,
      String? amazon,
      String? googleplay,
      String? youtube,
      String? soundcloud,
      String? imagePath,
      String? labelUser,
      String? labelUserId,
      String? artistUser,
      String? artistUserId,
      String? collabUser,
      String? collabUserId,
      String? peaksJsonUrl,
      String? titleTruncate,
      int? noPhoto});
}

/// @nodoc
class _$SongsCopyWithImpl<$Res> implements $SongsCopyWith<$Res> {
  _$SongsCopyWithImpl(this._value, this._then);

  final Songs _value;
  // ignore: unused_field
  final $Res Function(Songs) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? songId = freezed,
    Object? playlistId = freezed,
    Object? userId = freezed,
    Object? timeStamp = freezed,
    Object? profilePageId = freezed,
    Object? serverId = freezed,
    Object? userGroupId = freezed,
    Object? statusId = freezed,
    Object? viewId = freezed,
    Object? userName = freezed,
    Object? fullName = freezed,
    Object? password = freezed,
    Object? passwordSalt = freezed,
    Object? email = freezed,
    Object? gender = freezed,
    Object? birthday = freezed,
    Object? birthdaySearch = freezed,
    Object? countryIso = freezed,
    Object? languageId = freezed,
    Object? styleId = freezed,
    Object? timeZone = freezed,
    Object? dstCheck = freezed,
    Object? joined = freezed,
    Object? lastLogin = freezed,
    Object? lastActivity = freezed,
    Object? userImage = freezed,
    Object? hideTip = freezed,
    Object? status = freezed,
    Object? footerBar = freezed,
    Object? inviteUserId = freezed,
    Object? imBeep = freezed,
    Object? imHide = freezed,
    Object? isInvisible = freezed,
    Object? totalSpam = freezed,
    Object? lastIpAddress = freezed,
    Object? feedSort = freezed,
    Object? customGender = freezed,
    Object? totalProfileLike = freezed,
    Object? isVerified = freezed,
    Object? reminderDate = freezed,
    Object? blogRating = freezed,
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
    Object? descriptionParsed = freezed,
    Object? licenseType = freezed,
    Object? songPath = freezed,
    Object? explicit = freezed,
    Object? duration = freezed,
    Object? ordering = freezed,
    Object? imageServerId = freezed,
    Object? totalPlay = freezed,
    Object? totalView = freezed,
    Object? totalComment = freezed,
    Object? totalLike = freezed,
    Object? totalDislike = freezed,
    Object? totalScore = freezed,
    Object? totalRating = freezed,
    Object? totalAttachment = freezed,
    Object? moduleId = freezed,
    Object? itemId = freezed,
    Object? disableDownload = freezed,
    Object? isrc = freezed,
    Object? url = freezed,
    Object? isDay = freezed,
    Object? artistId = freezed,
    Object? lyrics = freezed,
    Object? cost = freezed,
    Object? totalDownload = freezed,
    Object? tags = freezed,
    Object? itunes = freezed,
    Object? amazon = freezed,
    Object? googleplay = freezed,
    Object? youtube = freezed,
    Object? soundcloud = freezed,
    Object? imagePath = freezed,
    Object? labelUser = freezed,
    Object? labelUserId = freezed,
    Object? artistUser = freezed,
    Object? artistUserId = freezed,
    Object? collabUser = freezed,
    Object? collabUserId = freezed,
    Object? peaksJsonUrl = freezed,
    Object? titleTruncate = freezed,
    Object? noPhoto = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      songId: songId == freezed
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
              as String?,
      playlistId: playlistId == freezed
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      timeStamp: timeStamp == freezed
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePageId: profilePageId == freezed
          ? _value.profilePageId
          : profilePageId // ignore: cast_nullable_to_non_nullable
              as String?,
      serverId: serverId == freezed
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      userGroupId: userGroupId == freezed
          ? _value.userGroupId
          : userGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
      statusId: statusId == freezed
          ? _value.statusId
          : statusId // ignore: cast_nullable_to_non_nullable
              as String?,
      viewId: viewId == freezed
          ? _value.viewId
          : viewId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordSalt: passwordSalt == freezed
          ? _value.passwordSalt
          : passwordSalt // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdaySearch: birthdaySearch == freezed
          ? _value.birthdaySearch
          : birthdaySearch // ignore: cast_nullable_to_non_nullable
              as String?,
      countryIso: countryIso == freezed
          ? _value.countryIso
          : countryIso // ignore: cast_nullable_to_non_nullable
              as String?,
      languageId: languageId == freezed
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as String?,
      styleId: styleId == freezed
          ? _value.styleId
          : styleId // ignore: cast_nullable_to_non_nullable
              as String?,
      timeZone: timeZone == freezed
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as dynamic,
      dstCheck: dstCheck == freezed
          ? _value.dstCheck
          : dstCheck // ignore: cast_nullable_to_non_nullable
              as String?,
      joined: joined == freezed
          ? _value.joined
          : joined // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLogin: lastLogin == freezed
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as String?,
      lastActivity: lastActivity == freezed
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: userImage == freezed
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      hideTip: hideTip == freezed
          ? _value.hideTip
          : hideTip // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as dynamic,
      footerBar: footerBar == freezed
          ? _value.footerBar
          : footerBar // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteUserId: inviteUserId == freezed
          ? _value.inviteUserId
          : inviteUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      imBeep: imBeep == freezed
          ? _value.imBeep
          : imBeep // ignore: cast_nullable_to_non_nullable
              as String?,
      imHide: imHide == freezed
          ? _value.imHide
          : imHide // ignore: cast_nullable_to_non_nullable
              as String?,
      isInvisible: isInvisible == freezed
          ? _value.isInvisible
          : isInvisible // ignore: cast_nullable_to_non_nullable
              as String?,
      totalSpam: totalSpam == freezed
          ? _value.totalSpam
          : totalSpam // ignore: cast_nullable_to_non_nullable
              as String?,
      lastIpAddress: lastIpAddress == freezed
          ? _value.lastIpAddress
          : lastIpAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      feedSort: feedSort == freezed
          ? _value.feedSort
          : feedSort // ignore: cast_nullable_to_non_nullable
              as String?,
      customGender: customGender == freezed
          ? _value.customGender
          : customGender // ignore: cast_nullable_to_non_nullable
              as String?,
      totalProfileLike: totalProfileLike == freezed
          ? _value.totalProfileLike
          : totalProfileLike // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: isVerified == freezed
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as String?,
      reminderDate: reminderDate == freezed
          ? _value.reminderDate
          : reminderDate // ignore: cast_nullable_to_non_nullable
              as String?,
      blogRating: blogRating == freezed
          ? _value.blogRating
          : blogRating // ignore: cast_nullable_to_non_nullable
              as double?,
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
      descriptionParsed: descriptionParsed == freezed
          ? _value.descriptionParsed
          : descriptionParsed // ignore: cast_nullable_to_non_nullable
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
              as String?,
      ordering: ordering == freezed
          ? _value.ordering
          : ordering // ignore: cast_nullable_to_non_nullable
              as String?,
      imageServerId: imageServerId == freezed
          ? _value.imageServerId
          : imageServerId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      moduleId: moduleId == freezed
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as int?,
      itemId: itemId == freezed
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      disableDownload: disableDownload == freezed
          ? _value.disableDownload
          : disableDownload // ignore: cast_nullable_to_non_nullable
              as String?,
      isrc: isrc == freezed
          ? _value.isrc
          : isrc // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      isDay: isDay == freezed
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as String?,
      artistId: artistId == freezed
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
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
              as int?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
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
              as String?,
      soundcloud: soundcloud == freezed
          ? _value.soundcloud
          : soundcloud // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      labelUser: labelUser == freezed
          ? _value.labelUser
          : labelUser // ignore: cast_nullable_to_non_nullable
              as String?,
      labelUserId: labelUserId == freezed
          ? _value.labelUserId
          : labelUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      artistUser: artistUser == freezed
          ? _value.artistUser
          : artistUser // ignore: cast_nullable_to_non_nullable
              as String?,
      artistUserId: artistUserId == freezed
          ? _value.artistUserId
          : artistUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      collabUser: collabUser == freezed
          ? _value.collabUser
          : collabUser // ignore: cast_nullable_to_non_nullable
              as String?,
      collabUserId: collabUserId == freezed
          ? _value.collabUserId
          : collabUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      peaksJsonUrl: peaksJsonUrl == freezed
          ? _value.peaksJsonUrl
          : peaksJsonUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      titleTruncate: titleTruncate == freezed
          ? _value.titleTruncate
          : titleTruncate // ignore: cast_nullable_to_non_nullable
              as String?,
      noPhoto: noPhoto == freezed
          ? _value.noPhoto
          : noPhoto // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_SongsCopyWith<$Res> implements $SongsCopyWith<$Res> {
  factory _$$_SongsCopyWith(_$_Songs value, $Res Function(_$_Songs) then) =
      __$$_SongsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? songId,
      String? playlistId,
      String? userId,
      String? timeStamp,
      String? profilePageId,
      String? serverId,
      String? userGroupId,
      String? statusId,
      String? viewId,
      String? userName,
      String? fullName,
      String? password,
      String? passwordSalt,
      String? email,
      String? gender,
      String? birthday,
      String? birthdaySearch,
      String? countryIso,
      String? languageId,
      String? styleId,
      dynamic timeZone,
      String? dstCheck,
      String? joined,
      String? lastLogin,
      String? lastActivity,
      String? userImage,
      String? hideTip,
      dynamic status,
      String? footerBar,
      String? inviteUserId,
      String? imBeep,
      String? imHide,
      String? isInvisible,
      String? totalSpam,
      String? lastIpAddress,
      String? feedSort,
      String? customGender,
      String? totalProfileLike,
      String? isVerified,
      String? reminderDate,
      double? blogRating,
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
      String? descriptionParsed,
      String? licenseType,
      String? songPath,
      String? explicit,
      String? duration,
      String? ordering,
      String? imageServerId,
      String? totalPlay,
      String? totalView,
      String? totalComment,
      String? totalLike,
      String? totalDislike,
      String? totalScore,
      String? totalRating,
      String? totalAttachment,
      int? moduleId,
      String? itemId,
      String? disableDownload,
      String? isrc,
      String? url,
      String? isDay,
      String? artistId,
      String? lyrics,
      String? cost,
      int? totalDownload,
      String? tags,
      String? itunes,
      String? amazon,
      String? googleplay,
      String? youtube,
      String? soundcloud,
      String? imagePath,
      String? labelUser,
      String? labelUserId,
      String? artistUser,
      String? artistUserId,
      String? collabUser,
      String? collabUserId,
      String? peaksJsonUrl,
      String? titleTruncate,
      int? noPhoto});
}

/// @nodoc
class __$$_SongsCopyWithImpl<$Res> extends _$SongsCopyWithImpl<$Res>
    implements _$$_SongsCopyWith<$Res> {
  __$$_SongsCopyWithImpl(_$_Songs _value, $Res Function(_$_Songs) _then)
      : super(_value, (v) => _then(v as _$_Songs));

  @override
  _$_Songs get _value => super._value as _$_Songs;

  @override
  $Res call({
    Object? id = freezed,
    Object? songId = freezed,
    Object? playlistId = freezed,
    Object? userId = freezed,
    Object? timeStamp = freezed,
    Object? profilePageId = freezed,
    Object? serverId = freezed,
    Object? userGroupId = freezed,
    Object? statusId = freezed,
    Object? viewId = freezed,
    Object? userName = freezed,
    Object? fullName = freezed,
    Object? password = freezed,
    Object? passwordSalt = freezed,
    Object? email = freezed,
    Object? gender = freezed,
    Object? birthday = freezed,
    Object? birthdaySearch = freezed,
    Object? countryIso = freezed,
    Object? languageId = freezed,
    Object? styleId = freezed,
    Object? timeZone = freezed,
    Object? dstCheck = freezed,
    Object? joined = freezed,
    Object? lastLogin = freezed,
    Object? lastActivity = freezed,
    Object? userImage = freezed,
    Object? hideTip = freezed,
    Object? status = freezed,
    Object? footerBar = freezed,
    Object? inviteUserId = freezed,
    Object? imBeep = freezed,
    Object? imHide = freezed,
    Object? isInvisible = freezed,
    Object? totalSpam = freezed,
    Object? lastIpAddress = freezed,
    Object? feedSort = freezed,
    Object? customGender = freezed,
    Object? totalProfileLike = freezed,
    Object? isVerified = freezed,
    Object? reminderDate = freezed,
    Object? blogRating = freezed,
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
    Object? descriptionParsed = freezed,
    Object? licenseType = freezed,
    Object? songPath = freezed,
    Object? explicit = freezed,
    Object? duration = freezed,
    Object? ordering = freezed,
    Object? imageServerId = freezed,
    Object? totalPlay = freezed,
    Object? totalView = freezed,
    Object? totalComment = freezed,
    Object? totalLike = freezed,
    Object? totalDislike = freezed,
    Object? totalScore = freezed,
    Object? totalRating = freezed,
    Object? totalAttachment = freezed,
    Object? moduleId = freezed,
    Object? itemId = freezed,
    Object? disableDownload = freezed,
    Object? isrc = freezed,
    Object? url = freezed,
    Object? isDay = freezed,
    Object? artistId = freezed,
    Object? lyrics = freezed,
    Object? cost = freezed,
    Object? totalDownload = freezed,
    Object? tags = freezed,
    Object? itunes = freezed,
    Object? amazon = freezed,
    Object? googleplay = freezed,
    Object? youtube = freezed,
    Object? soundcloud = freezed,
    Object? imagePath = freezed,
    Object? labelUser = freezed,
    Object? labelUserId = freezed,
    Object? artistUser = freezed,
    Object? artistUserId = freezed,
    Object? collabUser = freezed,
    Object? collabUserId = freezed,
    Object? peaksJsonUrl = freezed,
    Object? titleTruncate = freezed,
    Object? noPhoto = freezed,
  }) {
    return _then(_$_Songs(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      songId: songId == freezed
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
              as String?,
      playlistId: playlistId == freezed
          ? _value.playlistId
          : playlistId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      timeStamp: timeStamp == freezed
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePageId: profilePageId == freezed
          ? _value.profilePageId
          : profilePageId // ignore: cast_nullable_to_non_nullable
              as String?,
      serverId: serverId == freezed
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      userGroupId: userGroupId == freezed
          ? _value.userGroupId
          : userGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
      statusId: statusId == freezed
          ? _value.statusId
          : statusId // ignore: cast_nullable_to_non_nullable
              as String?,
      viewId: viewId == freezed
          ? _value.viewId
          : viewId // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordSalt: passwordSalt == freezed
          ? _value.passwordSalt
          : passwordSalt // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdaySearch: birthdaySearch == freezed
          ? _value.birthdaySearch
          : birthdaySearch // ignore: cast_nullable_to_non_nullable
              as String?,
      countryIso: countryIso == freezed
          ? _value.countryIso
          : countryIso // ignore: cast_nullable_to_non_nullable
              as String?,
      languageId: languageId == freezed
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as String?,
      styleId: styleId == freezed
          ? _value.styleId
          : styleId // ignore: cast_nullable_to_non_nullable
              as String?,
      timeZone: timeZone == freezed
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as dynamic,
      dstCheck: dstCheck == freezed
          ? _value.dstCheck
          : dstCheck // ignore: cast_nullable_to_non_nullable
              as String?,
      joined: joined == freezed
          ? _value.joined
          : joined // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLogin: lastLogin == freezed
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as String?,
      lastActivity: lastActivity == freezed
          ? _value.lastActivity
          : lastActivity // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: userImage == freezed
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      hideTip: hideTip == freezed
          ? _value.hideTip
          : hideTip // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as dynamic,
      footerBar: footerBar == freezed
          ? _value.footerBar
          : footerBar // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteUserId: inviteUserId == freezed
          ? _value.inviteUserId
          : inviteUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      imBeep: imBeep == freezed
          ? _value.imBeep
          : imBeep // ignore: cast_nullable_to_non_nullable
              as String?,
      imHide: imHide == freezed
          ? _value.imHide
          : imHide // ignore: cast_nullable_to_non_nullable
              as String?,
      isInvisible: isInvisible == freezed
          ? _value.isInvisible
          : isInvisible // ignore: cast_nullable_to_non_nullable
              as String?,
      totalSpam: totalSpam == freezed
          ? _value.totalSpam
          : totalSpam // ignore: cast_nullable_to_non_nullable
              as String?,
      lastIpAddress: lastIpAddress == freezed
          ? _value.lastIpAddress
          : lastIpAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      feedSort: feedSort == freezed
          ? _value.feedSort
          : feedSort // ignore: cast_nullable_to_non_nullable
              as String?,
      customGender: customGender == freezed
          ? _value.customGender
          : customGender // ignore: cast_nullable_to_non_nullable
              as String?,
      totalProfileLike: totalProfileLike == freezed
          ? _value.totalProfileLike
          : totalProfileLike // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: isVerified == freezed
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as String?,
      reminderDate: reminderDate == freezed
          ? _value.reminderDate
          : reminderDate // ignore: cast_nullable_to_non_nullable
              as String?,
      blogRating: blogRating == freezed
          ? _value.blogRating
          : blogRating // ignore: cast_nullable_to_non_nullable
              as double?,
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
      descriptionParsed: descriptionParsed == freezed
          ? _value.descriptionParsed
          : descriptionParsed // ignore: cast_nullable_to_non_nullable
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
              as String?,
      ordering: ordering == freezed
          ? _value.ordering
          : ordering // ignore: cast_nullable_to_non_nullable
              as String?,
      imageServerId: imageServerId == freezed
          ? _value.imageServerId
          : imageServerId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      moduleId: moduleId == freezed
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as int?,
      itemId: itemId == freezed
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      disableDownload: disableDownload == freezed
          ? _value.disableDownload
          : disableDownload // ignore: cast_nullable_to_non_nullable
              as String?,
      isrc: isrc == freezed
          ? _value.isrc
          : isrc // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      isDay: isDay == freezed
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as String?,
      artistId: artistId == freezed
          ? _value.artistId
          : artistId // ignore: cast_nullable_to_non_nullable
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
              as int?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
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
              as String?,
      soundcloud: soundcloud == freezed
          ? _value.soundcloud
          : soundcloud // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      labelUser: labelUser == freezed
          ? _value.labelUser
          : labelUser // ignore: cast_nullable_to_non_nullable
              as String?,
      labelUserId: labelUserId == freezed
          ? _value.labelUserId
          : labelUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      artistUser: artistUser == freezed
          ? _value.artistUser
          : artistUser // ignore: cast_nullable_to_non_nullable
              as String?,
      artistUserId: artistUserId == freezed
          ? _value.artistUserId
          : artistUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      collabUser: collabUser == freezed
          ? _value.collabUser
          : collabUser // ignore: cast_nullable_to_non_nullable
              as String?,
      collabUserId: collabUserId == freezed
          ? _value.collabUserId
          : collabUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      peaksJsonUrl: peaksJsonUrl == freezed
          ? _value.peaksJsonUrl
          : peaksJsonUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      titleTruncate: titleTruncate == freezed
          ? _value.titleTruncate
          : titleTruncate // ignore: cast_nullable_to_non_nullable
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
class _$_Songs implements _Songs {
  _$_Songs(
      {this.id,
      this.songId,
      this.playlistId,
      this.userId,
      this.timeStamp,
      this.profilePageId,
      this.serverId,
      this.userGroupId,
      this.statusId,
      this.viewId,
      this.userName,
      this.fullName,
      this.password,
      this.passwordSalt,
      this.email,
      this.gender,
      this.birthday,
      this.birthdaySearch,
      this.countryIso,
      this.languageId,
      this.styleId,
      this.timeZone,
      this.dstCheck,
      this.joined,
      this.lastLogin,
      this.lastActivity,
      this.userImage,
      this.hideTip,
      this.status,
      this.footerBar,
      this.inviteUserId,
      this.imBeep,
      this.imHide,
      this.isInvisible,
      this.totalSpam,
      this.lastIpAddress,
      this.feedSort,
      this.customGender,
      this.totalProfileLike,
      this.isVerified,
      this.reminderDate,
      this.blogRating,
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
      this.descriptionParsed,
      this.licenseType,
      this.songPath,
      this.explicit,
      this.duration,
      this.ordering,
      this.imageServerId,
      this.totalPlay,
      this.totalView,
      this.totalComment,
      this.totalLike,
      this.totalDislike,
      this.totalScore,
      this.totalRating,
      this.totalAttachment,
      this.moduleId,
      this.itemId,
      this.disableDownload,
      this.isrc,
      this.url,
      this.isDay,
      this.artistId,
      this.lyrics,
      this.cost,
      this.totalDownload,
      this.tags,
      this.itunes,
      this.amazon,
      this.googleplay,
      this.youtube,
      this.soundcloud,
      this.imagePath,
      this.labelUser,
      this.labelUserId,
      this.artistUser,
      this.artistUserId,
      this.collabUser,
      this.collabUserId,
      this.peaksJsonUrl,
      this.titleTruncate,
      this.noPhoto});

  factory _$_Songs.fromJson(Map<String, dynamic> json) =>
      _$$_SongsFromJson(json);

  @override
  final String? id;
  @override
  final String? songId;
  @override
  final String? playlistId;
  @override
  final String? userId;
  @override
  final String? timeStamp;
  @override
  final String? profilePageId;
  @override
  final String? serverId;
  @override
  final String? userGroupId;
  @override
  final String? statusId;
  @override
  final String? viewId;
  @override
  final String? userName;
  @override
  final String? fullName;
  @override
  final String? password;
  @override
  final String? passwordSalt;
  @override
  final String? email;
  @override
  final String? gender;
  @override
  final String? birthday;
  @override
  final String? birthdaySearch;
  @override
  final String? countryIso;
  @override
  final String? languageId;
  @override
  final String? styleId;
  @override
  final dynamic timeZone;
  @override
  final String? dstCheck;
  @override
  final String? joined;
  @override
  final String? lastLogin;
  @override
  final String? lastActivity;
  @override
  final String? userImage;
  @override
  final String? hideTip;
  @override
  final dynamic status;
  @override
  final String? footerBar;
  @override
  final String? inviteUserId;
  @override
  final String? imBeep;
  @override
  final String? imHide;
  @override
  final String? isInvisible;
  @override
  final String? totalSpam;
  @override
  final String? lastIpAddress;
  @override
  final String? feedSort;
  @override
  final String? customGender;
  @override
  final String? totalProfileLike;
  @override
  final String? isVerified;
  @override
  final String? reminderDate;
  @override
  final double? blogRating;
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
  final String? descriptionParsed;
  @override
  final String? licenseType;
  @override
  final String? songPath;
  @override
  final String? explicit;
  @override
  final String? duration;
  @override
  final String? ordering;
  @override
  final String? imageServerId;
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
  @override
  final int? moduleId;
  @override
  final String? itemId;
  @override
  final String? disableDownload;
  @override
  final String? isrc;
  @override
  final String? url;
  @override
  final String? isDay;
  @override
  final String? artistId;
  @override
  final String? lyrics;
  @override
  final String? cost;
  @override
  final int? totalDownload;
  @override
  final String? tags;
  @override
  final String? itunes;
  @override
  final String? amazon;
  @override
  final String? googleplay;
  @override
  final String? youtube;
  @override
  final String? soundcloud;
  @override
  final String? imagePath;
  @override
  final String? labelUser;
  @override
  final String? labelUserId;
  @override
  final String? artistUser;
  @override
  final String? artistUserId;
  @override
  final String? collabUser;
  @override
  final String? collabUserId;
  @override
  final String? peaksJsonUrl;
  @override
  final String? titleTruncate;
  @override
  final int? noPhoto;

  @override
  String toString() {
    return 'Songs(id: $id, songId: $songId, playlistId: $playlistId, userId: $userId, timeStamp: $timeStamp, profilePageId: $profilePageId, serverId: $serverId, userGroupId: $userGroupId, statusId: $statusId, viewId: $viewId, userName: $userName, fullName: $fullName, password: $password, passwordSalt: $passwordSalt, email: $email, gender: $gender, birthday: $birthday, birthdaySearch: $birthdaySearch, countryIso: $countryIso, languageId: $languageId, styleId: $styleId, timeZone: $timeZone, dstCheck: $dstCheck, joined: $joined, lastLogin: $lastLogin, lastActivity: $lastActivity, userImage: $userImage, hideTip: $hideTip, status: $status, footerBar: $footerBar, inviteUserId: $inviteUserId, imBeep: $imBeep, imHide: $imHide, isInvisible: $isInvisible, totalSpam: $totalSpam, lastIpAddress: $lastIpAddress, feedSort: $feedSort, customGender: $customGender, totalProfileLike: $totalProfileLike, isVerified: $isVerified, reminderDate: $reminderDate, blogRating: $blogRating, privacy: $privacy, privacyComment: $privacyComment, isFree: $isFree, isFeatured: $isFeatured, isSponsor: $isSponsor, albumId: $albumId, genreId: $genreId, isDj: $isDj, title: $title, description: $description, descriptionParsed: $descriptionParsed, licenseType: $licenseType, songPath: $songPath, explicit: $explicit, duration: $duration, ordering: $ordering, imageServerId: $imageServerId, totalPlay: $totalPlay, totalView: $totalView, totalComment: $totalComment, totalLike: $totalLike, totalDislike: $totalDislike, totalScore: $totalScore, totalRating: $totalRating, totalAttachment: $totalAttachment, moduleId: $moduleId, itemId: $itemId, disableDownload: $disableDownload, isrc: $isrc, url: $url, isDay: $isDay, artistId: $artistId, lyrics: $lyrics, cost: $cost, totalDownload: $totalDownload, tags: $tags, itunes: $itunes, amazon: $amazon, googleplay: $googleplay, youtube: $youtube, soundcloud: $soundcloud, imagePath: $imagePath, labelUser: $labelUser, labelUserId: $labelUserId, artistUser: $artistUser, artistUserId: $artistUserId, collabUser: $collabUser, collabUserId: $collabUserId, peaksJsonUrl: $peaksJsonUrl, titleTruncate: $titleTruncate, noPhoto: $noPhoto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Songs &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.songId, songId) &&
            const DeepCollectionEquality()
                .equals(other.playlistId, playlistId) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.timeStamp, timeStamp) &&
            const DeepCollectionEquality()
                .equals(other.profilePageId, profilePageId) &&
            const DeepCollectionEquality().equals(other.serverId, serverId) &&
            const DeepCollectionEquality()
                .equals(other.userGroupId, userGroupId) &&
            const DeepCollectionEquality().equals(other.statusId, statusId) &&
            const DeepCollectionEquality().equals(other.viewId, viewId) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality()
                .equals(other.passwordSalt, passwordSalt) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.birthday, birthday) &&
            const DeepCollectionEquality()
                .equals(other.birthdaySearch, birthdaySearch) &&
            const DeepCollectionEquality()
                .equals(other.countryIso, countryIso) &&
            const DeepCollectionEquality()
                .equals(other.languageId, languageId) &&
            const DeepCollectionEquality().equals(other.styleId, styleId) &&
            const DeepCollectionEquality().equals(other.timeZone, timeZone) &&
            const DeepCollectionEquality().equals(other.dstCheck, dstCheck) &&
            const DeepCollectionEquality().equals(other.joined, joined) &&
            const DeepCollectionEquality().equals(other.lastLogin, lastLogin) &&
            const DeepCollectionEquality()
                .equals(other.lastActivity, lastActivity) &&
            const DeepCollectionEquality().equals(other.userImage, userImage) &&
            const DeepCollectionEquality().equals(other.hideTip, hideTip) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.footerBar, footerBar) &&
            const DeepCollectionEquality()
                .equals(other.inviteUserId, inviteUserId) &&
            const DeepCollectionEquality().equals(other.imBeep, imBeep) &&
            const DeepCollectionEquality().equals(other.imHide, imHide) &&
            const DeepCollectionEquality()
                .equals(other.isInvisible, isInvisible) &&
            const DeepCollectionEquality().equals(other.totalSpam, totalSpam) &&
            const DeepCollectionEquality()
                .equals(other.lastIpAddress, lastIpAddress) &&
            const DeepCollectionEquality().equals(other.feedSort, feedSort) &&
            const DeepCollectionEquality()
                .equals(other.customGender, customGender) &&
            const DeepCollectionEquality()
                .equals(other.totalProfileLike, totalProfileLike) &&
            const DeepCollectionEquality()
                .equals(other.isVerified, isVerified) &&
            const DeepCollectionEquality()
                .equals(other.reminderDate, reminderDate) &&
            const DeepCollectionEquality()
                .equals(other.blogRating, blogRating) &&
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
                .equals(other.descriptionParsed, descriptionParsed) &&
            const DeepCollectionEquality()
                .equals(other.licenseType, licenseType) &&
            const DeepCollectionEquality().equals(other.songPath, songPath) &&
            const DeepCollectionEquality().equals(other.explicit, explicit) &&
            const DeepCollectionEquality().equals(other.duration, duration) &&
            const DeepCollectionEquality().equals(other.ordering, ordering) &&
            const DeepCollectionEquality()
                .equals(other.imageServerId, imageServerId) &&
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
            const DeepCollectionEquality().equals(other.moduleId, moduleId) &&
            const DeepCollectionEquality().equals(other.itemId, itemId) &&
            const DeepCollectionEquality()
                .equals(other.disableDownload, disableDownload) &&
            const DeepCollectionEquality().equals(other.isrc, isrc) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.isDay, isDay) &&
            const DeepCollectionEquality().equals(other.artistId, artistId) &&
            const DeepCollectionEquality().equals(other.lyrics, lyrics) &&
            const DeepCollectionEquality().equals(other.cost, cost) &&
            const DeepCollectionEquality()
                .equals(other.totalDownload, totalDownload) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality().equals(other.itunes, itunes) &&
            const DeepCollectionEquality().equals(other.amazon, amazon) &&
            const DeepCollectionEquality()
                .equals(other.googleplay, googleplay) &&
            const DeepCollectionEquality().equals(other.youtube, youtube) &&
            const DeepCollectionEquality()
                .equals(other.soundcloud, soundcloud) &&
            const DeepCollectionEquality().equals(other.imagePath, imagePath) &&
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
            const DeepCollectionEquality()
                .equals(other.peaksJsonUrl, peaksJsonUrl) &&
            const DeepCollectionEquality()
                .equals(other.titleTruncate, titleTruncate) &&
            const DeepCollectionEquality().equals(other.noPhoto, noPhoto));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(songId),
        const DeepCollectionEquality().hash(playlistId),
        const DeepCollectionEquality().hash(userId),
        const DeepCollectionEquality().hash(timeStamp),
        const DeepCollectionEquality().hash(profilePageId),
        const DeepCollectionEquality().hash(serverId),
        const DeepCollectionEquality().hash(userGroupId),
        const DeepCollectionEquality().hash(statusId),
        const DeepCollectionEquality().hash(viewId),
        const DeepCollectionEquality().hash(userName),
        const DeepCollectionEquality().hash(fullName),
        const DeepCollectionEquality().hash(password),
        const DeepCollectionEquality().hash(passwordSalt),
        const DeepCollectionEquality().hash(email),
        const DeepCollectionEquality().hash(gender),
        const DeepCollectionEquality().hash(birthday),
        const DeepCollectionEquality().hash(birthdaySearch),
        const DeepCollectionEquality().hash(countryIso),
        const DeepCollectionEquality().hash(languageId),
        const DeepCollectionEquality().hash(styleId),
        const DeepCollectionEquality().hash(timeZone),
        const DeepCollectionEquality().hash(dstCheck),
        const DeepCollectionEquality().hash(joined),
        const DeepCollectionEquality().hash(lastLogin),
        const DeepCollectionEquality().hash(lastActivity),
        const DeepCollectionEquality().hash(userImage),
        const DeepCollectionEquality().hash(hideTip),
        const DeepCollectionEquality().hash(status),
        const DeepCollectionEquality().hash(footerBar),
        const DeepCollectionEquality().hash(inviteUserId),
        const DeepCollectionEquality().hash(imBeep),
        const DeepCollectionEquality().hash(imHide),
        const DeepCollectionEquality().hash(isInvisible),
        const DeepCollectionEquality().hash(totalSpam),
        const DeepCollectionEquality().hash(lastIpAddress),
        const DeepCollectionEquality().hash(feedSort),
        const DeepCollectionEquality().hash(customGender),
        const DeepCollectionEquality().hash(totalProfileLike),
        const DeepCollectionEquality().hash(isVerified),
        const DeepCollectionEquality().hash(reminderDate),
        const DeepCollectionEquality().hash(blogRating),
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
        const DeepCollectionEquality().hash(descriptionParsed),
        const DeepCollectionEquality().hash(licenseType),
        const DeepCollectionEquality().hash(songPath),
        const DeepCollectionEquality().hash(explicit),
        const DeepCollectionEquality().hash(duration),
        const DeepCollectionEquality().hash(ordering),
        const DeepCollectionEquality().hash(imageServerId),
        const DeepCollectionEquality().hash(totalPlay),
        const DeepCollectionEquality().hash(totalView),
        const DeepCollectionEquality().hash(totalComment),
        const DeepCollectionEquality().hash(totalLike),
        const DeepCollectionEquality().hash(totalDislike),
        const DeepCollectionEquality().hash(totalScore),
        const DeepCollectionEquality().hash(totalRating),
        const DeepCollectionEquality().hash(totalAttachment),
        const DeepCollectionEquality().hash(moduleId),
        const DeepCollectionEquality().hash(itemId),
        const DeepCollectionEquality().hash(disableDownload),
        const DeepCollectionEquality().hash(isrc),
        const DeepCollectionEquality().hash(url),
        const DeepCollectionEquality().hash(isDay),
        const DeepCollectionEquality().hash(artistId),
        const DeepCollectionEquality().hash(lyrics),
        const DeepCollectionEquality().hash(cost),
        const DeepCollectionEquality().hash(totalDownload),
        const DeepCollectionEquality().hash(tags),
        const DeepCollectionEquality().hash(itunes),
        const DeepCollectionEquality().hash(amazon),
        const DeepCollectionEquality().hash(googleplay),
        const DeepCollectionEquality().hash(youtube),
        const DeepCollectionEquality().hash(soundcloud),
        const DeepCollectionEquality().hash(imagePath),
        const DeepCollectionEquality().hash(labelUser),
        const DeepCollectionEquality().hash(labelUserId),
        const DeepCollectionEquality().hash(artistUser),
        const DeepCollectionEquality().hash(artistUserId),
        const DeepCollectionEquality().hash(collabUser),
        const DeepCollectionEquality().hash(collabUserId),
        const DeepCollectionEquality().hash(peaksJsonUrl),
        const DeepCollectionEquality().hash(titleTruncate),
        const DeepCollectionEquality().hash(noPhoto)
      ]);

  @JsonKey(ignore: true)
  @override
  _$$_SongsCopyWith<_$_Songs> get copyWith =>
      __$$_SongsCopyWithImpl<_$_Songs>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SongsToJson(this);
  }
}

abstract class _Songs implements Songs {
  factory _Songs(
      {final String? id,
      final String? songId,
      final String? playlistId,
      final String? userId,
      final String? timeStamp,
      final String? profilePageId,
      final String? serverId,
      final String? userGroupId,
      final String? statusId,
      final String? viewId,
      final String? userName,
      final String? fullName,
      final String? password,
      final String? passwordSalt,
      final String? email,
      final String? gender,
      final String? birthday,
      final String? birthdaySearch,
      final String? countryIso,
      final String? languageId,
      final String? styleId,
      final dynamic timeZone,
      final String? dstCheck,
      final String? joined,
      final String? lastLogin,
      final String? lastActivity,
      final String? userImage,
      final String? hideTip,
      final dynamic status,
      final String? footerBar,
      final String? inviteUserId,
      final String? imBeep,
      final String? imHide,
      final String? isInvisible,
      final String? totalSpam,
      final String? lastIpAddress,
      final String? feedSort,
      final String? customGender,
      final String? totalProfileLike,
      final String? isVerified,
      final String? reminderDate,
      final double? blogRating,
      final String? privacy,
      final String? privacyComment,
      final String? isFree,
      final String? isFeatured,
      final String? isSponsor,
      final String? albumId,
      final String? genreId,
      final String? isDj,
      final String? title,
      final String? description,
      final String? descriptionParsed,
      final String? licenseType,
      final String? songPath,
      final String? explicit,
      final String? duration,
      final String? ordering,
      final String? imageServerId,
      final String? totalPlay,
      final String? totalView,
      final String? totalComment,
      final String? totalLike,
      final String? totalDislike,
      final String? totalScore,
      final String? totalRating,
      final String? totalAttachment,
      final int? moduleId,
      final String? itemId,
      final String? disableDownload,
      final String? isrc,
      final String? url,
      final String? isDay,
      final String? artistId,
      final String? lyrics,
      final String? cost,
      final int? totalDownload,
      final String? tags,
      final String? itunes,
      final String? amazon,
      final String? googleplay,
      final String? youtube,
      final String? soundcloud,
      final String? imagePath,
      final String? labelUser,
      final String? labelUserId,
      final String? artistUser,
      final String? artistUserId,
      final String? collabUser,
      final String? collabUserId,
      final String? peaksJsonUrl,
      final String? titleTruncate,
      final int? noPhoto}) = _$_Songs;

  factory _Songs.fromJson(Map<String, dynamic> json) = _$_Songs.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get songId => throw _privateConstructorUsedError;
  @override
  String? get playlistId => throw _privateConstructorUsedError;
  @override
  String? get userId => throw _privateConstructorUsedError;
  @override
  String? get timeStamp => throw _privateConstructorUsedError;
  @override
  String? get profilePageId => throw _privateConstructorUsedError;
  @override
  String? get serverId => throw _privateConstructorUsedError;
  @override
  String? get userGroupId => throw _privateConstructorUsedError;
  @override
  String? get statusId => throw _privateConstructorUsedError;
  @override
  String? get viewId => throw _privateConstructorUsedError;
  @override
  String? get userName => throw _privateConstructorUsedError;
  @override
  String? get fullName => throw _privateConstructorUsedError;
  @override
  String? get password => throw _privateConstructorUsedError;
  @override
  String? get passwordSalt => throw _privateConstructorUsedError;
  @override
  String? get email => throw _privateConstructorUsedError;
  @override
  String? get gender => throw _privateConstructorUsedError;
  @override
  String? get birthday => throw _privateConstructorUsedError;
  @override
  String? get birthdaySearch => throw _privateConstructorUsedError;
  @override
  String? get countryIso => throw _privateConstructorUsedError;
  @override
  String? get languageId => throw _privateConstructorUsedError;
  @override
  String? get styleId => throw _privateConstructorUsedError;
  @override
  dynamic get timeZone => throw _privateConstructorUsedError;
  @override
  String? get dstCheck => throw _privateConstructorUsedError;
  @override
  String? get joined => throw _privateConstructorUsedError;
  @override
  String? get lastLogin => throw _privateConstructorUsedError;
  @override
  String? get lastActivity => throw _privateConstructorUsedError;
  @override
  String? get userImage => throw _privateConstructorUsedError;
  @override
  String? get hideTip => throw _privateConstructorUsedError;
  @override
  dynamic get status => throw _privateConstructorUsedError;
  @override
  String? get footerBar => throw _privateConstructorUsedError;
  @override
  String? get inviteUserId => throw _privateConstructorUsedError;
  @override
  String? get imBeep => throw _privateConstructorUsedError;
  @override
  String? get imHide => throw _privateConstructorUsedError;
  @override
  String? get isInvisible => throw _privateConstructorUsedError;
  @override
  String? get totalSpam => throw _privateConstructorUsedError;
  @override
  String? get lastIpAddress => throw _privateConstructorUsedError;
  @override
  String? get feedSort => throw _privateConstructorUsedError;
  @override
  String? get customGender => throw _privateConstructorUsedError;
  @override
  String? get totalProfileLike => throw _privateConstructorUsedError;
  @override
  String? get isVerified => throw _privateConstructorUsedError;
  @override
  String? get reminderDate => throw _privateConstructorUsedError;
  @override
  double? get blogRating => throw _privateConstructorUsedError;
  @override
  String? get privacy => throw _privateConstructorUsedError;
  @override
  String? get privacyComment => throw _privateConstructorUsedError;
  @override
  String? get isFree => throw _privateConstructorUsedError;
  @override
  String? get isFeatured => throw _privateConstructorUsedError;
  @override
  String? get isSponsor => throw _privateConstructorUsedError;
  @override
  String? get albumId => throw _privateConstructorUsedError;
  @override
  String? get genreId => throw _privateConstructorUsedError;
  @override
  String? get isDj => throw _privateConstructorUsedError;
  @override
  String? get title => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  String? get descriptionParsed => throw _privateConstructorUsedError;
  @override
  String? get licenseType => throw _privateConstructorUsedError;
  @override
  String? get songPath => throw _privateConstructorUsedError;
  @override
  String? get explicit => throw _privateConstructorUsedError;
  @override
  String? get duration => throw _privateConstructorUsedError;
  @override
  String? get ordering => throw _privateConstructorUsedError;
  @override
  String? get imageServerId => throw _privateConstructorUsedError;
  @override
  String? get totalPlay => throw _privateConstructorUsedError;
  @override
  String? get totalView => throw _privateConstructorUsedError;
  @override
  String? get totalComment => throw _privateConstructorUsedError;
  @override
  String? get totalLike => throw _privateConstructorUsedError;
  @override
  String? get totalDislike => throw _privateConstructorUsedError;
  @override
  String? get totalScore => throw _privateConstructorUsedError;
  @override
  String? get totalRating => throw _privateConstructorUsedError;
  @override
  String? get totalAttachment => throw _privateConstructorUsedError;
  @override
  int? get moduleId => throw _privateConstructorUsedError;
  @override
  String? get itemId => throw _privateConstructorUsedError;
  @override
  String? get disableDownload => throw _privateConstructorUsedError;
  @override
  String? get isrc => throw _privateConstructorUsedError;
  @override
  String? get url => throw _privateConstructorUsedError;
  @override
  String? get isDay => throw _privateConstructorUsedError;
  @override
  String? get artistId => throw _privateConstructorUsedError;
  @override
  String? get lyrics => throw _privateConstructorUsedError;
  @override
  String? get cost => throw _privateConstructorUsedError;
  @override
  int? get totalDownload => throw _privateConstructorUsedError;
  @override
  String? get tags => throw _privateConstructorUsedError;
  @override
  String? get itunes => throw _privateConstructorUsedError;
  @override
  String? get amazon => throw _privateConstructorUsedError;
  @override
  String? get googleplay => throw _privateConstructorUsedError;
  @override
  String? get youtube => throw _privateConstructorUsedError;
  @override
  String? get soundcloud => throw _privateConstructorUsedError;
  @override
  String? get imagePath => throw _privateConstructorUsedError;
  @override
  String? get labelUser => throw _privateConstructorUsedError;
  @override
  String? get labelUserId => throw _privateConstructorUsedError;
  @override
  String? get artistUser => throw _privateConstructorUsedError;
  @override
  String? get artistUserId => throw _privateConstructorUsedError;
  @override
  String? get collabUser => throw _privateConstructorUsedError;
  @override
  String? get collabUserId => throw _privateConstructorUsedError;
  @override
  String? get peaksJsonUrl => throw _privateConstructorUsedError;
  @override
  String? get titleTruncate => throw _privateConstructorUsedError;
  @override
  int? get noPhoto => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SongsCopyWith<_$_Songs> get copyWith =>
      throw _privateConstructorUsedError;
}
