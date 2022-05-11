import 'package:audio_cult/app/features/atlas/atlas_screen.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatefulWidget {
  final String? userId;
  const SubscriptionsScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: CommonAppBar(
          backgroundColor: AppColors.mainColor,
          title: context.l10n.t_subscriptions,
        ),
        body: const AtlasScreen());
  }
}
