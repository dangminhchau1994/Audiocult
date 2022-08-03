import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/base/bloc_state.dart';
import '../../app/data_source/models/responses/reaction_icon/reaction_icon_response.dart';
import '../../app/utils/constants/app_colors.dart';
import '../../di/bloc_locator.dart';
import '../error_empty/error_section.dart';
import 'common_reaction_bloc.dart';

enum ReactionType {
  feed,
  music,
  album,
  playlist,
  event,
}

class CommonReactions extends StatefulWidget {
  const CommonReactions({
    Key? key,
    this.itemId,
    this.iconPath,
    this.fromFeed = false,
    this.totalLike,
    this.reactionType,
  }) : super(key: key);

  final String? itemId;
  final bool? fromFeed;
  final String? iconPath;
  final String? totalLike;
  final ReactionType? reactionType;

  @override
  State<CommonReactions> createState() => _CommonReactionsState();
}

class _CommonReactionsState extends State<CommonReactions> {
  final _bloc = CommonReactionBloc(locator.get());

  @override
  void initState() {
    super.initState();
    _bloc.getReactionIcons();
  }

  String getType(ReactionType reactionType) {
    switch (reactionType) {
      case ReactionType.feed:
        return 'feed';
      case ReactionType.music:
        return 'music_song';
      case ReactionType.album:
        return 'music_album';
      case ReactionType.playlist:
        return 'advancedmusic_playlist';
      case ReactionType.event:
        return 'event';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.fromFeed! ? Colors.blueGrey.withOpacity(0.2) : AppColors.secondaryButtonColor,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          StreamBuilder<BlocState<List<ReactionIconResponse>>>(
            initialData: const BlocState.loading(),
            stream: _bloc.getReactionIconStream,
            builder: (context, snapshot) {
              final state = snapshot.data!;

              return state.when(
                success: (success) {
                  final data = success as List<ReactionIconResponse>;

                  var reactions = <Reaction<ReactionIconResponse>>[];
                  reactions = data
                      .map(
                        (e) => Reaction<ReactionIconResponse>(
                          value: e,
                          //title: _buildTitle(e.name ?? ''),
                          icon: _buildReactionsIcon(
                            e.imagePath ?? '',
                          ),
                        ),
                      )
                      .toList();

                  return ReactionButtonToggle<ReactionIconResponse>(
                    boxPosition: Position.BOTTOM,
                    boxPadding: const EdgeInsets.all(16),
                    boxColor: AppColors.secondaryButtonColor,
                    onReactionChanged: (ReactionIconResponse? value, bool isChecked) {
                      _bloc.postReactionIcon(
                        getType(widget.reactionType!),
                        int.parse(widget.itemId ?? ''),
                        int.parse(value?.iconId ?? ''),
                      );
                    },
                    reactions: reactions,
                    initialReaction: Reaction<ReactionIconResponse>(
                      value: ReactionIconResponse(),
                      icon: SvgPicture.network(
                        widget.iconPath ?? data[0].imagePath!,
                        placeholderBuilder: (BuildContext context) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryButtonColor,
                          ),
                        ),
                      ),
                    ),
                    selectedReaction: reactions[0],
                  );
                },
                loading: () {
                  return CircularProgressIndicator(
                    color: AppColors.primaryButtonColor,
                  );
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
          const SizedBox(
            width: 6,
          ),
          StreamBuilder<String>(
            initialData: widget.totalLike ?? '0',
            stream: _bloc.postReactionIconStream,
            builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                snapshot.data!,
                style: context.bodyTextPrimaryStyle()!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return SizedBox(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildReactionsIcon(String path) {
    return SvgPicture.network(
      path,
      placeholderBuilder: (BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
