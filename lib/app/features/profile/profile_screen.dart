import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/profile_request.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/features/profile/my_sliver_appbar.dart';
import 'package:audio_cult/app/features/profile/pages/about_page.dart';
import 'package:audio_cult/app/features/profile/pages/events_page.dart';
import 'package:audio_cult/app/features/profile/pages/musics_page.dart';
import 'package:audio_cult/app/features/profile/pages/post_page.dart';
import 'package:audio_cult/app/features/profile/pages/videos_page.dart';
import 'package:audio_cult/app/features/profile/profile_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/view/no_data_widget.dart';
import 'package:audio_cult/w_components/loading/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../data_source/models/responses/profile_data.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_font_sizes.dart';

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
  late HomeBloc _homeBloc;
  TabController? _tabController;
  ProfileBloc? _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
    _profileBloc?.requestData(params: ProfileRequest(userId: widget.params['userId'] as String, query: 'info'));
    _profileBloc?.blockUserStream.listen((event) {
      Navigator.pop(context);
    });
  }

  Widget _buildNoData() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kVerticalSpacing,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.eventIcon,
              width: MediaQuery.of(context).size.width * 0.12,
            ),
            const SizedBox(height: kVerticalSpacing),
            Text(
              context.localize.t_no_results_found,
              style: context.body3TextStyle()?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.size19,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              context.localize.t_not_find_what_looking_for,
              textAlign: TextAlign.center,
              style: context.body3TextStyle()?.copyWith(
                    color: Colors.grey,
                    fontSize: AppFontSize.size17,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: _profileBloc!,
      child: Scaffold(
          backgroundColor: AppColors.mainColor,
          body: LoadingBuilder<ProfileBloc, ProfileData>(
            noDataBuilder: (state) => _buildNoData(),
            builder: (data, _) {
              data.currency = _profileBloc?.currency;
              return DefaultTabController(
                length: 5,
                child: RefreshIndicator(
                  onRefresh: () async {
                    _profileBloc?.requestData(params: ProfileRequest(userId: widget.params['userId'] as String));
                  },
                  child: CustomScrollView(
                    shrinkWrap: true,
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      MySliverAppBar(
                        controller: _scrollController,
                        tabController: _tabController,
                        profile: data,
                        onUpdateUser: () {
                          _profileBloc?.requestData(
                              params: ProfileRequest(userId: widget.params['userId'] as String, query: 'info'));
                        },
                        onPicKImage: (value) {
                          _profileBloc?.uploadAvatar(value);
                        },
                        onBlockUser: () {
                          _profileBloc?.blockUser(int.parse(widget.params['userId'] as String));
                        },
                      ),
                      SliverFillRemaining(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            PostPage(profile: data, scrollController: _scrollController),
                            AboutPage(profile: data, scrollController: _scrollController),
                            VideosPage(profile: data, scrollController: _scrollController),
                            MusicsPage(profile: data, scrollController: _scrollController),
                            EventsPage(profile: data, scrollController: _scrollController),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
