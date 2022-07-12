import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/features/my_cart/my_cart_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/datetime/date_time_utils.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/route/app_route.dart';
import 'package:audio_cult/app/utils/toast/toast_utils.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/buttons/common_button.dart';
import 'package:audio_cult/w_components/dashed_line_widget/dashed_line_widget.dart';
import 'package:audio_cult/w_components/error_empty/error_section.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

part 'cart_item_widget.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final _bloc = getIt.get<MyCartBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.loadAllCartItems();
    _bloc.exceptionStream.listen((exception) {
      ToastUtility.showError(message: exception.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: CommonAppBar(
        title: context.l10n.t_my_cart,
        actions: [_deleteCartButton()],
      ),
      body: BlocHandle(bloc: _bloc, child: SafeArea(child: _body())),
    );
  }

  Widget _deleteCartButton() {
    return StreamBuilder<List<Song>>(
      initialData: const [],
      stream: _bloc.removableItemStream,
      builder: (_, snapshot) {
        if (snapshot.data?.isNotEmpty != true && _bloc.cartItems.isEmpty) {
          return Container();
        } else if (snapshot.data?.isNotEmpty != true) {
          return _deleteAllButton();
        } else {
          final numberOfItems = snapshot.data?.length ?? 0;
          return _deleteSelectedItemsButton(numberOfItems);
        }
      },
    );
  }

  TextButton _deleteSelectedItemsButton(int numberOfItems) {
    return TextButton(
      onPressed: () => _showConfirmationDialog(
        context.l10n.t_are_you_sure_continue,
        goAhead: _bloc.removeCheckedItems,
      ),
      child: Text(
        '${context.l10n.t_delete} ${numberOfItems.toString()} ${numberOfItems == 1 ? context.l10n.t_song : context.l10n.t_songs}',
      ),
    );
  }

  TextButton _deleteAllButton() {
    return TextButton(
      onPressed: () => _showConfirmationDialog(
        context.l10n.t_are_you_sure_continue,
        goAhead: _bloc.clearCart,
      ),
      child: Text(context.l10n.t_clear_cart),
    );
  }

  void _showConfirmationDialog(String title, {required VoidCallback goAhead}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        content: Text(title),
        actions: [
          CupertinoDialogAction(
            onPressed: Navigator.of(context).pop,
            child: Text(
              context.l10n.t_no,
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              goAhead();
              Navigator.of(context).pop();
            },
            child: Text(
              context.l10n.t_yes,
              style: context.body1TextStyle()?.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(child: _listViewStreamBuilder()),
        _checkoutWidget(),
      ],
    );
  }

  Widget _listViewStreamBuilder() {
    return StreamBuilder<BlocState<List<Song>>>(
      initialData: BlocState.success(_bloc.cartItems),
      stream: _bloc.allCartItemsStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data;
          return state?.when(success: (data) {
                final songs = data as List<Song>;
                return RefreshIndicator(
                  onRefresh: () async => _bloc.loadAllCartItems(),
                  child: songs.isEmpty ? _emptyCartWidget() : _listView(songs),
                );
              }, loading: () {
                return const LoadingWidget();
              }, error: (error) {
                return ErrorSectionWidget(
                  errorMessage: error,
                  onRetryTap: _bloc.loadAllCartItems,
                );
              }) ??
              Container();
        }
        return Container();
      },
    );
  }

  ListView _listView(List<Song> songs) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CartItemWidget(
                songs[index],
                isChecked: _bloc.isSongRemovable(songs[index]),
                removableCheckboxOnChange: () => _bloc.addItemToRemovableList(songs[index]),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoute.routeDetailSong,
                    arguments: {'song_id': songs[index].songId},
                  );
                },
                currency: _bloc.currency ?? '',
              ),
            ),
        separatorBuilder: (_, index) => Divider(color: Colors.blueGrey.withAlpha(60)),
        itemCount: songs.length);
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
      initialData: BlocState.success(_bloc.cartItems),
      stream: _bloc.allCartItemsStream,
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
                          subTotal: _bloc.subTotal,
                          totalTax: _bloc.grandTotal - _bloc.subTotal,
                          grandTotal: _bloc.grandTotal,
                        ),
                        const SizedBox(height: 20),
                        _checkoutButton(),
                      ],
                    ),
                  );
                },
                loading: () => const LoadingWidget(),
                error: (error) => Container(),
              ) ??
              Container();
        }
        return const LoadingWidget();
      },
    );
  }

  Widget _totalPriceWidget({
    required double subTotal,
    required double totalTax,
    required double grandTotal,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _priceRowWidget(
            title: _bloc.cartItems.length == 1 ? context.l10n.t_song : context.l10n.t_songs,
            value: subTotal.toString()),
        const SizedBox(height: 20),
        _taxesWidget(totalTax),
        const LineDashedWidget(),
        const SizedBox(height: 20),
        _priceRowWidget(title: context.l10n.t_total, value: grandTotal.toString(), isHighlighted: true),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _taxesWidget(double totalTax) {
    return totalTax == 0
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _priceRowWidget(
              title: '${context.l10n.t_taxes} (${NumberFormat.compact().format(_bloc.taxes * 100)} %)',
              value: totalTax.toString(),
            ),
          );
  }

  Widget _priceRowWidget({required String title, required String value, bool isHighlighted = false}) {
    final formatCurrency = NumberFormat.compact();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.subtitleTextStyle(),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(formatCurrency.format(double.parse(value)),
                style: isHighlighted
                    ? context.headerStyle1()?.copyWith(fontWeight: FontWeight.w700, color: AppColors.persianGreen)
                    : context.subtitleTextStyle()),
            Text(' ${_bloc.currency}',
                style: isHighlighted
                    ? context.headerStyle()?.copyWith(color: AppColors.subTitleColor)
                    : context.subtitleTextStyle()?.copyWith(color: AppColors.subTitleColor)),
          ],
        )
      ],
    );
  }

  Widget _checkoutButton() {
    return CommonButton(
      color: AppColors.primaryButtonColor,
      text: context.l10n.t_checkout,
      onTap: () {
        // TODO: remove this when checkout done
        ToastUtility.showPending(context: context, message: "This feature is coming soon");
        _bloc.checkoutCart();
      },
    );
  }
}
