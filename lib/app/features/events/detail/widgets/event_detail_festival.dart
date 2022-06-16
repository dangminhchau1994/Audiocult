import 'package:audio_cult/app/features/events/detail/event_detail_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/w_components/buttons/w_button_inkwell.dart';
import 'package:flutter/material.dart';

import '../../../../../di/bloc_locator.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../base/bloc_state.dart';
import '../../../../data_source/models/requests/event_request.dart';
import '../../../../data_source/models/responses/events/event_category_response.dart';
import '../../../../utils/route/app_route.dart';

class EventDetailFestiVal extends StatefulWidget {
  const EventDetailFestiVal({
    Key? key,
    this.category,
  }) : super(key: key);

  final String? category;

  @override
  State<EventDetailFestiVal> createState() => _EventDetailFestiValState();
}

class _EventDetailFestiValState extends State<EventDetailFestiVal> {
  @override
  void initState() {
    super.initState();
    getIt<EventDetailBloc>().getEventCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 280,
      right: 25,
      child: widget.category != null
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryButtonColor,
              ),
              padding: const EdgeInsets.all(14),
              child: StreamBuilder<BlocState<List<EventCategoryResponse>>>(
                initialData: const BlocState.loading(),
                stream: getIt<EventDetailBloc>().getEventCategoriesStream,
                builder: (context, snapshot) {
                  final state = snapshot.data!;

                  return state.when(
                    success: (success) {
                      final data = success as List<EventCategoryResponse>;
                      String? categoryId;

                      for (final item in data) {
                        if (item.name == widget.category) {
                          categoryId = item.categoryId;
                          break;
                        }
                      }

                      return WButtonInkwell(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.routeResultEvent,
                            arguments: {
                              'event_result': EventRequest(
                                categoryId: int.parse(categoryId ?? ''),
                              ),
                            },
                          );
                        },
                        child: Text(
                          widget.category ?? '',
                          style: context.bodyTextPrimaryStyle()!.copyWith(
                                color: AppColors.activeLabelItem,
                                fontSize: 16,
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
                        onRetryTap: () {
                          getIt<EventDetailBloc>().getEventCategories();
                        },
                      );
                    },
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }
}
