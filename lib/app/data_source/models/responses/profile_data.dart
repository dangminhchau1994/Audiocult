import '../../../base/index_walker.dart';

class ProfileData {
  bool? coverPhotoExists;
  String? userId;
  String? userGroupId;
  String? userName;
  String? fullName;
  String? email;
  String? gender;
  String? birthday;
  String? birthdaySearch;
  String? countryIso;
  String? languageId;
  String? timeZone;
  String? userImage;
  bool? isOnline;
  String? title;
  bool? isFriend;
  bool? isFriendOfFriend;
  bool? isFriendRequest;
  String? relationId;
  String? relationWithId;
  String? relationPhrase;
  String? coverPhoto;
  String? locationString;
  int? totalSubscriptions;
  int? totalSubscribers;
  String? biography;
  List<String>? favoriteGenresOfMusic;
  List<String>? audioArtistCategory;
  int? isSubscribed;
  String? lat;
  String? lng;
  String? currency;
  String? accessToken;

  ProfileData({
    this.coverPhotoExists,
    this.userId,
    this.userGroupId,
    this.userName,
    this.fullName,
    this.email,
    this.gender,
    this.birthday,
    this.birthdaySearch,
    this.countryIso,
    this.languageId,
    this.timeZone,
    this.userImage,
    this.isOnline,
    this.title,
    this.isFriend,
    this.isFriendOfFriend,
    this.isFriendRequest,
    this.relationId,
    this.relationWithId,
    this.relationPhrase,
    this.coverPhoto,
    this.biography,
    this.audioArtistCategory,
    this.favoriteGenresOfMusic,
    this.currency,
    this.accessToken
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);

    coverPhotoExists = iw['cover_photo_exists'].get();
    userId = iw['user_id'].get();
    accessToken = iw['access_token'].get();
    userGroupId = iw['user_group_id'].get();
    userName = iw['user_name'].get();
    fullName = iw['full_name'].get();
    email = iw['email'].get();
    gender = iw['gender'].get();
    birthday = iw['birthday'].get();
    birthdaySearch = iw['birthday_search'].get();
    countryIso = iw['country_iso'].get();
    languageId = iw['language_id'].get();
    timeZone = iw['time_zone'].get();
    userImage = iw['user_image'].get();
    isOnline = iw['is_online'].get();
    title = iw['title'].get();
    isFriend = iw['is_friend'].get();
    isFriendOfFriend = iw['is_friend_of_friend'].get();
    isFriendRequest = iw['is_friend_request'].get();
    relationId = iw['relation_id'].get();
    relationWithId = iw['relation_with_id'].get();
    relationPhrase = iw['relation_phrase'].get();
    coverPhoto = iw['cover_photo'].get();
    locationString = iw['location'].get();
    totalSubscriptions = iw['total_subscriptions'].get();
    totalSubscribers = iw['total_subscribers'].get();
    biography = iw['biography'].get();
    isSubscribed = iw['is_subscribed'].get();
    lat = iw['ac_page_lat_pin'].get();
    lng = iw['ac_page_long_pin'].get();
    favoriteGenresOfMusic =
        iw['favorite_genres_of_music'].getList(defaultValue: [], itemRawBuilder: (values) => values)?.cast<String>();
    audioArtistCategory =
        iw['audio_artist_category'].getList(defaultValue: [], itemRawBuilder: (values) => values)?.cast<String>();
    currency = iw['currency'].get();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cover_photo_exists'] = coverPhotoExists;
    data['user_id'] = userId;
    data['user_group_id'] = userGroupId;
    data['user_name'] = userName;
    data['full_name'] = fullName;
    data['email'] = email;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['birthday_search'] = birthdaySearch;
    data['country_iso'] = countryIso;
    data['language_id'] = languageId;
    data['time_zone'] = timeZone;
    data['user_image'] = userImage;
    data['is_online'] = isOnline;
    data['title'] = title;
    data['is_friend'] = isFriend;
    data['is_friend_of_friend'] = isFriendOfFriend;
    data['is_friend_request'] = isFriendRequest;
    data['relation_id'] = relationId;
    data['relation_with_id'] = relationWithId;
    data['relation_phrase'] = relationPhrase;
    data['cover_photo'] = coverPhoto;
    data['location'] = locationString;
    data['total_subscriptions'] = totalSubscriptions;
    data['total_subscribers'] = totalSubscribers;
    data['biography'] = biography;
    return data;
  }
}
