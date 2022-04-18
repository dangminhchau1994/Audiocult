import 'package:audio_cult/app/features/profile/my_sliver_appbar.dart';
import 'package:audio_cult/app/features/profile/pages/about_page.dart';
import 'package:audio_cult/app/features/profile/pages/events_page.dart';
import 'package:audio_cult/app/features/profile/pages/musics_page.dart';
import 'package:audio_cult/app/features/profile/pages/post_page.dart';
import 'package:audio_cult/app/features/profile/pages/videos_page.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> params;

  const ProfileScreen({Key? key, required this.params}) : super(key: key);
  static Map<String, dynamic> createArguments({required String id}) => {
        'userId': id,
      };

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        body: DefaultTabController(
          length: 5,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            slivers: [
              MySliverAppBar(controller: _scrollController, tabController: _tabController),
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    PostPage(),
                    AboutPage(),
                    VideosPage(),
                    MusicsPage(),
                    EventsPage(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
