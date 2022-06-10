import 'package:audio_cult/app/base/index_walker.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/widgets.dart';

class UniversalSearchItem {
  String? itemId;
  String? itemTitle;
  String? itemTimedStamp;
  String? itemUseId;
  String? itemTypeId;
  String? itemPhoto;
  String? itemPhotoServer;
  String? userImage;
  String? itemLink;
  String? itemName;
  String? itemDisplayPhoto;

  UniversalSearchItem.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    itemId = iw['item_id'].get();
    itemTitle = iw['item_title'].get();
    itemTimedStamp = iw['item_time_stamp'].get();
    itemUseId = iw['item_user_id'].get();
    itemTypeId = iw['item_type_id'].get();
    itemPhoto = iw['item_photo'].get();
    itemPhotoServer = iw['item_photo_server'].get();
    userImage = iw['user_image'].get();
    itemLink = iw['item_link'].get();
    itemName = iw['item_name'].get();
    itemDisplayPhoto = iw['item_display_photo'].get();
  }
}

enum UniversalSearchView { all, video, event, song, photo, rssfeed, page }

extension UniversalSearchViewExtension on UniversalSearchView {
  String? get value {
    switch (this) {
      case UniversalSearchView.all:
        return null;
      case UniversalSearchView.video:
        return 'v';
      case UniversalSearchView.event:
        return 'event';
      case UniversalSearchView.song:
        return 'music';
      case UniversalSearchView.photo:
        return 'photo';
      case UniversalSearchView.rssfeed:
        return 'rssfeed';
      case UniversalSearchView.page:
        return 'user';
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case UniversalSearchView.all:
        return context.l10n.t_all;
      case UniversalSearchView.video:
        return context.l10n.t_videos;
      case UniversalSearchView.event:
        return context.l10n.t_events;
      case UniversalSearchView.song:
        return context.l10n.t_songs;
      case UniversalSearchView.photo:
        return context.l10n.t_photos;
      case UniversalSearchView.rssfeed:
        return context.l10n.t_rssfeed;
      case UniversalSearchView.page:
        return context.l10n.t_pages;
    }
  }

  int get index {
    switch (this) {
      case UniversalSearchView.all:
        return 0;
      case UniversalSearchView.video:
        return 1;
      case UniversalSearchView.event:
        return 2;
      case UniversalSearchView.song:
        return 3;
      case UniversalSearchView.photo:
        return 4;
      case UniversalSearchView.rssfeed:
        return 5;
      case UniversalSearchView.page:
        return 6;
    }
  }

  static UniversalSearchView init(int value) {
    switch (value) {
      case 0:
        return UniversalSearchView.all;
      case 1:
        return UniversalSearchView.video;
      case 2:
        return UniversalSearchView.event;
      case 3:
        return UniversalSearchView.song;
      case 4:
        return UniversalSearchView.photo;
      case 5:
        return UniversalSearchView.rssfeed;
      case 6:
        return UniversalSearchView.page;
      default:
        return UniversalSearchView.all;
    }
  }

  static UniversalSearchView initWithType(String typeId) {
    switch (typeId) {
      case 'v':
        return UniversalSearchView.video;
      case 'event':
        return UniversalSearchView.event;
      case 'music_album':
      case 'music':
        return UniversalSearchView.song;
      case 'photo':
        return UniversalSearchView.photo;
      case 'rssfeed':
        return UniversalSearchView.rssfeed;
      case 'user':
        return UniversalSearchView.page;
      default:
        return UniversalSearchView.all;
    }
  }

  static int total = 7;
}
