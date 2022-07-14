import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';

class MyCartBloc extends BaseBloc {
  final AppRepository _appRepo;
  List<Song> _cartItems = [];
  List<Song> _removeItems = [];
  double? _taxes;
  String? _currency;
  double? _subTotal;
  double? _grandTotal;

  double get grandTotal => _grandTotal ?? 0;
  List<Song> get cartItems => _cartItems;
  List<Song> get removableItems => _removeItems;
  double get taxes => (_taxes ?? 0) / 100;
  String? get currency => _currency;
  double get subTotal => _subTotal ?? 0;

  final _allCartItemsStreamController = StreamController<BlocState<List<Song>>>.broadcast();
  Stream<BlocState<List<Song>>> get allCartItemsStream => _allCartItemsStreamController.stream;

  final _removableItemsStreamController = StreamController<List<Song>>.broadcast();
  Stream<List<Song>> get removableItemStream => _removableItemsStreamController.stream;

  final _exceptionStreamController = StreamController<Exception>.broadcast();
  Stream<Exception> get exceptionStream => _exceptionStreamController.stream;

  MyCartBloc(this._appRepo);

  void loadAllCartItems() async {
    _removeItems = [];
    _removableItemsStreamController.sink.add([]);
    showOverLayLoading();
    await _appRepo.getCartItems().then((result) {
      result.fold((l) {
        hideOverlayLoading();
        _cartItems = l.songs ?? [];
        _taxes = l.tax;
        _currency = _appRepo.getCurrency();

        _subTotal = l.subTotal;
        _grandTotal = l.grandTotal;
        _allCartItemsStreamController.sink.add(BlocState.success(_cartItems));
      }, (r) {
        hideOverlayLoading();
        _allCartItemsStreamController.sink.add(BlocState.error(r.toString()));
      });
    });
  }

  void addCartItem(Song song) async {
    if (song.songId?.isNotEmpty != true) return;
    if (isSongAlreadyAdded(song)) return;
    _cartItems.add(song);
    _allCartItemsStreamController.sink.add(BlocState.success(_cartItems));
  }

  bool isSongAlreadyAdded(Song song) {
    final ids = _cartItems.map((e) => e.songId).toList();
    return ids.contains(song.songId ?? '');
  }

  bool isSongRemovable(Song song) {
    final ids = _removeItems.map((e) => e.songId).toList();
    return ids.contains(song.songId ?? '');
  }

  void removeCheckedItems() {
    showOverLayLoading();
    final ids = _removeItems.map<String>((e) => e.songId ?? '').toList();
    _deleteCartItem(itemIds: ids);
  }

  void clearCart() {
    if (_cartItems.isNotEmpty != true) return;
    showOverLayLoading();
    _removeItems = _cartItems;
    final ids = _removeItems.map<String>((e) => e.songId ?? '').toList();
    _deleteCartItem(itemIds: ids);
  }

  void _deleteCartItem({required List<String> itemIds}) async {
    final result = await _appRepo.deleteCartItems(itemIds);
    result.fold((l) {
      if (_removeItems.length == _cartItems.length) {
        _cartItems = [];
        _allCartItemsStreamController.sink.add(BlocState.success(_cartItems));
      }
      _removeItems = [];
      _removableItemsStreamController.sink.add([]);
      loadAllCartItems();
      hideOverlayLoading();
    }, (r) {
      hideOverlayLoading();
      _exceptionStreamController.sink.add(r);
    });
  }

  void addItemToRemovableList(Song song) {
    if (song.songId?.isNotEmpty != true) return;
    final ids = _removeItems.map((e) => e.songId).toList();
    if (ids.contains(song.songId)) {
      _removeItems.removeWhere((element) => element.songId == song.songId);
    } else {
      _removeItems.add(song);
    }
    _removableItemsStreamController.sink.add(_removeItems);
    _allCartItemsStreamController.sink.add(BlocState.success(_cartItems));
  }

  void checkoutCart() {
    _cartItems = [];
    _removeItems = [];
    // TODO: checkout cart
  }
}
