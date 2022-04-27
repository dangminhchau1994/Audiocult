import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/data_source/models/responses/subscriptions_response.dart';
import 'package:audio_cult/app/features/profile/profile_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_constants.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/constants/app_font_sizes.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../base/bloc_state.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/route/app_route.dart';
import '../profile_screen.dart';

class PostPage extends StatefulWidget {
  final ScrollController? scrollController;
  final ProfileData? profile;
  const PostPage({Key? key, this.profile, this.scrollController}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  double height = 8;
  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(() {
      if (widget.scrollController!.offset > 350) {
        setState(() {
          height = (widget.scrollController!.offset - 350) + 64;
        });
      } else {
        setState(() {
          height = 8;
        });
      }
    });
    Provider.of<ProfileBloc>(context, listen: false)
        .getListSubscriptions(widget.profile?.userId, 1, GlobalConstants.loadMoreItem);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height),
        Container(
          margin: const EdgeInsets.all(kVerticalSpacing),
          padding: const EdgeInsets.all(kVerticalSpacing),
          decoration: BoxDecoration(color: AppColors.ebonyClay),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    context.l10n.t_subscriptions,
                    style:
                        context.body1TextStyle()?.copyWith(fontSize: AppFontSize.size18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: kHorizontalSpacing / 2,
                  ),
                  Text(
                    '${widget.profile?.totalSubscribers ?? 0}',
                    style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  WButtonInkwell(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Show All',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              fontSize: 16,
                              color: AppColors.lightBlue,
                            ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 96,
                child: StreamBuilder<BlocState<List<Subscriptions>>>(
                    initialData: const BlocState.loading(),
                    stream: Provider.of<ProfileBloc>(context, listen: false).getListSubscriptionsStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data!;
                      return state.when(
                        success: (data) {
                          final subscriptions = data as List<Subscriptions>;
                          return ListView.builder(
                              itemCount: subscriptions.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return WButtonInkwell(
                                  onPressed: () {
                                    Navigator.pushNamed(context, AppRoute.routeProfile,
                                        arguments: ProfileScreen.createArguments(id: subscriptions[index].userId!));
                                  },
                                  child: Container(
                                    width: 96,
                                    height: 96,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kVerticalSpacing / 2, vertical: kVerticalSpacing / 2),
                                    child: CircleAvatar(
                                      child: ClipOval(
                                        child: CommonImageNetWork(
                                          width: 96,
                                          height: 96,
                                          imagePath: subscriptions[index].userImage ?? '',
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        loading: () {
                          return const Center(child: LoadingWidget());
                        },
                        error: (error) {
                          return ErrorSectionWidget(
                            errorMessage: error,
                            onRetryTap: () {
                              Provider.of<ProfileBloc>(context, listen: false)
                                  .getListSubscriptions(widget.profile?.userId, 1, GlobalConstants.loadMoreItem);
                            },
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
