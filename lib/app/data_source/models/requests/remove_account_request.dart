class RemoveAccountRequest {
  String? text;
  String? password;

  RemoveAccountRequest({
    this.text,
    this.password,
  });

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};

    data['val[feedback_text]'] = text;
    data['val[password]'] = password;

    return data;
  }
}
