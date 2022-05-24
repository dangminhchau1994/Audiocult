import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/announcement/announcement_response.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/number/number_utils.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../di/bloc_locator.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../home_bloc.dart';

class AnnouncementPost extends StatefulWidget {
  const AnnouncementPost({Key? key}) : super(key: key);

  @override
  State<AnnouncementPost> createState() => _AnnouncementPostState();
}

class _AnnouncementPostState extends State<AnnouncementPost> {
  @override
  void initState() {
    super.initState();
    getIt<HomeBloc>().getAnnouncements(1, 10);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StreamBuilder<BlocState<List<AnnouncementResponse>>>(
        initialData: const BlocState.loading(),
        stream: getIt<HomeBloc>().getAnnoucementStream,
        builder: (context, snapshot) {
          final state = snapshot.data!;

          return state.when(success: (data) {
            final result = data as List<AnnouncementResponse>;

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.orangeColor,
                        AppColors.deepOrangeColor,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Did Your know?',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            result[0].postedOn ?? '',
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 5,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${NumberUtils.convertNumberToK(result[0].totalView ?? '').toLowerCase()}+ views',
                            style: context.bodyTextPrimaryStyle()!.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        result[0].introVar ?? '',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                WButtonInkwell(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.routeCreatePost);
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryButtonColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.activeEdit,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          context.l10n.t_create_post,
                          style: TextStyle(
                            color: AppColors.activeLabelItem,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }, loading: () {
            return const Center(
              child: LoadingWidget(),
            );
          }, error: (error) {
            return ErrorSectionWidget(
              errorMessage: error,
              onRetryTap: () {
                getIt<HomeBloc>().getAnnouncements(1, 10);
              },
            );
          });
        },
      ),
    );
  }
}
