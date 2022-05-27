import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';

import '../../../../base/index_walker.dart';

class Song {
  String? userId;
  String? artistTitle;
  String? albumName;
  String? songId;
  String? viewId;
  String? privacy;
  String? privacyComment;
  bool? isFree;
  String? isFeatured;
  String? isSponsor;
  String? albumId;
  String? genreId;
  String? isDj;
  String? title;
  String? description;
  String? licenseType;
  String? songPath;
  String? explicit;
  String? duration;
  String? totalPlay;
  String? totalView;
  String? totalComment;
  String? totalLike;
  String? totalDislike;
  String? totalScore;
  String? totalRating;
  String? totalAttachment;
  String? timeStamp;
  String? lyrics;
  String? cost;
  String? totalDownload;
  String? tags;
  String? imagePath;
  ProfileData? artistUser;
  ProfileData? labelUser;
  ProfileData? collabUser;
  String? peaksJsonUrl;
  int? noPhoto;
  String? genreName;
  String? image400;

  Song({
    this.userId,
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
    this.timeStamp,
    this.lyrics,
    this.cost,
    this.totalDownload,
    this.tags,
    this.imagePath,
    this.artistUser,
    this.peaksJsonUrl,
    this.noPhoto,
  });

  Song.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    userId = iw['user_id'].get();
    artistTitle = iw['artist_title'].get();
    albumName = iw['album_name'].get();
    songId = iw['song_id'].get();
    viewId = iw['view_id'].get();
    privacy = iw['privacy'].get();
    privacyComment = iw['privacy_comment'].get();
    isFree = iw['is_free'].get() == '1';
    isFeatured = iw['is_featured'].get();
    isSponsor = iw['is_sponsor'].get();
    albumId = iw['album_id'].get();
    genreId = iw['genre_id'].get();
    isDj = iw['is_dj'].get();
    title = iw['title'].get();
    description = iw['description'].get();
    licenseType = iw['license_type'].get();
    songPath = iw['song_path'].get();
    explicit = iw['explicit'].get();
    duration = iw['duration'].get();
    totalPlay = iw['total_play'].get();
    totalView = iw['total_view'].get();
    totalComment = iw['total_comment'].get();
    totalLike = iw['total_like'].get();
    totalDislike = iw['total_dislike'].get();
    totalScore = iw['total_score'].get();
    totalRating = iw['total_rating'].get();
    totalAttachment = iw['total_attachment'].get();
    timeStamp = iw['time_stamp'].get();
    lyrics = iw['lyrics'].get();
    cost = iw['cost'].get();
    totalDownload = iw['total_download'].get();
    tags = iw['tags'].get();
    imagePath = iw['image_path'].get();
    artistUser = iw['artist_user'].get(rawBuilder: (values) => ProfileData.fromJson(values as Map<String, dynamic>));
    collabUser = iw['collab_user'].get(rawBuilder: (values) => ProfileData.fromJson(values as Map<String, dynamic>));
    labelUser = iw['label_user'].get(rawBuilder: (values) => ProfileData.fromJson(values as Map<String, dynamic>));
    peaksJsonUrl = iw['peaks_json_url'].get();
    noPhoto = iw['no_photo'].get();
    genreName = iw['genre_name'].get();
    image400 = iw['image_path_400'].get();
  }
}
