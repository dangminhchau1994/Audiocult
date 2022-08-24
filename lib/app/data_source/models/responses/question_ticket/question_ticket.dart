import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QuestionTicket {
  String? event;
  List<ContactForm>? contactForm;
  String? reverseChargeRelevant;
  List<Cart>? cart;
  String? cartSession;
  String? invoiceAddressAsked;
  ItemQuestions? itemQuestions;

  QuestionTicket(
      {this.event,
      this.contactForm,
      this.reverseChargeRelevant,
      this.cart,
      this.cartSession,
      this.invoiceAddressAsked});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemQuestions {
  ItemTicketQuestion? item;
  List<QuestionsTicketPayment>? questions;

  ItemQuestions({this.item, this.questions});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class QuestionsTicketPayment {
  String? name;
  String? label;
  bool? required;
  String? initial;
  String? helpText;
  String? type;
  List<FieldParts>? fieldParts;

  QuestionsTicketPayment(
      {this.name, this.label, this.required, this.initial, this.helpText, this.type, this.fieldParts});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FieldParts {
  String? label;
  bool? required;
  String? initial;
  String? helpText;
  String? type;
  int? maxLength;
  bool? multiline;

  FieldParts({this.label, this.required, this.initial, this.helpText, this.type, this.maxLength, this.multiline});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemTicketQuestion {
  String? str;
  String? name;
  String? description;
  String? defaultPrice;
  String? price;
  bool? admission;

  ItemTicketQuestion({this.str, this.name, this.description, this.defaultPrice, this.price, this.admission});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ContactForm {
  String? name;
  String? label;
  bool? required;
  String? initial;
  String? helpText;
  String? type;
  List<List<String>>? choices;

  ContactForm({this.name, this.label, this.required, this.initial, this.helpText, this.type, this.choices});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Cart {
  int? id;
  String? name;
  String? description;
  String? defaultPrice;
  String? price;
  bool? admission;
  int? count;

  Cart({this.id, this.name, this.description, this.defaultPrice, this.price, this.admission, this.count});
}
