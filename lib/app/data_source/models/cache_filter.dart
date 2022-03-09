import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';

class CacheFilter {
  List<SelectMenuModel>? mostLiked;
  List<SelectMenuModel>? allTime;
  List<Genre>? genres;
  CacheFilter({this.mostLiked, this.allTime, this.genres});

  dynamic toDynamic() {
    final data = {};
    data['most_liked'] = mostLiked?.map((e) => {'id': e.id, 'title': e.title, 'isSelected': e.isSelected}).toList();
    data['all_time'] = allTime?.map((e) => {'id': e.id, 'title': e.title, 'isSelected': e.isSelected}).toList();
    data['genres'] = genres?.map((e) => {'id': e.genreId, 'title': e.name, 'isSelected': e.isSelected}).toList();
    return data;
  }
}
