import '../../../base/index_walker.dart';

class Video {
  String? userId;
  String? userServerId;
  String? userName;
  String? fullName;
  String? userImage;
  String? userGroupId;
  String? videoId;
  String? isFeatured;
  String? viewId;
  String? itemId;
  String? privacy;
  String? title;
  String? imagePath;
  String? totalComment;
  String? totalLike;
  String? totalScore;
  String? totalRating;
  String? timeStamp;
  String? totalView;

  Video(
      {this.userId,
      this.userServerId,
      this.userName,
      this.fullName,
      this.userImage,
      this.userGroupId,
      this.videoId,
      this.isFeatured,
      this.viewId,
      this.itemId,
      this.privacy,
      this.title,
      this.imagePath,
      this.totalComment,
      this.totalLike,
      this.totalScore,
      this.totalRating,
      this.timeStamp,
      this.totalView});

  Video.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);

    userId = iw['user_id'].get();
    userServerId = iw['user_server_id'].get();
    userName = iw['user_name'].get();
    fullName = iw['full_name'].get();
    userImage = iw['user_image'].get();
    userGroupId = iw['user_group_id'].get();
    videoId = iw['video_id'].get();
    isFeatured = iw['is_featured'].get();
    viewId = iw['view_id'].get();
    itemId = iw['item_id'].get();
    privacy = iw['privacy'].get();
    title = iw['title'].get();
    imagePath = iw['image_path'].get();
    totalComment = iw['total_comment'].get();
    totalLike = iw['total_like'].get();
    totalScore = iw['total_score'].get();
    totalRating = iw['total_rating'].get();
    timeStamp = iw['time_stamp'].get();
    totalView = iw['total_view'].get();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_server_id'] = userServerId;
    data['user_name'] = userName;
    data['full_name'] = fullName;
    data['user_image'] = userImage;
    data['user_group_id'] = userGroupId;
    data['video_id'] = videoId;
    data['is_featured'] = isFeatured;
    data['view_id'] = viewId;
    data['item_id'] = itemId;
    data['privacy'] = privacy;
    data['title'] = title;
    data['image_path'] = imagePath;
    data['total_comment'] = totalComment;
    data['total_like'] = totalLike;
    data['total_score'] = totalScore;
    data['total_rating'] = totalRating;
    data['time_stamp'] = timeStamp;
    data['total_view'] = totalView;
    return data;
  }
}
