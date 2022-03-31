import 'package:audio_cult/app/features/music/playlist_dialog_bloc.dart';
import 'package:audio_cult/app/features/music/search/search_item.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import '../../../di/bloc_locator.dart';
import '../../../w_components/buttons/w_button_inkwell.dart';
import '../../../w_components/error_empty/error_section.dart';
import '../../../w_components/loading/loading_widget.dart';
import '../../base/bloc_state.dart';
import '../../constants/app_text_styles.dart';
import '../../data_source/models/responses/playlist/playlist_response.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_dimens.dart';
import '../../utils/debouncer.dart';
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

class _PlayListDialogState extends State<PlayListDialog> {
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

    callData('');
  }

  void callData(String value) {
    debouncer.run(() {
      getIt.get<PlayListDialogBloc>().getPlaylist(value, 1, 10, 'most-liked', 0);
    });
  }

  Widget _buidSearchInput() {
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
        style: AppTextStyles.regular,
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
          hintStyle: AppTextStyles.regular,
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
                _buidSearchInput(),
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
                                      Navigator.pop(context);
                                      ToastUtility.showSuccess(
                                          context: context, message: 'Add to playList successful!');
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
                                  context.l10n.t_no_data,
                                  style: AppTextStyles.normal,
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
                            onRetryTap: () {},
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
    );
  }
}
