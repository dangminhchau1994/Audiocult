import 'package:audio_cult/app/data_source/models/cache_filter.dart';
import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/app/features/music/filter/filter_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:audio_cult/w_components/textfields/common_input.dart';
import 'package:audio_cult/w_components/w_keyboard_dismiss.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../w_components/textfields/common_input_tags_grid_checkbox.dart';

class MusicFilterScreen extends StatefulWidget {
  const MusicFilterScreen({Key? key}) : super(key: key);

  @override
  State<MusicFilterScreen> createState() => _MusicFilterScreenState();
}

class _MusicFilterScreenState extends State<MusicFilterScreen> {
  final FilterBloc _filterBloc = FilterBloc(locator.get());
  CacheFilter? _cacheFilter;
  @override
  void initState() {
    super.initState();
    _cacheFilter = _filterBloc.cache() ?? CacheFilter(allTime: [], genres: [], mostLiked: []);
    _filterBloc.getCacheFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        backgroundColor: AppColors.mainColor,
        title: context.l10n.t_filter,
        actions: [
          WButtonInkwell(
            borderRadius: BorderRadius.circular(8),
            onPressed: () {
              _filterBloc.clearFilter();
              _filterBloc.getMasterData();
              _filterBloc.getGenres();
            },
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  context.l10n.t_clear_filter,
                  style: context.bodyTextStyle()?.copyWith(color: AppColors.lightBlue),
                ),
              ),
            ),
          )
        ],
      ),
      body: WKeyboardDismiss(
        child: Container(
          height: double.infinity,
          color: AppColors.mainColor,
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalSpacing, vertical: kVerticalSpacing),
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<Map<String, List<SelectMenuModel>>>(
                  stream: _filterBloc.getMasterDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          Expanded(
                            child: CommonDropdown(
                              dropDownWith: MediaQuery.of(context).size.width / 2 - 28,
                              data: snapshot.data!['most_liked'],
                              hint: '',
                              selection:
                                  snapshot.data!['most_liked']!.where((element) => element.isSelected == true).first,
                              onChanged: (value) {
                                snapshot.data!['most_liked']!.map((e) {
                                  if (e.id == value!.id) {
                                    e.isSelected = true;
                                  } else {
                                    e.isSelected = false;
                                  }
                                }).toList();
                                setState(() {});
                                _cacheFilter?.mostLiked = snapshot.data!['most_liked'];
                              },
                            ),
                          ),
                          const SizedBox(
                            width: kHorizontalSpacing,
                          ),
                          Expanded(
                            child: CommonDropdown(
                              dropDownWith: MediaQuery.of(context).size.width / 2 - 28,
                              data: snapshot.data!['all_time'],
                              selection:
                                  snapshot.data!['all_time']!.where((element) => element.isSelected == true).first,
                              hint: '',
                              onChanged: (value) {
                                snapshot.data!['all_time']!.map((e) {
                                  if (e.id == value!.id) {
                                    e.isSelected = true;
                                  } else {
                                    e.isSelected = false;
                                  }
                                }).toList();
                                setState(() {});
                                _cacheFilter?.allTime = snapshot.data!['all_time'];
                              },
                            ),
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                StreamBuilder<List<Genre>>(
                  stream: _filterBloc.getGenresStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: kVerticalSpacing),
                        child: CommonInputTagsGridCheckBox(
                          initTags: snapshot.data!.map((e) {
                            if (e.isSelected == true) {
                              return e.name!;
                            } else {
                              return '';
                            }
                          }).toList(),
                          onChange: (value, isAdded) {
                            if (isAdded) {
                              if (value.isSelected == true) {
                                snapshot.data!
                                    .add(Genre(genreId: const Uuid().v4(), name: value.title, isSelected: true));
                              } else {
                                snapshot.data!.removeWhere((element) => element.name == value.title);
                              }

                              _cacheFilter?.genres = snapshot.data;
                            } else {
                              snapshot.data?.map((e) {
                                if (e.genreId == value.id) {
                                  e.isSelected = value.isSelected;
                                }
                              }).toList();
                            }
                          },
                          hintText: context.l10n.t_genres,
                          listCheckBox: snapshot.data!
                              .map(
                                (e) => InputTagSelect(
                                  e.genreId,
                                  e.isSelected,
                                  e.name ?? '',
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }
                    return const LoadingWidget();
                  },
                ),
                const Align(alignment: Alignment.centerLeft, child: Text('BPM:')),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
                  child: Row(
                    children: [
                      Expanded(child: CommonInput(hintText: context.l10n.t_lower)),
                      const SizedBox(
                        width: kHorizontalSpacing,
                      ),
                      Expanded(child: CommonInput(hintText: context.l10n.t_higher))
                    ],
                  ),
                ),
                CommonButton(
                  color: AppColors.activeLabelItem,
                  text: context.l10n.t_apply,
                  onTap: () {
                    saveCacheFilter();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveCacheFilter() {
    _filterBloc.saveCacheFilter(_cacheFilter!);
  }
}
