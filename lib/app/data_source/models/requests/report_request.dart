class ReportRequest {
  int? reasonId;
  int? itemId;
  String? type;
  String? feedBack;

  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};

    data['val[reason_id]'] = reasonId;
    data['val[item_id]'] = itemId;
    data['val[type]'] = type;
    data['val[feedback]'] = feedBack;

    return data;
  }
}
