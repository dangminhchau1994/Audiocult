class TicketInfoPaymentRequest {
  String? email;
  String? phone;
  String? nationality;
  String? givenName;
  String? familyName;

  Map<String, dynamic> toJson(Map<String, dynamic> body) {
    final data = <String, dynamic>{};

    data['email'] = email;
    data['phone'] = phone;
    data['DTCMcountry'] = nationality;
    data['name_parts_0'] = givenName;
    data['name_parts_1'] = familyName;
    data.addAll(body);
    return data;
  }
}
