enum ValueType { isMap, isList, isString, isNum, isBool, isNull, unknown }

typedef KeyBuilder<T> = T? Function(dynamic value);
typedef ItemBuilder<T> = T? Function(IW data);
typedef RawItemBuilder<T> = T? Function(dynamic values);
typedef MapItemBuilder<K, T> = T? Function(IW data, K? key);
typedef RawMapItemBuilder<K, T> = T? Function(dynamic values, K? key);

/// Data access with type conversion, it is convenient to use when parsing JSON.
///
/// Examples:
/// ```
/// final jsonResponse = jsonDecode(response);
/// final data = DynamicValue(jsonResponse);
/// data['message']['id'].toInt
/// data['message']['text'].toStr
/// data['message']['timestamp'].toDateTime
/// data['message']['tags'][0]['text'].toStr
/// ```
class IW {
  /// Type converters from raw data type
  static Map<Type, dynamic Function(dynamic value)> rawBuilders = {
    num: _parseNum,
    int: _parseInt,
    double: _parseDouble,
    bool: _parseBool,
    String: (dynamic value) => '$value',
    DateTime: _parseDateTime,
  };

  /// Type converters from DynamicValue type
  static Map<Type, dynamic Function(IW data)> builders = {};

  /// Raw type
  final dynamic value;

  ValueType? _type;

  ValueType get type {
    if (_type == null) {
      _type = ValueType.unknown;
      if (value is Map) {
        _type = ValueType.isMap;
      } else if (value is List) {
        _type = ValueType.isList;
      } else if (value is String) {
        _type = ValueType.isString;
      } else if (value is num) {
        _type = ValueType.isNum;
      } else if (value is bool) {
        _type = ValueType.isBool;
      } else if (value == null) {
        _type = ValueType.isNull;
      }
    }
    return _type ?? ValueType.unknown;
  }

  /// Creates an instance of the DynamicValue by wrapping the value.
  IW(this.value);

  static final IW _nullValue = IW(null);

  /// Returns true if value is null.
  bool get isNull => value == null;

  /// Returns true if value is not null.
  bool get isNotNull => value != null;

  @override
  String toString() {
    return '$value';
  }

  T? _get<T>(
    IW value,
    dynamic rawValue, {
    T? defaultValue,
    ItemBuilder<T>? builder,
    RawItemBuilder<T>? rawBuilder,
  }) {
    // ignore: prefer_asserts_with_message
    assert(builder == null || rawBuilder == null);

    if (rawValue == null) return defaultValue;

    final type = T;
    T? result;

    if (rawValue.runtimeType != type) {
      if (builder != null) {
        result = builder.call(value);
      } else if (rawBuilder != null) {
        result = rawBuilder.call(rawValue);
      } else {
        if (builders.containsKey(type)) {
          result = builders[type]!.call(value) as T?;
        } else if (rawBuilders.containsKey(type)) {
          result = rawBuilders[type]!.call(rawValue) as T?;
        }
      }
    } else {
      result = rawValue as T;
    }
    return result ?? defaultValue;
  }

  /// Convert value to T type
  T? get<T>({
    T? defaultValue,
    ItemBuilder<T>? builder,
    RawItemBuilder<T>? rawBuilder,
  }) {
    return _get<T>(
      this,
      value,
      defaultValue: defaultValue,
      builder: builder,
      rawBuilder: rawBuilder,
    );
  }

  /// Convert value to List of T types
  ///
  /// If the value is not [Iterable] or [Map], the [defaultValue] will be returned.
  /// If the value is a [Map], a list of map values, casted to the required type, will be returned.
  ///
  List<T>? getList<T>({
    List<T>? defaultValue,
    ItemBuilder<T>? itemBuilder,
    RawItemBuilder<T>? itemRawBuilder,
  }) {
    // ignore: prefer_asserts_with_message
    assert(itemBuilder == null || itemRawBuilder == null);

    dynamic list = value;
    if (list is Map) list = value.values;
    if (list is! Iterable) return defaultValue;

    final result = list
        .map(
          (entry) => _get<T>(
            IW(entry),
            entry,
            builder: itemBuilder,
            rawBuilder: itemRawBuilder,
          ),
        )
        .cast<T>()
        .toList();

    return result;
  }

  T? _defaultKeyBuilder<T>(dynamic value, [T? defaultValue]) {
    final type = T;
    T? result;

    if (value.runtimeType != type) {
      if (rawBuilders.containsKey(type)) {
        result = rawBuilders[type]!.call(value) as T?;
      }
    } else {
      result = value as T;
    }

    return result ?? defaultValue;
  }

  /// Convert value to typed Map
  Map<K, V?>? getMap<K, V>({
    Map<K, V>? defaultValue,
    KeyBuilder<K>? keyBuilder,
    MapItemBuilder<K, V>? valueBuilder,
    RawMapItemBuilder<K, V>? valueRawBuilder,
  }) {
    // ignore: prefer_asserts_with_message
    assert(valueBuilder == null || valueRawBuilder == null);

    if (value is! Map) return defaultValue;

    final result = (value as Map).map<K, V?>((key, value) {
      final newKey = (keyBuilder != null) ? keyBuilder.call(key) : _defaultKeyBuilder<K>(key);
      if (newKey == null) {
        throw DynamicValueNullKeyException();
      }

      final newValue = _get<V>(
        IW(value),
        value,
        builder: (valueBuilder != null) ? (v) => valueBuilder(v, newKey) : null,
        rawBuilder: (valueRawBuilder != null) ? (v) => valueRawBuilder(v, newKey) : null,
      );

      final newEntry = MapEntry<K, V?>(
        newKey,
        newValue,
      );
      return newEntry;
    });

    return result;
  }

  String? get getString => get<String>();

  num? get getNum => get<num>();

  int? get getInt => get<int>();

  double? get getDouble => get<double>();

  bool get getBool => get<bool>(defaultValue: false)!;

  DateTime? get getDateTime => get<DateTime>();

  /// Returns the DynamicValue for the given key or DynamicValue(null) if key is not in the map.
  ///
  /// The key can be an index in a list or a string key in a map.
  IW operator [](dynamic key) {
    if (key is int) {
      // List index
      if (value is List) {
        final list = value as List;
        return (key < list.length && key >= 0) ? IW(list[key]) : _nullValue;
      } else {
        return _nullValue;
      }
    } else if (key is String) {
      // Map key
      if (value is Map) {
        final map = value as Map;
        return map.keys.contains(key) ? IW(map[key]) : _nullValue;
      } else {
        return _nullValue;
      }
    }
    return _nullValue;
  }

  /// Returns true if this map contains the given key or index.
  ///
  /// The key can be an index in a list or a string key in a map.
  bool has(dynamic key) {
    if (key is int) {
      // List index
      if (value is List) {
        final list = value as List;
        return list.contains(key);
      } else {
        return false;
      }
    } else if (key is String) {
      // Map key
      if (value is Map) {
        final map = value as Map;
        return map.keys.contains(key);
      } else {
        return false;
      }
    }
    return false;
  }

  // --- Converters

  static num? _parseNum(dynamic value) {
    if (value is num) {
      return value;
    } else if (value is int) {
      return value;
    } else if (value is double) {
      return value;
    } else if (value is bool) {
      return value ? 1 : 0;
    } else if (value is String) {
      return num.tryParse(value);
    } else {
      return null;
    }
  }

  static int? _parseInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is num) {
      return value.toInt();
    } else if (value is bool) {
      return value ? 1 : 0;
    } else if (value is String) {
      return int.tryParse(value);
    } else {
      return null;
    }
  }

  static double? _parseDouble(dynamic value) {
    if (value is double) {
      return value;
      // ignore: avoid_double_and_int_checks
    } else if (value is int) {
      return value.toDouble();
    } else if (value is num) {
      return value.toDouble();
    } else if (value is bool) {
      return value ? 1 : 0;
    } else if (value is String) {
      return double.tryParse(value);
    } else {
      return null;
    }
  }

  static bool? _parseBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if ((value is num) || (value is int) || (value is double)) {
      // ignore: avoid_bool_literals_in_conditional_expressions
      return (value == 0) ? false : true;
    } else if (value is String) {
      final parsed = num.tryParse(value);
      // ignore: avoid_bool_literals_in_conditional_expressions
      return (parsed != null) ? (parsed == 0 ? false : true) : (value.trim().toLowerCase() == 'true');
    } else {
      return null;
    }
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value is DateTime) {
      return value;
    } else if (value is String) {
      return DateTime.tryParse(value);
    } else {
      return null;
    }
  }
}

class DynamicValueNullKeyException implements Exception {
  @override
  String toString() => 'Exception: The key cannot be null.';
}
