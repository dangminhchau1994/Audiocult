import 'package:flutter/material.dart';

import '../../../../../di/bloc_locator.dart';
import '../../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../../w_components/error_empty/error_section.dart';
import '../../../../base/bloc_state.dart';
import '../../../../data_source/models/responses/background/background_response.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../home_bloc.dart';
import '../../widgets/background_item.dart';

class StatusListBackground extends StatelessWidget {
  const StatusListBackground({
    Key? key,
    this.onShowBackground,
    this.onBackgroundItemClick,
  }) : super(key: key);

  final Function()? onShowBackground;
  final Function(BackgroundsList data)? onBackgroundItemClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          WButtonInkwell(
            onPressed: onShowBackground,
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
                          onBackgroundItemClick!(data);
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
    );
  }
}
