// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedResponse _$FeedResponseFromJson(Map<String, dynamic> json) => FeedResponse(
      feedId: json['feed_id'] as String?,
      appId: json['app_id'] as String?,
      privacy: json['privacy'] as String?,
      privacyComment: json['privacy_comment'] as String?,
      typeId: json['type_id'] as String?,
      userId: json['user_id'] as String?,
      parentUserId: json['parent_user_id'] as String?,
      itemId: json['item_id'] as String?,
      timeStamp: json['time_stamp'] as String?,
      feedReference: json['feed_reference'] as String?,
      parentFeedId: json['parent_feed_id'] as String?,
      parentModuleId: json['parent_module_id'] as String?,
      timeUpdate: json['time_update'] as String?,
      content: json['content'] as String?,
      totalView: json['total_view'] as String?,
      profilePageId: json['profile_page_id'] as String?,
      userServerId: json['user_server_id'] as String?,
      userName: json['user_name'] as String?,
      fullName: json['full_name'] as String?,
      gender: json['gender'] as String?,
      userImage: json['user_image'] as String?,
      isInvisible: json['is_invisible'] as String?,
      userGroupId: json['user_group_id'] as String?,
      languageId: json['language_id'] as String?,
      lastActivity: json['last_activity'] as String?,
      birthday: json['birthday'] as String?,
      countryIso: json['country_iso'] as String?,
      feedTimeStamp: json['feed_time_stamp'] as String?,
      sponsorFeedId: json['sponsor_feed_id'] as int?,
      canPostComment: json['can_post_comment'] as bool?,
      feedTitle: json['feed_title'] as String?,
      feedInfo: json['feed_info'] as String?,
      feedLink: json['feed_link'] as String?,
      embedCode: json['embed_code'] as String?,
      feedIcon: json['feed_icon'] as String?,
      feedTotalLike: json['feed_total_like'],
      enableLike: json['enable_like'] as bool?,
      likeTypeId: json['like_type_id'] as String?,
      totalComment: json['total_comment'] as String?,
      customDataCache: json['custom_data_cache'] == null
          ? null
          : CustomDataCache.fromJson(
              json['custom_data_cache'] as Map<String, dynamic>),
      feedCustomHtml: json['feed_custom_html'] as String?,
      bShowEnterCommentBlock: json['b_show_enter_comment_block'] as bool?,
      canLike: json['can_like'] as bool?,
      canComment: json['can_comment'] as bool?,
      canShare: json['can_share'] as bool?,
      totalAction: json['total_action'] as int?,
      sContent: json['s_content'] as String?,
      statusBackground: json['status_background'] as String?,
      privacyIconClass: json['privacy_icon_class'] as String?,
      feedMonthYear: json['feed_month_year'] as String?,
      likeItemId: json['like_item_id'] as String?,
      totalLikes: json['total_likes'] as int?,
      feedLikePhrase: json['feed_like_phrase'] as String?,
      serverId: json['server_id'] as String?,
      feedStatus: json['feed_status'] as String?,
      commentTypeId: json['comment_type_id'] as String?,
      totalFriendsTagged: json['total_friends_tagged'] as String?,
      totalImage: json['total_image'] as int?,
      apiFeedImage: (json['api_feed_image'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      feedImageUrl: (json['feed_image_url'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      customCss: json['custom_css'] as String?,
      customRel: json['custom_rel'] as String?,
      customJs: json['custom_js'] as String?,
      noTargetBlank: json['no_target_blank'] as bool?,
    );

Map<String, dynamic> _$FeedResponseToJson(FeedResponse instance) =>
    <String, dynamic>{
      'feed_id': instance.feedId,
      'app_id': instance.appId,
      'privacy': instance.privacy,
      'privacy_comment': instance.privacyComment,
      'type_id': instance.typeId,
      'user_id': instance.userId,
      'parent_user_id': instance.parentUserId,
      'item_id': instance.itemId,
      'time_stamp': instance.timeStamp,
      'feed_reference': instance.feedReference,
      'parent_feed_id': instance.parentFeedId,
      'parent_module_id': instance.parentModuleId,
      'time_update': instance.timeUpdate,
      'content': instance.content,
      'total_view': instance.totalView,
      'profile_page_id': instance.profilePageId,
      'user_server_id': instance.userServerId,
      'user_name': instance.userName,
      'full_name': instance.fullName,
      'gender': instance.gender,
      'user_image': instance.userImage,
      'is_invisible': instance.isInvisible,
      'user_group_id': instance.userGroupId,
      'language_id': instance.languageId,
      'last_activity': instance.lastActivity,
      'birthday': instance.birthday,
      'country_iso': instance.countryIso,
      'feed_time_stamp': instance.feedTimeStamp,
      'sponsor_feed_id': instance.sponsorFeedId,
      'can_post_comment': instance.canPostComment,
      'feed_title': instance.feedTitle,
      'feed_info': instance.feedInfo,
      'feed_link': instance.feedLink,
      'feed_icon': instance.feedIcon,
      'feed_total_like': instance.feedTotalLike,
      'enable_like': instance.enableLike,
      'like_type_id': instance.likeTypeId,
      'total_comment': instance.totalComment,
      'custom_data_cache': instance.customDataCache,
      'feed_custom_html': instance.feedCustomHtml,
      'embed_code': instance.embedCode,
      'b_show_enter_comment_block': instance.bShowEnterCommentBlock,
      'can_like': instance.canLike,
      'can_comment': instance.canComment,
      'can_share': instance.canShare,
      'total_action': instance.totalAction,
      's_content': instance.sContent,
      'status_background': instance.statusBackground,
      'privacy_icon_class': instance.privacyIconClass,
      'feed_month_year': instance.feedMonthYear,
      'like_item_id': instance.likeItemId,
      'total_likes': instance.totalLikes,
      'feed_like_phrase': instance.feedLikePhrase,
      'server_id': instance.serverId,
      'feed_status': instance.feedStatus,
      'comment_type_id': instance.commentTypeId,
      'total_friends_tagged': instance.totalFriendsTagged,
      'total_image': instance.totalImage,
      'api_feed_image': instance.apiFeedImage,
      'feed_image_url': instance.feedImageUrl,
      'custom_css': instance.customCss,
      'custom_rel': instance.customRel,
      'custom_js': instance.customJs,
      'no_target_blank': instance.noTargetBlank,
    };

CustomDataCache _$CustomDataCacheFromJson(Map<String, dynamic> json) =>
    CustomDataCache(
      userId: json['user_id'] as String?,
      profilePageId: json['profile_page_id'] as String?,
      serverId: json['server_id'] as String?,
      userName: json['user_name'] as String?,
      fullName: json['full_name'] as String?,
      gender: json['gender'] as String?,
      userImage: json['user_image'] as String?,
      isInvisible: json['is_invisible'] as String?,
      userGroupId: json['user_group_id'] as String?,
      languageId: json['language_id'] as String?,
      lastActivity: json['last_activity'] as String?,
      birthday: json['birthday'] as String?,
      totalPlay: json['total_play'] as String?,
      countryIso: json['country_iso'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      eventId: json['event_id'] as String?,
      moduleId: json['module_id'] as String?,
      itemId: json['item_id'] as String?,
      title: json['title'] as String?,
      timeStamp: json['time_stamp'] as String?,
      imagePath: json['image_path'] as String?,
      totalLike: json['total_like'] as String?,
      totalComment: json['total_comment'] as String?,
      songId: json['song_id'] as String?,
      location: json['location'] as String?,
      privacy: json['privacy'] as String?,
      privacyComment: json['privacy_comment'] as String?,
      viewId: json['view_id'] as String?,
      isSponsor: json['is_sponsor'] as String?,
      descriptionParsed: json['description_parsed'],
      isLiked: json['is_liked'],
      isOnFeed: json['is_on_feed'] as bool?,
      parentUserId: json['parent_user_id'] as String?,
      parentProfilePageId: json['parent_profile_page_id'],
      userParentServerId: json['user_parent_server_id'],
      parentUserName: json['parent_user_name'],
      parentFullName: json['parent_full_name'],
      parentGender: json['parent_gender'],
      parentUserImage: json['parent_user_image'],
      parentIsInvisible: json['parent_is_invisible'],
      parentUserGroupId: json['parent_user_group_id'],
      parentLanguageId: json['parent_language_id'],
      parentLastActivity: json['parent_last_activity'],
      parentBirthday: json['parent_birthday'],
      parentCountryIso: json['parent_country_iso'],
      photoId: json['photo_id'] as String?,
      albumId: json['album_id'] as String?,
      groupId: json['group_id'] as String?,
      typeId: json['type_id'] as String?,
      destination: json['destination'] as String?,
      mature: json['mature'] as String?,
      allowComment: json['allow_comment'] as String?,
      allowRate: json['allow_rate'] as String?,
      totalView: json['total_view'] as String?,
      totalDownload: json['total_download'] as String?,
      totalRating: json['total_rating'] as String?,
      totalVote: json['total_vote'] as String?,
      totalBattle: json['total_battle'] as String?,
      totalDislike: json['total_dislike'] as String?,
      isFeatured: json['is_featured'] as String?,
      isCover: json['is_cover'] as String?,
      allowDownload: json['allow_download'] as String?,
      ordering: json['ordering'] as String?,
      isProfilePhoto: json['is_profile_photo'] as String?,
      isDay: json['is_day'] as String?,
      tags: json['tags'] as String?,
      isCoverPhoto: json['is_cover_photo'] as String?,
      isTemp: json['is_temp'] as String?,
      description: json['description'] as String?,
      name: json['name'] as String?,
      timelineId: json['timeline_id'] as String?,
    );

Map<String, dynamic> _$CustomDataCacheToJson(CustomDataCache instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'profile_page_id': instance.profilePageId,
      'server_id': instance.serverId,
      'user_name': instance.userName,
      'full_name': instance.fullName,
      'gender': instance.gender,
      'song_id': instance.songId,
      'user_image': instance.userImage,
      'is_invisible': instance.isInvisible,
      'user_group_id': instance.userGroupId,
      'language_id': instance.languageId,
      'last_activity': instance.lastActivity,
      'birthday': instance.birthday,
      'country_iso': instance.countryIso,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'event_id': instance.eventId,
      'module_id': instance.moduleId,
      'item_id': instance.itemId,
      'title': instance.title,
      'time_stamp': instance.timeStamp,
      'image_path': instance.imagePath,
      'total_like': instance.totalLike,
      'total_comment': instance.totalComment,
      'location': instance.location,
      'privacy': instance.privacy,
      'privacy_comment': instance.privacyComment,
      'view_id': instance.viewId,
      'is_sponsor': instance.isSponsor,
      'description_parsed': instance.descriptionParsed,
      'is_liked': instance.isLiked,
      'is_on_feed': instance.isOnFeed,
      'parent_user_id': instance.parentUserId,
      'parent_profile_page_id': instance.parentProfilePageId,
      'user_parent_server_id': instance.userParentServerId,
      'parent_user_name': instance.parentUserName,
      'parent_full_name': instance.parentFullName,
      'parent_gender': instance.parentGender,
      'parent_user_image': instance.parentUserImage,
      'parent_is_invisible': instance.parentIsInvisible,
      'parent_user_group_id': instance.parentUserGroupId,
      'parent_language_id': instance.parentLanguageId,
      'parent_last_activity': instance.parentLastActivity,
      'parent_birthday': instance.parentBirthday,
      'parent_country_iso': instance.parentCountryIso,
      'photo_id': instance.photoId,
      'album_id': instance.albumId,
      'group_id': instance.groupId,
      'type_id': instance.typeId,
      'destination': instance.destination,
      'mature': instance.mature,
      'allow_comment': instance.allowComment,
      'allow_rate': instance.allowRate,
      'total_view': instance.totalView,
      'total_download': instance.totalDownload,
      'total_rating': instance.totalRating,
      'total_vote': instance.totalVote,
      'total_battle': instance.totalBattle,
      'total_dislike': instance.totalDislike,
      'total_play': instance.totalPlay,
      'is_featured': instance.isFeatured,
      'is_cover': instance.isCover,
      'allow_download': instance.allowDownload,
      'ordering': instance.ordering,
      'is_profile_photo': instance.isProfilePhoto,
      'is_day': instance.isDay,
      'tags': instance.tags,
      'is_cover_photo': instance.isCoverPhoto,
      'is_temp': instance.isTemp,
      'description': instance.description,
      'name': instance.name,
      'timeline_id': instance.timelineId,
    };
