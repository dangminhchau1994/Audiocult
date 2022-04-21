import 'dart:io';
import 'dart:math';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/requests/create_playlist_request.dart';
import 'package:audio_cult/app/data_source/models/responses/create_playlist/create_playlist_response.dart';
import 'package:audio_cult/app/features/music/library/create_playlist_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/image/image_utils.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:flutter/material.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_blur.dart';

class CreatePlayListScreen extends StatefulWidget {
  const CreatePlayListScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlayListScreen> createState() => _CreatePlayListScreenState();
}

class _CreatePlayListScreenState extends State<CreatePlayListScreen> {
  List<File>? _imageFileList;
  String? _pickImageError;
  String? errorTitle = '';
  bool runStream = false;
  final _formKey = GlobalKey<FormState>();
  final _createPlayListRequest = CreatePlayListRequest();

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildPreViewImage() {
    if (_imageFileList != null) {
      return _buildImagePicked();
    } else {
      return _buildChooseImage();
    }
  }

  Widget _buildImagePicked() {
    _createPlayListRequest.file = _imageFileList![0];
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.inputFillColor.withOpacity(0.4),
        border: Border.all(color: AppColors.outlineBorderColor, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              await ImageUtils.onPickGallery(
                context: context,
                onChooseImage: (image) {
                  setState(() {
                    _imageFileList = image == null ? null : <File>[image];
                  });
                },
                onError: (error) {
                  setState(() {
                    _pickImageError = error.toString();
                  });
                },
              );
            },
            child: Image.file(
              File(_imageFileList![0].path),
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _imageFileList = null;
                });
              },
              child: const Icon(
                Icons.close,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChooseImage() {
    return GestureDetector(
      onTap: () async {
        await ImageUtils.onPickGallery(
          context: context,
          onChooseImage: (image) {
            setState(() {
              _imageFileList = image == null ? null : <File>[image];
            });
          },
          onError: (error) {
            setState(() {
              _pickImageError = error.toString();
            });
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(35),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.secondaryButtonColor,
          border: Border.all(color: AppColors.outlineBorderColor, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.activeLabelItem.withOpacity(0.5),
            ),
            child: Center(
              child: Icon(
                Icons.add,
                size: 24,
                color: AppColors.activeLabelItem,
              ),
            ),
          ),
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
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: CommonAppBar(
          title: context.l10n.t_create_playlist,
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
                      _buildPreViewImage(),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonInput(
                        hintText: context.l10n.t_playlist_name,
                        onChanged: (value) {
                          _createPlayListRequest.title = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        cursorColor: Colors.white,
                        onChanged: (value) {
                          _createPlayListRequest.description = value;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          errorText: errorTitle!.isEmpty ? null : errorTitle,
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
                          hintText: context.l10n.t_optional_description,
                          hintStyle: TextStyle(color: AppColors.unActiveLabelItem),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonButton(
                          color: AppColors.primaryButtonColor,
                          text: context.l10n.t_apply,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                runStream = true;
                              });
                              getIt<CreatePlayListBloc>().createPlayList(
                                CreatePlayListRequest(
                                  title: _createPlayListRequest.title,
                                  file: _createPlayListRequest.file,
                                  description: _createPlayListRequest.description,
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
              if (runStream)
                StreamBuilder<BlocState<CreatePlayListResponse>>(
                  initialData: const BlocState.loading(),
                  stream: getIt<CreatePlayListBloc>().createPlayListStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data!;

                    return state.when(
                      success: (data) {
                        Navigator.pop(context, true);
                        return Container();
                      },
                      loading: () {
                        return const Center(
                          child: LoadingBlur(),
                        );
                      },
                      error: (error) {
                        return ErrorSectionWidget(
                          errorMessage: error,
                          onRetryTap: () {
                            getIt<CreatePlayListBloc>().createPlayList(
                              CreatePlayListRequest(
                                title: _createPlayListRequest.title,
                                file: _createPlayListRequest.file,
                                description: _createPlayListRequest.description,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                )
              else
                const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
