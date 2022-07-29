import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/music/discover/widgets/song_item.dart';
import 'package:audio_cult/app/features/music/search/search_args.dart';
import 'package:audio_cult/app/features/music/search/search_bloc.dart';
import 'package:audio_cult/app/features/music/search/search_item.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';

import '../../../../di/bloc_locator.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/album/album_response.dart';
import '../../../utils/debouncer.dart';
import '../../../utils/route/app_route.dart';

enum SearchType {
  album,
  playlist,
  topSong,
  mixtapes,
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final SearchArgs arguments;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  late FocusNode focusNode;
  late SearchType searchType;
  late Debouncer debouncer;
  late TextEditingController editingController;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    searchType = widget.arguments.searchType;
    debouncer = Debouncer(milliseconds: 500);
    editingController = TextEditingController(text: '');

    callData('');
  }

  void callData(String value) {
    switch (searchType) {
      case SearchType.album:
        debouncer.run(() {
          getIt.get<SearchBloc>().getAlbums(value, 'featured', 1, 10);
        });
        break;
      case SearchType.playlist:
        debouncer.run(() {
          getIt.get<SearchBloc>().getPlaylist(value, 1, 10, 'most-liked', 1);
        });
        break;
      case SearchType.topSong:
        debouncer.run(() {
          getIt.get<SearchBloc>().getTopSongs(value, 'most-viewed', '','', 1, 10);
        });
        break;
      case SearchType.mixtapes:
        getIt.get<SearchBloc>().getMixTapSongs(value, 'most-viewed', 1, 10, 'featured', 'mixtape-song');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Column(
          children: [
            _buildSearchInput(),
            if (searchType == SearchType.album)
              _buildAlbums()
            else if (searchType == SearchType.playlist)
              _buildPlaylists()
            else
              _buildTopSongs()
          ],
        ),
      ),
    );
  }

  Widget _buildTopSongs() {
    return StreamBuilder<BlocState<List<Song>>>(
      initialData: const BlocState.loading(),
      stream: searchType == SearchType.topSong
          ? getIt.get<SearchBloc>().getTopSongsStream
          : getIt.get<SearchBloc>().getMixTapSongsStream,
      builder: (context, snapshot) {
        final state = snapshot.data!;

        return state.when(
          success: (success) {
            final data = success as List<Song>;

            return data.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: kVerticalSpacing - 10,
                        bottom: kVerticalSpacing + 5,
                        right: kHorizontalSpacing,
                        left: kHorizontalSpacing,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SongItem(
                            song: data[index],
                            songs: data,
                            index: index,
                            currency: getIt.get<SearchBloc>().currency,
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 24),
                        itemCount: data.length,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        context.l10n.t_no_data,
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
    );
  }

  Widget _buildPlaylists() {
    return StreamBuilder<BlocState<List<PlaylistResponse>>>(
      initialData: const BlocState.loading(),
      stream: getIt.get<SearchBloc>().getPlaylistStream,
      builder: (context, snapshot) {
        final state = snapshot.data!;

        return state.when(
          success: (success) {
            final data = success as List<PlaylistResponse>;

            return data.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: kVerticalSpacing - 10,
                        bottom: kVerticalSpacing + 5,
                        right: kHorizontalSpacing,
                        left: kHorizontalSpacing,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return WButtonInkwell(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.routeDetailPlayList,
                                arguments: {
                                  'playlist_id': data[index].playlistId,
                                },
                              );
                            },
                            child: SearchItem(
                              playlist: data[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 24),
                        itemCount: data.length,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        context.l10n.t_no_data,
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
    );
  }

  Widget _buildAlbums() {
    return StreamBuilder<BlocState<List<Album>>>(
      initialData: const BlocState.loading(),
      stream: getIt.get<SearchBloc>().getAlbumStream,
      builder: (context, snapshot) {
        final state = snapshot.data!;

        return state.when(
          success: (success) {
            final data = success as List<Album>;

            return data.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: kVerticalSpacing - 10,
                        bottom: kVerticalSpacing + 5,
                        right: kHorizontalSpacing,
                        left: kHorizontalSpacing,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return WButtonInkwell(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.routeDetailAlbum,
                                arguments: {
                                  'album_id': data[index].albumId,
                                },
                              );
                            },
                            child: SearchItem(
                              album: data[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 24),
                        itemCount: data.length,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        context.l10n.t_no_data,
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
    );
  }

  Widget _buildSearchInput() {
    return Container(
      height: 110,
      padding: const EdgeInsets.only(
        top: 34,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryButtonColor,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(4),
          ),
          const SizedBox(
            width: 4,
          ),
          Flexible(
            child: TextField(
              controller: editingController,
              autofocus: true,
              focusNode: focusNode,
              cursorColor: Colors.white,
              onChanged: (value) {
                callData(value);
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                focusColor: AppColors.outlineBorderColor,
                fillColor: AppColors.inputFillColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.outlineBorderColor,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.outlineBorderColor,
                    width: 2,
                  ),
                ),
                hintText: context.l10n.t_search,
                contentPadding: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                ),
                suffixIcon: query.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          focusNode.unfocus();
                          editingController.text = '';
                          setState(() {
                            query = '';
                          });
                          callData(query);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 18,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
