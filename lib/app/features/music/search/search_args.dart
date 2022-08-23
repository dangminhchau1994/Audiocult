import 'package:audio_cult/app/features/music/search/search_screen.dart';

class SearchArgs {
  final SearchType? searchType;
  final String? genreID;
  final String? tag;

  SearchArgs({
    this.searchType,
    this.genreID,
    this.tag,
  });
}
