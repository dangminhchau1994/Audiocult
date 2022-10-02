import 'package:audio_cult/app/base/index_walker.dart';

class TicketDetails {
  String? details;
  String? ticketSecret;
  String? status;
  String? qrCode;
  String? dateFrom;
  String? dateTo;
  String? currency;
  String? price;
  String? ticketName;
  String? orderCode;
  String? statusCode;
  int? eventId;

  TicketDetails.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    details = iw['details'].get();
    ticketSecret = iw['ticket_secret'].get();
    status = iw['status'].get();
    qrCode = iw['qr'].get();
    dateFrom = iw['date_from'].get();
    dateTo = iw['date_to'].get();
    currency = iw['currency'].get();
    price = iw['price'].get();
    ticketName = iw['ticket_name'].get();
    orderCode = iw['order_code'].get();
    statusCode = iw['status_code'].get();
    eventId = iw['event_id'].get();
  }

  DateTime? get dateTimeFrom {
    return DateTime.tryParse(dateFrom ?? '');
  }

  DateTime? get dateTimeTo {
    return DateTime.tryParse(dateTo ?? '');
  }
}
