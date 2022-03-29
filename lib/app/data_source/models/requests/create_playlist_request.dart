import 'dart:io';

class CreatePlayListRequest {
  final String? title;
  final File? file;

  CreatePlayListRequest({
    this.title,
    this.file,
  });
}
