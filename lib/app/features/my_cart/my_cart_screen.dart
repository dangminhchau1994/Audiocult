import 'dart:ui';

import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/my_cart/my_cart_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/view/no_data_widget.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/dashed_line_widget/dashed_line_widget.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'cart_item_widget.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final _bloc = getIt.get<MyCartBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.l10n.t_my_cart,
        actions: [_clearCartButton()],
      ),
      body: BlocHandle(bloc: _bloc, child: _body()),
    );
  }

  Widget _clearCartButton() {
    return StreamBuilder<BlocState<List<Song>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.totalCartItemStream,
      builder: (_, snapshot) {
        return snapshot.data?.when(
              success: (data) {
                final songs = data as List<Song>;
                return songs.isEmpty
                    ? Container()
                    : TextButton(onPressed: _bloc.deleteAllItems, child: Text(context.l10n.t_clear_cart));
              },
              loading: Container.new,
              error: (_) => Container(),
            ) ??
            Container();
      },
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(child: _listView()),
        _checkoutWidget(),
      ],
    );
  }

  Widget _listView() {
    return StreamBuilder<BlocState<List<Song>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.totalCartItemStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data;
          return state?.when(success: (data) {
                final songs = data as List<Song>;
                return RefreshIndicator(
                  onRefresh: () async => _bloc.loadAllCartItems(),
                  child: songs.isEmpty
                      ? _emptyCartWidget()
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemBuilder: (_, index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: CartItemWidget(
                                  songs[index],
                                  deleteButtonOnTap: () => _bloc.deleteItem(songs[index].songId ?? ''),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoute.routeDetailSong,
                                      arguments: {'song_id': songs[index].songId},
                                    );
                                  },
                                ),
                              ),
                          separatorBuilder: (_, index) => Divider(color: Colors.blueGrey.withAlpha(60)),
                          itemCount: songs.length),
                );
              }, loading: () {
                return const LoadingWidget();
              }, error: (error) {
                return ErrorSectionWidget(
                  errorMessage: error,
                  onRetryTap: () {},
                );
              }) ??
              Container();
        }
        return Container();
      },
    );
  }

  Widget _emptyCartWidget() {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.icCart),
                const SizedBox(height: 20),
                Text(context.l10n.t_cart_empty),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _checkoutWidget() {
    return StreamBuilder<BlocState<List<Song>>>(
      initialData: const BlocState.loading(),
      stream: _bloc.totalCartItemStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data;
          return state?.when(
                  success: (data) {
                    final songs = data as List<Song>;
                    if (songs.isEmpty) return Container();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: Column(
                        children: [
                          _totalPriceWidget(
                            totalPrice: _bloc.totalPrice,
                            totalTax: _bloc.totalTaxes,
                            checkoutPrice: _bloc.checkoutPrice,
                          ),
                          const SizedBox(height: 20),
                          _checkoutButton(),
                        ],
                      ),
                    );
                  },
                  loading: () => const LoadingWidget(),
                  error: (error) {
                    return ErrorSectionWidget(
                      errorMessage: error,
                      onRetryTap: () {},
                    );
                  }) ??
              Container();
        }
        return const LoadingWidget();
      },
    );
  }

  Widget _totalPriceWidget({
    required double totalPrice,
    required double totalTax,
    required double checkoutPrice,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _totalPriceRowWidget(title: context.l10n.t_tickets, value: totalPrice.toString()),
        const SizedBox(height: 20),
        _totalPriceRowWidget(title: context.l10n.t_taxes, value: totalTax.toString()),
        const SizedBox(height: 20),
        const LineDashedWidget(),
        const SizedBox(height: 28),
        _totalPriceRowWidget(title: context.l10n.t_total, value: checkoutPrice.toString()),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _totalPriceRowWidget({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.subtitleTextStyle()?.copyWith(color: AppColors.subTitleColor),
        ),
        Row(
          children: [
            Text(value, style: context.subtitleTextStyle()),
            // Text('.00 AED', style: context.subtitleTextStyle()?.copyWith(color: AppColors.subTitleColor)),
          ],
        )
      ],
    );
  }

  Widget _checkoutButton() {
    return CommonButton(
      color: AppColors.primaryButtonColor,
      text: context.l10n.t_checkout,
      onTap: _bloc.checkoutCart,
    );
  }
}
