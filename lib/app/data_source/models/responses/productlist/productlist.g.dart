// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketProductList _$TicketProductListFromJson(Map<String, dynamic> json) => TicketProductList(
      currency: json['currency'] as String?,
      displayNetPrices: json['display_net_prices'] as bool?,
      showVariationsExpanded: json['show_variations_expanded'] as bool?,
      waitingListEnabled: json['waiting_list_enabled'] as bool?,
      voucherExplanationText: json['voucher_explanation_text'] as String?,
      error: json['error'] as String?,
      cartExists: json['cart_exists'] as bool?,
      name: json['name'] as String?,
      frontpageText: json['frontpage_text'] as String?,
      dateRange: json['date_range'] as String?,
      itemsByCategory: (json['items_by_category'] as List<dynamic>?)
          ?.map((e) => ItemsByCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      displayAddToCart: json['display_add_to_cart'] as bool?,
      itemnum: json['itemnum'] as int?,
      hasSeatingPlan: json['has_seating_plan'] as bool?,
      vouchersExist: json['vouchers_exist'] as bool?,
      poweredby: json['poweredby'] as String?,
    );

Map<String, dynamic> _$TicketProductListToJson(TicketProductList instance) => <String, dynamic>{
      'currency': instance.currency,
      'display_net_prices': instance.displayNetPrices,
      'show_variations_expanded': instance.showVariationsExpanded,
      'waiting_list_enabled': instance.waitingListEnabled,
      'voucher_explanation_text': instance.voucherExplanationText,
      'error': instance.error,
      'cart_exists': instance.cartExists,
      'name': instance.name,
      'frontpage_text': instance.frontpageText,
      'date_range': instance.dateRange,
      'items_by_category': instance.itemsByCategory,
      'display_add_to_cart': instance.displayAddToCart,
      'itemnum': instance.itemnum,
      'has_seating_plan': instance.hasSeatingPlan,
      'vouchers_exist': instance.vouchersExist,
      'poweredby': instance.poweredby,
    };

ItemsByCategory _$ItemsByCategoryFromJson(Map<String, dynamic> json) => ItemsByCategory(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      items: (json['items'] as List<dynamic>?)?.map((e) => Items.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$ItemsByCategoryToJson(ItemsByCategory instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
    id: json['id'] as int?,
    name: json['name'] as String?,
    picture: json['picture'] as String?,
    description: json['description'] as String?,
    hasVariations: json['has_variations'] as int?,
    requireVoucher: json['require_voucher'] as bool?,
    orderMin: json['order_min'] as String?,
    orderMax: json['order_max'] as int?,
    price: json['price'] == null ? null : Price.fromJson(json['price'] as Map<String, dynamic>),
    minPrice: json['min_price'] as String?,
    maxPrice: json['max_price'] as String?,
    allowWaitinglist: json['allow_waitinglist'] as bool?,
    freePrice: json['free_price'] as bool?,
    avail: (json['avail'] as List<dynamic>?)?.map((e) => e != null ? e as int : 0).toList(),
    originalPrice: json['original_price'] as String?,
    variations: (json['variations'] as List<dynamic>?)?.map((e) => e as String).toList(),
    count: 0,
    eventTitle: '',
    imagePath: '');

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'description': instance.description,
      'has_variations': instance.hasVariations,
      'require_voucher': instance.requireVoucher,
      'order_min': instance.orderMin,
      'order_max': instance.orderMax,
      'price': instance.price,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'allow_waitinglist': instance.allowWaitinglist,
      'free_price': instance.freePrice,
      'avail': instance.avail,
      'original_price': instance.originalPrice,
      'variations': instance.variations,
      'count': instance.count
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      gross: json['gross'] as String?,
      net: json['net'] as String?,
      tax: json['tax'] as String?,
      rate: json['rate'] as String?,
      name: json['name'] as String?,
      includesMixedTaxRate: json['includes_mixed_tax_rate'] as bool?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'gross': instance.gross,
      'net': instance.net,
      'tax': instance.tax,
      'rate': instance.rate,
      'name': instance.name,
      'includes_mixed_tax_rate': instance.includesMixedTaxRate,
    };
