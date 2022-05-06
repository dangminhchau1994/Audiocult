import 'package:audio_cult/w_components/error_empty/widget_state.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Expanded(child: EmptyDataStateWidget(null)),
          ),
        ),
      ],
    );
  }
}
