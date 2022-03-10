import '../../../base/index_walker.dart';

class Genre {
  String? genreId;
  String? name;
  String? link;
  bool? isSelected;

  Genre({this.genreId, this.name, this.link, this.isSelected = false});

  Genre.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);

    genreId = iw['genre_id'].get();
    name = iw['name'].get();
    link = iw['link'].get();
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['genre_id'] = genreId;
    data['name'] = name;
    data['link'] = link;
    data['isSelected'] = isSelected;
    return data;
  }
}
