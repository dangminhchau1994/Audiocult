import 'package:audio_cult/app/data_source/local/hive_box_name.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/atlas_category.dart';
import 'package:audio_cult/app/data_source/models/responses/country_response.dart';
import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/cache_filter.dart';
import '../models/responses/reaction_icon/reaction_icon_response.dart';

class HiveServiceProvider {
  HiveServiceProvider();

  void saveAlbums(List<dynamic> result) async {
    await Hive.box(HiveBoxName.cache).put(HiveBoxKey.albumBox, result);
  }

  List<Album> getAlbum() {
    final result = Hive.box(HiveBoxName.cache).get(HiveBoxKey.albumBox) as List;
    return result.map((e) => Album.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  void saveProfile(dynamic profile) async {
    await Hive.box(HiveBoxName.userProfileBox).put(HiveBoxKey.profile, profile);
  }

  void clearProfile() async {
    await Hive.box(HiveBoxName.userProfileBox).clear();
  }

  ProfileData? getProfile() {
    final result = Hive.box(HiveBoxName.userProfileBox).get(HiveBoxKey.profile, defaultValue: null);
    return ProfileData.fromJson(Map<String, dynamic>.from(result as Map));
  }

  void saveGenres(List<dynamic> result) async {
    await Hive.box(HiveBoxName.cache).put(HiveBoxKey.genresBox, result);
  }

  List<Genre> getGenres() {
    final result = Hive.box(HiveBoxName.cache).get(HiveBoxKey.genresBox, defaultValue: []) as List;
    return result.map((e) => Genre.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  void saveCountries(List<Country> countries) async {
    await Hive.box(HiveBoxName.cache).put(HiveBoxKey.countries, countries);
  }

  void saveReactions(List<dynamic> reactions) async {
    await Hive.box(HiveBoxName.cache).put(HiveBoxKey.reactions, reactions);
  }

  List<ReactionIconResponse> getReactions() {
    final result = Hive.box(HiveBoxName.cache).get(HiveBoxKey.reactions, defaultValue: []) as List;
    return result.map((e) => ReactionIconResponse.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  List<Country> getCachedCountries() {
    final result = Hive.box(HiveBoxName.cache).get(HiveBoxKey.countries, defaultValue: []) as List;
    return result.map((e) => Country.fromJson(e as Map<String, dynamic>)).toList();
  }

  void saveCategories(List<AtlasCategory> categories) async {
    await Hive.box(HiveBoxName.cache).get(HiveBoxKey.categories, defaultValue: []) as List;
  }

  List<AtlasCategory> getCachedCategories() {
    final result = Hive.box(HiveBoxName.cache).get(HiveBoxKey.categories, defaultValue: []) as List;
    return result.map((e) => AtlasCategory.fromJson(e as Map<String, dynamic>)).toList();
  }

  CacheFilter? getCacheFilter(String? key) {
    try {
      final result = Hive.box(HiveBoxName.cache).get(key ?? HiveBoxKey.cacheFilter, defaultValue: null);
      if (result == null) {
        return null;
      }
      final mostLiked = result['most_liked'] != null ? result['most_liked'] as List : [];
      final allTime = result['all_time'] != null ? result['all_time'] as List : [];
      final genres = result['genres'] != null ? result['genres'] as List : [];
      final cacheFilter = CacheFilter(mostLiked: [], allTime: [], genres: []);
      cacheFilter.mostLiked = mostLiked
          .map(
            (e) =>
                SelectMenuModel(id: e['id'] as int, title: e['title'] as String, isSelected: e['isSelected'] as bool),
          )
          .toList();
      cacheFilter.allTime = allTime
          .map(
            (e) =>
                SelectMenuModel(id: e['id'] as int, title: e['title'] as String, isSelected: e['isSelected'] as bool),
          )
          .toList();

      cacheFilter.genres = genres
          .map(
            (e) => Genre(genreId: e['id'] as String, name: e['title'] as String, isSelected: e['isSelected'] as bool),
          )
          .toList();
      return cacheFilter;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void saveCacheFilter(String? key, CacheFilter cacheFilter) async {
    await Hive.box(HiveBoxName.cache).put(key ?? HiveBoxKey.cacheFilter, cacheFilter.toDynamic());
  }

  Future clearFilter() async {
    await Hive.box(HiveBoxName.cache).delete(HiveBoxKey.cacheFilter);
  }
}
