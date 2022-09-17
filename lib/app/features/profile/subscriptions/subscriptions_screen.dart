import 'package:audio_cult/app/features/atlas/atlas_screen.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';

import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatefulWidget {
  final String? userId;
  final String? getSubscribed;
  final String? title;
  const SubscriptionsScreen({Key? key, this.userId, this.getSubscribed, this.title}) : super(key: key);

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
        title: widget.title ?? context.localize.t_subscriptions,
      ),
      body: AtlasScreen(
        userId: widget.userId,
        getSubscribed: widget.getSubscribed,
      ),
    );
  }
}
