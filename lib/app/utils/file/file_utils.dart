import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class FileUtils {
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    final fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  static Future<String> getJsonFile(String path) {
    return rootBundle.loadString(path);
  }
}