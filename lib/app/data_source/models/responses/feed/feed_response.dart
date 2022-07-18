import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'feed_response.g.dart';

enum FeedType {
  video,
  photo,
  userStatus,
  advancedSong,
  advancedEvent,
  userCover,
  userPhoto,
  none,
}

enum FeedPrivacy {
  everyone,
  subscriptions,
  friend,
  onlyme,
  none,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LocationLatlng {
  double? latitude;
  double? longitude;

  LocationLatlng({this.latitude, this.longitude});

  factory LocationLatlng.fromJson(Map<String, dynamic> json) => _$LocationLatlngFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FeedResponse {
  String? feedId;
  String? appId;
  String? privacy;
  String? privacyComment;
  String? typeId;
  String? userId;
  String? parentUserId;
  String? itemId;
  String? timeStamp;
  String? feedReference;
  String? parentFeedId;
  String? parentModuleId;
  String? timeUpdate;
  String? content;
  String? totalView;
  String? profilePageId;
  String? userServerId;
  String? userName;
  String? locationName;
  String? fullName;
  String? gender;
  String? userImage;
  String? isInvisible;
  String? userGroupId;
  String? languageId;
  String? lastActivity;
  String? birthday;
  String? countryIso;
  String? feedTimeStamp;
  int? sponsorFeedId;
  bool? canPostComment;
  String? feedTitle;
  String? feedInfo;
  String? feedLink;
  String? feedIcon;
  dynamic feedTotalLike;
  //bool? feedIsLiked;
  bool? enableLike;
  String? likeTypeId;
  String? totalComment;
  CustomDataCache? customDataCache;
  String? feedCustomHtml;
  String? embedCode;
  //List<Null>? likes;
  bool? bShowEnterCommentBlock;
  bool? canLike;
  bool? canComment;
  bool? canShare;
  int? totalAction;
  String? sContent;
  String? statusBackground;
  String? privacyIconClass;
  String? feedMonthYear;
  String? likeItemId;
  int? totalLikes;
  String? feedLikePhrase;
  String? serverId;
  String? feedStatus;
  String? feedContent;
  String? commentTypeId;
  String? totalFriendsTagged;
  int? totalImage;
  List<String>? apiFeedImage;
  List<String>? feedImageUrl;
  List<ProfileData>? friendsTagged;
  String? customCss;
  String? customRel;
  String? customJs;
  bool? noTargetBlank;
  LastIcon? lastIcon;
  LocationLatlng? locationLatlng;

   FeedResponse({
    this.feedId,
    this.appId,
    this.privacy,
    this.privacyComment,
    this.typeId,
    this.userId,
    this.parentUserId,
    this.itemId,
    this.timeStamp,
    this.friendsTagged,
    this.lastIcon,
    this.feedReference,
    this.locationLatlng,
    this.parentFeedId,
    this.parentModuleId,
    this.timeUpdate,
    this.content,
    this.totalView,
    this.profilePageId,
    this.userServerId,
    this.userName,
    this.fullName,
    this.gender,
    this.userImage,
    this.isInvisible,
    this.locationName,
    this.feedContent,
    this.userGroupId,
    this.languageId,
    this.lastActivity,
    this.birthday,
    this.countryIso,
    this.feedTimeStamp,
    this.sponsorFeedId,
    this.canPostComment,
    this.feedTitle,
    this.feedInfo,
    this.feedLink,
    this.embedCode,
    this.feedIcon,
    this.feedTotalLike,
    //this.feedIsLiked,
    this.enableLike,
    this.likeTypeId,
    this.totalComment,
    this.customDataCache,
    this.feedCustomHtml,
    //this.likes,
    this.bShowEnterCommentBlock,
    this.canLike,
    this.canComment,
    this.canShare,
    this.totalAction,
    this.sContent,
    this.statusBackground,
    this.privacyIconClass,
    this.feedMonthYear,
    this.likeItemId,
    this.totalLikes,
    this.feedLikePhrase,
    this.serverId,
    this.feedStatus,
    this.commentTypeId,
    this.totalFriendsTagged,
    this.totalImage,
    this.apiFeedImage,
    this.feedImageUrl,
    this.customCss,
    this.customRel,
    this.customJs,
    this.noTargetBlank,
  });

  FeedType getFeedType() {
    switch (typeId) {
      case 'v':
        return FeedType.video;
      case 'photo':
        return FeedType.photo;
      case 'user_status':
        return FeedType.userStatus;
      case 'advancedmusic_song':
        return FeedType.advancedSong;
      case 'advancedevent':
        return FeedType.advancedEvent;
      case 'user_cover':
        return FeedType.userCover;
      case 'user_photo':
        return FeedType.userPhoto;
      default:
        return FeedType.none;
    }
  }

  FeedPrivacy getFeedPrivacy() {
    switch (privacy) {
      case '0':
        return FeedPrivacy.everyone;
      case '1':
        return FeedPrivacy.subscriptions;
      case '2':
        return FeedPrivacy.friend;
      case '3':
        return FeedPrivacy.onlyme;
      default:
        return FeedPrivacy.none;
    }
  }

  factory FeedResponse.fromJson(Map<String, dynamic> json) => _$FeedResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LastIcon {
  String? likeTypeId;
  String? imagePath;
  String? countIcon;

  LastIcon({this.likeTypeId, this.imagePath, this.countIcon});

  factory LastIcon.fromJson(Map<String, dynamic> json) => _$LastIconFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CustomDataCache {
  String? userId;
  String? profilePageId;
  String? serverId;
  String? userName;
  String? fullName;
  String? gender;
  String? songId;
  String? userImage;
  String? isInvisible;
  String? userGroupId;
  String? languageId;
  String? lastActivity;
  String? birthday;
  String? countryIso;
  String? startTime;
  String? endTime;
  String? eventId;
  String? moduleId;
  String? itemId;
  String? title;
  String? timeStamp;
  String? imagePath;
  String? totalLike;
  String? totalComment;
  String? location;
  String? privacy;
  String? privacyComment;
  String? viewId;
  String? isSponsor;
  dynamic descriptionParsed;
  dynamic isLiked;
  bool? isOnFeed;
  String? parentUserId;
  dynamic videoUrl;
  dynamic text;
  dynamic videoTotalView;
  dynamic parentProfilePageId;
  dynamic userParentServerId;
  dynamic parentUserName;
  dynamic parentFullName;
  dynamic parentGender;
  dynamic parentUserImage;
  dynamic parentIsInvisible;
  dynamic parentUserGroupId;
  dynamic parentLanguageId;
  dynamic parentLastActivity;
  dynamic parentBirthday;
  dynamic parentCountryIso;
  String? photoId;
  String? albumId;
  String? groupId;
  String? typeId;
  String? destination;
  String? mature;
  String? allowComment;
  String? allowRate;
  String? totalView;
  String? totalDownload;
  String? totalRating;
  String? totalVote;
  String? totalBattle;
  String? totalDislike;
  String? totalPlay;
  String? isFeatured;
  String? isCover;
  String? allowDownload;
  String? ordering;
  String? isProfilePhoto;
  String? isDay;
  String? tags;
  String? isCoverPhoto;
  String? isTemp;
  String? description;
  // Null? locationLatlng;
  // Null? locationName;
  // Null? extraPhotoId;
  String? name;
  String? timelineId;

  CustomDataCache(
      {this.userId,
      this.profilePageId,
      this.serverId,
      this.userName,
      this.fullName,
      this.text,
      this.videoTotalView,
      this.gender,
      this.userImage,
      this.isInvisible,
      this.userGroupId,
      this.languageId,
      this.lastActivity,
      this.birthday,
      this.totalPlay,
      this.countryIso,
      this.startTime,
      this.videoUrl,
      this.endTime,
      this.eventId,
      this.moduleId,
      this.itemId,
      this.title,
      this.timeStamp,
      this.imagePath,
      this.totalLike,
      this.totalComment,
      this.songId,
      this.location,
      this.privacy,
      this.privacyComment,
      this.viewId,
      this.isSponsor,
      this.descriptionParsed,
      this.isLiked,
      this.isOnFeed,
      this.parentUserId,
      this.parentProfilePageId,
      this.userParentServerId,
      this.parentUserName,
      this.parentFullName,
      this.parentGender,
      this.parentUserImage,
      this.parentIsInvisible,
      this.parentUserGroupId,
      this.parentLanguageId,
      this.parentLastActivity,
      this.parentBirthday,
      this.parentCountryIso,
      this.photoId,
      this.albumId,
      this.groupId,
      this.typeId,
      this.destination,
      this.mature,
      this.allowComment,
      this.allowRate,
      this.totalView,
      this.totalDownload,
      this.totalRating,
      this.totalVote,
      this.totalBattle,
      this.totalDislike,
      this.isFeatured,
      this.isCover,
      this.allowDownload,
      this.ordering,
      this.isProfilePhoto,
      this.isDay,
      this.tags,
      this.isCoverPhoto,
      this.isTemp,
      this.description,
      // this.locationLatlng,
      // this.locationName,
      // this.extraPhotoId,
      this.name,
      this.timelineId});

  factory CustomDataCache.fromJson(Map<String, dynamic> json) => _$CustomDataCacheFromJson(json);
}
