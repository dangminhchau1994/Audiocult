// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:audio_cult/app/constants/app_assets.dart';
import 'package:audio_cult/app/constants/app_colors.dart';
import 'package:audio_cult/counter/counter.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/widgets/common_button.dart';
import 'package:audio_cult/widgets/common_checkbox.dart';
import 'package:audio_cult/widgets/common_input.dart';
import 'package:audio_cult/widgets/common_input_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: const Center(child: CounterText()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatefulWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  State<CounterText> createState() => _CounterTextState();
}

class _CounterTextState extends State<CounterText> {
  var isHidden = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return CommonInputTags(
      onChooseTag: (tag) {},
      onDeleteTag: (tag) {},
    );
  }
}
