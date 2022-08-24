import 'package:audio_cult/app/data_source/models/responses/ticket/ticket.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'productlist.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TicketProductList {
  String? currency;
  bool? displayNetPrices;
  bool? showVariationsExpanded;
  bool? waitingListEnabled;
  String? voucherExplanationText;
  String? error;
  bool? cartExists;
  String? name;
  String? frontpageText;
  String? dateRange;
  List<ItemsByCategory>? itemsByCategory;
  bool? displayAddToCart;
  int? itemnum;
  bool? hasSeatingPlan;
  bool? vouchersExist;
  String? poweredby;

  TicketProductList(
      {this.currency,
      this.displayNetPrices,
      this.showVariationsExpanded,
      this.waitingListEnabled,
      this.voucherExplanationText,
      this.error,
      this.cartExists,
      this.name,
      this.frontpageText,
      this.dateRange,
      this.itemsByCategory,
      this.displayAddToCart,
      this.itemnum,
      this.hasSeatingPlan,
      this.vouchersExist,
      this.poweredby});
  factory TicketProductList.fromJson(Map<String, dynamic> json) => _$TicketProductListFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemsByCategory {
  int? id;
  String? name;
  String? description;
  List<Items>? items;

  ItemsByCategory({this.id, this.name, this.description, this.items});
  factory ItemsByCategory.fromJson(Map<String, dynamic> json) => _$ItemsByCategoryFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Items {
  int? id;
  String? name;
  String? picture;
  String? description;
  int? hasVariations;
  bool? requireVoucher;
  String? orderMin;
  int? orderMax;
  Price? price;
  String? minPrice;
  String? maxPrice;
  bool? allowWaitinglist;
  bool? freePrice;
  List<int>? avail;
  String? originalPrice;
  List<String>? variations;
  int? count;

  Items(
      {this.id,
      this.name,
      this.picture,
      this.description,
      this.hasVariations,
      this.requireVoucher,
      this.orderMin,
      this.orderMax,
      this.price,
      this.minPrice,
      this.maxPrice,
      this.allowWaitinglist,
      this.freePrice,
      this.avail,
      this.originalPrice,
      this.variations,
      this.count});
  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Price {
  String? gross;
  String? net;
  String? tax;
  String? rate;
  String? name;
  bool? includesMixedTaxRate;

  Price({this.gross, this.net, this.tax, this.rate, this.name, this.includesMixedTaxRate});
  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
