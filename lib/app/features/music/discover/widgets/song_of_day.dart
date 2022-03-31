import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/discover/discover_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../../w_components/images/common_image_network.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../base/bloc_state.dart';

class SongOfDay extends StatelessWidget {
  const SongOfDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SONG OF THE DAY',
          style: context.bodyTextPrimaryStyle()!.copyWith(
                color: AppColors.subTitleColor,
              ),
        ),
        const SizedBox(
          height: 12,
        ),
        StreamBuilder<BlocState<Song>>(
          initialData: const BlocState.loading(),
          stream: getIt<DiscoverBloc>().getSongOfDayStream,
          builder: (context, snapshot) {
            final state = snapshot.data!;

            return state.when(
              success: (success) {
                final data = success as Song;

                return Column(
                  children: [
                    Stack(
                      children: [
                        CommonImageNetWork(
                          width: double.infinity,
                          height: 140,
                          imagePath: data.imagePath ?? '',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                data.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: context.bodyTextPrimaryStyle()!.copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  data.artistUser?.userName ?? 'N/A',
                                  style: context.bodyTextPrimaryStyle()!.copyWith(
                                        color: AppColors.subTitleColor,
                                        fontSize: 16,
                                      ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.circle,
                                  color: Colors.grey,
                                  size: 5,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  DateTimeUtils.formatyMMMMd(int.parse(data.timeStamp ?? '')),
                                  style: context.bodyTextPrimaryStyle()!.copyWith(
                                        color: AppColors.subTitleColor,
                                        fontSize: 16,
                                      ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondaryButtonColor,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
              loading: () {
                return const Center(child: LoadingWidget());
              },
              error: (error) {
                return ErrorSectionWidget(
                  errorMessage: error,
                  onRetryTap: () {},
                );
              },
            );
          },
        ),
      ],
    );
  }
}
