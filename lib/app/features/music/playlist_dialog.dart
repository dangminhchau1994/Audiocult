import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/features/music/playlist_dialog_bloc.dart';
import 'package:audio_cult/app/features/music/search/search_item.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';

import '../../../di/bloc_locator.dart';
import '../../../w_components/buttons/w_button_inkwell.dart';
import '../../../w_components/error_empty/error_section.dart';
import '../../../w_components/loading/loading_widget.dart';
import '../../base/bloc_state.dart';
import '../../data_source/models/responses/playlist/playlist_response.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_dimens.dart';
import '../../utils/debouncer.dart';
import '../../utils/mixins/disposable_state_mixin.dart';
import '../../utils/toast/toast_utils.dart';

class PlayListDialog extends StatefulWidget {
  const PlayListDialog({
    Key? key,
    this.songId,
  }) : super(key: key);

  final String? songId;

  @override
  State<PlayListDialog> createState() => _PlayListDialogState();
}

class _PlayListDialogState extends State<PlayListDialog> with DisposableStateMixin {
  String query = '';
  late FocusNode focusNode;
  late Debouncer debouncer;
  late TextEditingController editingController;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    debouncer = Debouncer(milliseconds: 500);
    editingController = TextEditingController(text: '');
    getIt.get<PlayListDialogBloc>().addPlaylistStream.listen((profile) {
      ToastUtility.showSuccess(context: context, message: 'Added To PlayList!');
      Navigator.pop(context);
    }).disposeOn(disposeBag);

    callData('');
  }

  void callData(String value) {
    debouncer.run(() {
      getIt.get<PlayListDialogBloc>().getPlaylist(value, 1, 10, 'latest', '', '', 0);
    });
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: editingController,
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
          hintText: context.localize.t_search,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocHandle(
        bloc: getIt.get<PlayListDialogBloc>(),
        child: SafeArea(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
              ),
              child: Column(
                children: [
                  _buildSearchInput(),
                  Expanded(
                    child: StreamBuilder<BlocState<List<PlaylistResponse>>>(
                      initialData: const BlocState.loading(),
                      stream: getIt.get<PlayListDialogBloc>().getPlaylistStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data!;

                        return state.when(
                          success: (success) {
                            final data = success as List<PlaylistResponse>;

                            if (data.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kHorizontalSpacing,
                                  vertical: kVerticalSpacing,
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return WButtonInkwell(
                                      onPressed: () {
                                        getIt.get<PlayListDialogBloc>().addToPlaylist(
                                              data[index].playlistId ?? '',
                                              widget.songId ?? '',
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
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    context.localize.t_no_data,
                                  )
                                ],
                              );
                            }
                          },
                          loading: () {
                            return const Center(child: LoadingWidget());
                          },
                          error: (error) {
                            return ErrorSectionWidget(
                              errorMessage: error,
                              onRetryTap: () {
                                callData(query);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
