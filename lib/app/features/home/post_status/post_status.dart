import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/requests/create_post_request.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/features/home/widgets/background_item.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../w_components/dropdown/common_dropdown.dart';
import '../../../data_source/models/responses/background/background_response.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/mixins/disposable_state_mixin.dart';

class PostStatus extends StatefulWidget {
  const PostStatus({Key? key}) : super(key: key);

  @override
  State<PostStatus> createState() => _PostStatusState();
}

class _PostStatusState extends State<PostStatus> with DisposableStateMixin {
  final CreatePostRequest _createPostRequest = CreatePostRequest();
  final TextEditingController _textEditingController = TextEditingController(text: '');
  SelectMenuModel? _privacy;
  bool? _showListBackground;
  bool? _enableBackground;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _privacy = GlobalConstants.listPrivacy[0];
    _imagePath = '';
    _showListBackground = false;
    _enableBackground = false;
    getIt.get<HomeBloc>().createPostStream.listen((data) {
      Navigator.pop(context, true);
    }).disposeOn(disposeBag);
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: getIt.get<HomeBloc>(),
      child: Stack(
        children: [
          if (_enableBackground!)
            _buildBackground(_imagePath ?? '')
          else
            TextField(
              maxLines: 10,
              controller: _textEditingController,
              onChanged: (value) {
                _createPostRequest.userStatus = value;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(18),
                hintText: context.l10n.t_what_new,
                hintStyle: context.bodyTextPrimaryStyle()!.copyWith(color: AppColors.subTitleColor, fontSize: 18),
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_showListBackground!)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          WButtonInkwell(
                            onPressed: () {
                              setState(() {
                                _showListBackground = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.secondaryButtonColor,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 20,
                                color: AppColors.subTitleColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          StreamBuilder<BlocState<List<BackgroundResponse>>>(
                            initialData: const BlocState.loading(),
                            stream: getIt<HomeBloc>().getBackgroundStream,
                            builder: (context, snapshot) {
                              final state = snapshot.data!;

                              return state.when(
                                success: (success) {
                                  final data = success as List<BackgroundResponse>;

                                  return SizedBox(
                                    height: 50,
                                    width: 240,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                                      itemCount: data[0].backgroundsList?.length ?? 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => BackgroundItem(
                                        data: data[0].backgroundsList?[index],
                                        onItemClick: (data) {
                                          setState(() {
                                            _createPostRequest.statusBackgroundId = data.backgroundId;
                                            _imagePath = data.imageUrl ?? '';
                                            _enableBackground = true;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                                loading: () {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryButtonColor,
                                    ),
                                  );
                                },
                                error: (error) {
                                  return ErrorSectionWidget(
                                    errorMessage: error,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  else
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: CommonDropdown(
                            selection: _privacy,
                            hint: '',
                            backgroundColor: Colors.transparent,
                            noBorder: true,
                            data: GlobalConstants.listPrivacy,
                            onChanged: (value) {
                              setState(() {
                                _privacy = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          AppAssets.tagFriends,
                          width: 28,
                          height: 28,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AppAssets.locationIcon,
                          width: 28,
                          height: 28,
                        ),
                        const SizedBox(width: 20),
                        WButtonInkwell(
                          onPressed: () {
                            setState(() {
                              _showListBackground = true;
                              getIt<HomeBloc>().getBackgrounds();
                            });
                          },
                          child: SvgPicture.asset(
                            AppAssets.colorPickerIcon,
                            width: 28,
                            height: 28,
                          ),
                        ),
                      ],
                    ),
                  CommonButton(
                    width: 110,
                    color: AppColors.primaryButtonColor,
                    text: 'Post',
                    onTap: () {
                      getIt.get<HomeBloc>().createPost(_createPostRequest);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBackground(String imagePath) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CommonImageNetWork(
          imagePath: imagePath,
          width: double.infinity,
          height: 290,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _textEditingController,
            maxLines: 3,
            textAlign: TextAlign.center,
            onChanged: (value) {
              _createPostRequest.userStatus = value;
            },
            decoration: InputDecoration(
              hintText: context.l10n.t_what_new,
              hintStyle: context.bodyTextPrimaryStyle()!.copyWith(
                    color: AppColors.subTitleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _enableBackground = false;
                _createPostRequest.statusBackgroundId = '0';
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.close,
                size: 25,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
