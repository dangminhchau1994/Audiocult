import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/terms/terms_response.dart';
import 'package:audio_cult/app/features/terms/terms_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../w_components/error_empty/error_section.dart';
import '../../utils/constants/app_colors.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  final _bloc = TermsBloc(locator.get());

  @override
  void initState() {
    super.initState();
    _bloc.getTerms('terms');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.localize.t_term,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHorizontalSpacing,
          vertical: kVerticalSpacing,
        ),
        child: StreamBuilder<BlocState<TermsResponse>>(
          initialData: const BlocState.loading(),
          stream: _bloc.getTermsStream,
          builder: (context, snapshot) {
            final state = snapshot.data!;

            return state.when(
              success: (data) {
                final terms = data as TermsResponse;

                return Scrollbar(
                  child: ListView(
                    children: [
                      Html(
                        data: terms.text,
                      ),
                    ],
                  ),
                );
              },
              loading: () {
                return const Center(
                  child: LoadingWidget(),
                );
              },
              error: (err) {
                return ErrorSectionWidget(
                  errorMessage: err,
                  onRetryTap: () {
                    _bloc.getTerms('terms');
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
