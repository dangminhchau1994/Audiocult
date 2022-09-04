import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Ticket {
  String? name;
  String? price;
  String? availableFrom;
  String? availableUntil;

  Ticket({this.name, this.price, this.availableFrom, this.availableUntil});

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}
