// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      name: json['name'] as String?,
      price: json['price'] as String?,
      availableFrom: json['available_from'] as String?,
      availableUntil: json['available_until'] as String?,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'available_from': instance.availableFrom,
      'available_until': instance.availableUntil,
    };
