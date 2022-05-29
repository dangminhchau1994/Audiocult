import 'package:audio_cult/app/features/universal_search/universal_search_widget/search_result_post_list_widget.dart';
import 'package:flutter/material.dart';

class UniversalSearchPostScreen extends StatefulWidget {
  const UniversalSearchPostScreen({Key? key}) : super(key: key);

  @override
  State<UniversalSearchPostScreen> createState() => UniversalSearchPostScreenState();
}

class UniversalSearchPostScreenState extends State<UniversalSearchPostScreen> {
  @override
  Widget build(BuildContext context) {
    return SearchResultPostListWidget();
  }
}
