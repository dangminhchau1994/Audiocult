import 'package:freezed_annotation/freezed_annotation.dart';
part 'question_ticket.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QuestionTicket {
  String? event;
  List<ContactForm>? contactForm;
  String? reverseChargeRelevant;
  List<Cart>? cart;
  String? cartSession;
  String? invoiceAddressAsked;
  List<ItemQuestions>? itemQuestions;

  QuestionTicket(
      {this.event,
      this.contactForm,
      this.reverseChargeRelevant,
      this.cart,
      this.cartSession,
      this.invoiceAddressAsked});
  factory QuestionTicket.fromJson(Map<String, dynamic> json) => _$QuestionTicketFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemQuestions {
  String? id;
  ItemTicketQuestion? item;
  List<QuestionsTicketPayment>? questions;
  String? name;

  ItemQuestions({this.id, this.item, this.questions, this.name});
  factory ItemQuestions.fromJson(Map<String, dynamic> json) => _$ItemQuestionsFromJson(json);
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
  factory QuestionsTicketPayment.fromJson(Map<String, dynamic> json) => _$QuestionsTicketPaymentFromJson(json);
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
  factory FieldParts.fromJson(Map<String, dynamic> json) => _$FieldPartsFromJson(json);
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
  factory ItemTicketQuestion.fromJson(Map<String, dynamic> json) => _$ItemTicketQuestionFromJson(json);
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
  factory ContactForm.fromJson(Map<String, dynamic> json) => _$ContactFormFromJson(json);
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
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
