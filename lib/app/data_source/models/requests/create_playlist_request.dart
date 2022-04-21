import 'dart:io';

class CreatePlayListRequest {
  String? title;
  String? description;
  File? file;

  CreatePlayListRequest({
    this.title,
    this.description,
    this.file,
  });
}
