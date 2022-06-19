import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';

class MyCartBloc extends BaseBloc {
  final AppRepository _appRepo;
  List<Song>? _cartitems;
  double get totalPrice {
    final costs = _cartitems?.map((e) => double.parse(e.cost ?? '0')).toList() ?? [];
    final sum = costs.reduce((value, element) => value + element);
    return sum;
  }

  double get totalTaxes => 0;
  double get checkoutPrice => totalPrice + totalTaxes;

  final _totalCartItemsStreamController = StreamController<BlocState<List<Song>>>.broadcast();
  Stream<BlocState<List<Song>>> get totalCartItemStream => _totalCartItemsStreamController.stream;

  MyCartBloc(this._appRepo) {
    loadAllCartItems();
  }

  void loadAllCartItems() async {
    return _appRepo.getCartItems().then((result) {
      result.fold((l) {
        _cartitems = l.songs;
        _totalCartItemsStreamController.sink.add(BlocState.success(_cartitems ?? []));
      }, (r) {
        _totalCartItemsStreamController.sink.add(BlocState.error(r.toString()));
      });
    });
  }

  void deleteItem(String id) {
    if (id.isEmpty) return;
    showOverLayLoading();
    _deleteCartItem(
        itemIds: [id],
        completionHandler: (result) {
          hideOverlayLoading();
          if (!result) return;
          _cartitems?.removeWhere((element) => element.songId == id);
          _totalCartItemsStreamController.sink.add(BlocState.success(_cartitems ?? []));
        });
  }

  void deleteAllItems() {
    if (_cartitems?.isNotEmpty != true) return;
    showOverLayLoading();
    final allIds = _cartitems!.map<String>((e) => e.songId ?? '').toList();
    _deleteCartItem(
        itemIds: allIds,
        completionHandler: (result) {
          hideOverlayLoading();
          if (!result) return;
          _cartitems = [];
          _totalCartItemsStreamController.sink.add(const BlocState.success([]));
        });
  }

  void _deleteCartItem({required List<String> itemIds, required Function(bool) completionHandler}) async {
    final result = await _appRepo.deleteCartItems(itemIds);
    result.fold((l) => completionHandler(l), (r) => completionHandler(false));
  }

  void checkoutCart() {
    // TODO: checkout cart
  }
}
