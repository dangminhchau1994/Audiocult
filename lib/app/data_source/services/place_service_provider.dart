import 'dart:io';

import 'package:audio_cult/app/data_source/models/responses/place.dart';
import 'package:audio_cult/app/features/auth/widgets/register_page.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../../utils/extensions/app_extensions.dart';
import '../models/base_response.dart';
import '../networks/core/dio_helper.dart';

class PlaceServiceProvider {
  late DioHelper _dioHelper;

  PlaceServiceProvider(Dio dio) {
    _dioHelper = DioHelper(dio);
  }

  static const String androidKey = 'AIzaSyCq_ewBkTd_Ptlva35RYyHJU7oBYCGhMpY';
  static const String iosKey = 'AIzaSyCq_ewBkTd_Ptlva35RYyHJU7oBYCGhMpY';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final response = await _dioHelper.get(
      route:
          '/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&key=$apiKey&sessiontoken=${const Uuid().v4()}',
      responseBodyMapper: (jsonMap) => BaseRes.fromJson(jsonMap as Map<String, dynamic>),
    );
    return response.mapData(
      (json) => asType<List<dynamic>>(json)
          ?.map((p) => Suggestion(p['place_id'] as String, p['description'] as String))
          .toList(),
    );
  }

  Future<Place?> getPlaceDetailFromId(String placeId) async {
    final response = await _dioHelper.get(
      route:
          '/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=${const Uuid().v4()}',
    );
    final data = response['result']['address_components'] as List;
    final place = Place();
    // ignore: avoid_function_literals_in_foreach_calls
    data.forEach((c) {
      final type = c['types'] as List;
      if (type.contains('administrative_area_level_1')) {
        place.city = c['long_name'] as String;
      }
      if (type.contains('country')) {
        place.zipCode = c['short_name'] as String;
      }
    });
    return place;
  }
}
