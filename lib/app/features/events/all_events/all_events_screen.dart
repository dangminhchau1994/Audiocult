import 'package:audio_cult/app/features/events/all_events/widgets/all_events.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/popular_events.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/show_events.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:flutter/material.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({Key? key}) : super(key: key);

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: kVerticalSpacing,
            horizontal: kHorizontalSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShowEvents(),
              SizedBox(height: 40),
              PopularEvents(),
              SizedBox(height: 20),
              AllEvents(),
            ],
          ),
        ),
      ),
    );
  }
}
