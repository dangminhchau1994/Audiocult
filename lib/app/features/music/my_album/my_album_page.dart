import 'package:audio_cult/app/base/pair.dart';
import 'package:audio_cult/app/features/main/main_bloc.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_item.dart';
import 'package:audio_cult/app/features/music/my_album/upload_song/upload_song_screen.dart';
import 'package:audio_cult/app/features/music/search/search_item.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/mixins/disposable_state_mixin.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/dialogs/app_dialog.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../w_components/buttons/common_icon_button.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../base/bloc_state.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/responses/album/album_response.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../utils/constants/app_dimens.dart';
import '../discover/widgets/section_title.dart';
import 'my_album_bloc.dart';

class MyAlbumPage extends StatefulWidget {
  const MyAlbumPage({Key? key}) : super(key: key);

  @override
  State<MyAlbumPage> createState() => _MyAlbumPageState();
}

class _MyAlbumPageState extends State<MyAlbumPage> with DisposableStateMixin {
  final MyAlbumBloc _myAlbumBloc = MyAlbumBloc(locator.get());
  @override
  void initState() {
    super.initState();
    _myAlbumBloc.getAlbums('', '', 1, 3, userId: locator.get<MainBloc>().profileData!.userId);
    _myAlbumBloc.getMixTapSongs('', '', 1, 3, '', '', userId: locator.get<MainBloc>().profileData!.userId);
    _myAlbumBloc.deleteStream.listen((event) {
      ToastUtility.showSuccess(context: context, message: event);
      _myAlbumBloc.getMixTapSongs('', '', 1, 3, '', '', userId: locator.get<MainBloc>().profileData!.userId);
    }).disposeOn(disposeBag);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalSpacing,
        vertical: kVerticalSpacing,
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          _myAlbumBloc.getAlbums('', '', 1, 3, userId: locator.get<MainBloc>().profileData!.userId);
          _myAlbumBloc.getMixTapSongs('', '', 1, 3, '', '', userId: locator.get<MainBloc>().profileData!.userId);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              //album list
              StreamBuilder<BlocState<List<Album>>>(
                initialData: const BlocState.loading(),
                stream: _myAlbumBloc.getAlbumStream,
                builder: (context, snapshot) {
                  final state = snapshot.data!;
                  return state.when(
                    success: (success) {
                      final albums = success as List<Album>;
                      if (albums.isEmpty) {
                        return Container();
                      }
                      return Column(
                        children: [
                          SectionTitle(
                            title: context.l10n.t_choose_gallery,
                            // onShowAll: () {},
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: albums.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 24),
                            itemBuilder: (context, index) {
                              return SearchItem(
                                album: albums[index],
                              );
                            },
                          ),
                        ],
                      );
                    },
                    loading: () {
                      return const Center(child: LoadingWidget());
                    },
                    error: (error) {
                      return ErrorSectionWidget(
                        errorMessage: error,
                        onRetryTap: () {
                          _myAlbumBloc.getAlbums('', '', 1, 3, userId: locator.get<MainBloc>().profileData!.userId);
                        },
                      );
                    },
                  );
                },
              ),

              StreamBuilder<BlocState<List<Song>>>(
                initialData: const BlocState.loading(),
                stream: _myAlbumBloc.getMixTapSongsStream,
                builder: (context, snapshot) {
                  final state = snapshot.data!;
                  return state.when(
                    success: (success) {
                      final songs = success as List<Song>;
                      if (songs.isEmpty) {
                        return Container();
                      }
                      return Column(
                        children: [
                          SectionTitle(
                            title: context.l10n.t_song_mixtaps,
                            // onShowAll: () {},
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          //Song list
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: songs.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 24),
                            itemBuilder: (context, index) {
                              return SongItem(
                                songs: songs,
                                hasMenu: false,
                                index: index,
                                fromDetail: true,
                                song: songs[index],
                                customizeMenu: WButtonInkwell(
                                  onPressed: () {
                                    AppDialog.showSelectionBottomSheet(
                                      context,
                                      isShowSelect: false,
                                      listSelection: GlobalConstants.menuMyAlbum(context),
                                      onTap: (id) async {
                                        Navigator.pop(context);
                                        switch (id) {
                                          case 1:
                                            final result = await Navigator.pushNamed(
                                              context,
                                              AppRoute.routeUploadSong,
                                              arguments: UploadSongScreen.createArguments(
                                                  // ignore: avoid_bool_literals_in_conditional_expressions
                                                  isUploadSong: index == 0 ? true : false,
                                                  song: songs[index]),
                                            );
                                            if (result != null) {
                                              _myAlbumBloc.getAlbums('', '', 1, 3,
                                                  userId: locator.get<MainBloc>().profileData!.userId);
                                              _myAlbumBloc.getMixTapSongs('', '', 1, 3, '', '',
                                                  userId: locator.get<MainBloc>().profileData!.userId);
                                            }
                                            break;
                                          case 5:
                                            AppDialog.showYesNoDialog(
                                              context,
                                              message: 'Are you sure to delete this song!',
                                              onYesPressed: () {
                                                _myAlbumBloc.deleteSongId(songs[index].songId);
                                              },
                                            );
                                            break;
                                        }
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    child: SvgPicture.asset(
                                      AppAssets.horizIcon,
                                      width: 16,
                                      height: 16,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                    loading: () {
                      return const Center(child: LoadingWidget());
                    },
                    error: (error) {
                      return ErrorSectionWidget(
                        errorMessage: error,
                        onRetryTap: () {
                          _myAlbumBloc.getMixTapSongs('', '', 1, 3, '', '',
                              userId: locator.get<MainBloc>().profileData!.userId);
                        },
                      );
                    },
                  );
                },
              ),

              CommonIconButton(
                color: AppColors.secondaryButtonColor,
                textColor: AppColors.activeLabelItem,
                text: context.l10n.t_upload,
                icon: Image.asset(AppAssets.icUpload, width: 24),
                onTap: () {
                  AppDialog.showSelectionBottomSheet(
                    context,
                    listSelection: [
                      Pair(
                        Pair(
                          0,
                          Container(),
                        ),
                        context.l10n.t_upload_song,
                      ),
                      Pair(
                        Pair(
                          1,
                          Container(),
                        ),
                        context.l10n.t_upload_album,
                      ),
                    ],
                    onTap: (index) async {
                      Navigator.pop(context);
                      final result = await Navigator.pushNamed(
                        context,
                        AppRoute.routeUploadSong,
                        arguments:
                            // ignore: avoid_bool_literals_in_conditional_expressions
                            UploadSongScreen.createArguments(isUploadSong: index == 0 ? true : false, song: null),
                      );
                      if (result != null) {
                        _myAlbumBloc.getAlbums('', '', 1, 3, userId: locator.get<MainBloc>().profileData!.userId);
                        _myAlbumBloc.getMixTapSongs('', '', 1, 3, '', '',
                            userId: locator.get<MainBloc>().profileData!.userId);
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
