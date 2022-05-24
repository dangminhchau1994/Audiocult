import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/features/auth/resent_password/resent_bloc.dart';
import 'package:audio_cult/app/features/auth/resent_password/resent_password_screen.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../w_components/buttons/common_button.dart';
import '../../../../w_components/textfields/common_input.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_dimens.dart';

class ResentPasswordPage extends StatefulWidget {
  const ResentPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResentPasswordPage> createState() => _ResentPasswordPageState();
}

class _ResentPasswordPageState extends State<ResentPasswordPage> {
  final ResentPasswordBloc _resentPasswordBloc = ResentPasswordBloc(locator.get());
  String _email = '';
  @override
  void initState() {
    super.initState();
    _resentPasswordBloc.navigateMainStream.listen((event) {
      if (event) {
        Navigator.pushNamed(context, AppRoute.routeCheckEmail);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocHandle(
      bloc: _resentPasswordBloc,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: kVerticalSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
              child: Text(
                context.l10n.t_resent_password,
                style: context.headerStyle()?.copyWith(),
              ),
            ),
            Text(
              context.l10n.t_sub_resent_password,
              style: context.bodyTextStyle()?.copyWith(color: AppColors.unActiveLabelItem),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kVerticalSpacing),
              child: CommonInput(
                hintText: context.l10n.t_email,
                onChanged: (v) {
                  setState(() {
                    _email = v;
                  });
                },
              ),
            ),
            CommonButton(
              color: AppColors.activeLabelItem,
              text: context.l10n.t_submit,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                _resentPasswordBloc.resentEmail(_email);
              },
            )
          ],
        ),
      ),
    );
  }
}
