import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class CreatePlayListRequest {
  String? title;
  String? description;
  String? imagePath;
  File? file;
  int? id;

  CreatePlayListRequest({
    this.title,
    this.description,
    this.imagePath,
    this.file,
    this.id,
  });

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};
    data['val[title]'] = title;
    data['val[description]'] = description;
    if (file != null) {
      data['image'] = await MultipartFile.fromFile(
        file!.path,
        contentType: MediaType('image', 'jpeg'),
      );
    }
    return data;
  }
}
