import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/create_playlist_request.dart';
import 'package:audio_cult/app/features/music/library/create_playlist_bloc.dart';
import 'package:audio_cult/app/features/music/library/update_playlist_params.dart';
import 'package:audio_cult/app/features/music/library/widgets/preview_image.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';

import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';

class CreatePlayListScreen extends StatefulWidget {
  const CreatePlayListScreen({Key? key, this.updatePlaylistParams}) : super(key: key);

  final UpdatePlaylistParams? updatePlaylistParams;

  @override
  State<CreatePlayListScreen> createState() => _CreatePlayListScreenState();
}

class _CreatePlayListScreenState extends State<CreatePlayListScreen> with DisposableStateMixin {
  String errorTitle = '';
  final _formKey = GlobalKey<FormState>();
  final _createPlayListRequest = CreatePlayListRequest();
  final _playListNameController = TextEditingController(text: '');
  final _descriptionController = TextEditingController(text: '');

  void _initParams() {
    _createPlayListRequest.imagePath = widget.updatePlaylistParams?.imagePath ?? '';
    _createPlayListRequest.title = widget.updatePlaylistParams?.title ?? '';
    _createPlayListRequest.description = widget.updatePlaylistParams?.description ?? '';

    _playListNameController.text = widget.updatePlaylistParams?.title ?? '';
    _descriptionController.text = widget.updatePlaylistParams?.description ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _playListNameController.dispose();
    _descriptionController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initParams();

    getIt.get<CreatePlayListBloc>().createPlayListStream.listen((data) {
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);

    getIt.get<CreatePlayListBloc>().updatePlayListStream.listen((data) {
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: getIt<CreatePlayListBloc>(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.mainColor,
          appBar: CommonAppBar(
            title: context.localize.t_create_playlist,
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(
              vertical: kVerticalSpacing,
              horizontal: kHorizontalSpacing,
            ),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PreViewImage(
                          request: _createPlayListRequest,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CommonInput(
                          editingController: _playListNameController,
                          hintText: context.localize.t_playlist_name,
                          onChanged: (value) {
                            _createPlayListRequest.title = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          cursorColor: Colors.white,
                          onChanged: (value) {
                            _createPlayListRequest.description = value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            errorText: errorTitle.isEmpty ? null : errorTitle,
                            focusColor: AppColors.outlineBorderColor,
                            fillColor: AppColors.inputFillColor.withOpacity(0.4),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: AppColors.outlineBorderColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: AppColors.outlineBorderColor,
                                width: 2,
                              ),
                            ),
                            hintText: context.localize.t_optional_description,
                            hintStyle: TextStyle(color: AppColors.unActiveLabelItem),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CommonButton(
                          color: AppColors.primaryButtonColor,
                          text: context.localize.t_apply,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.updatePlaylistParams?.title?.isNotEmpty ?? false) {
                                getIt<CreatePlayListBloc>().updatePlaylist(
                                  CreatePlayListRequest(
                                    title: _createPlayListRequest.title,
                                    file: _createPlayListRequest.file,
                                    description: _createPlayListRequest.description,
                                    id: widget.updatePlaylistParams?.id,
                                  ),
                                );
                              } else {
                                getIt<CreatePlayListBloc>().createPlayList(
                                  CreatePlayListRequest(
                                    title: _createPlayListRequest.title,
                                    file: _createPlayListRequest.file,
                                    description: _createPlayListRequest.description,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
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
