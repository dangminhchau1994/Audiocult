// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionTicket _$QuestionTicketFromJson(Map<String, dynamic> json) =>
    QuestionTicket(
      event: json['event'] as String?,
      contactForm: (json['contact_form'] as List<dynamic>?)
          ?.map((e) => ContactForm.fromJson(e as Map<String, dynamic>))
          .toList(),
      reverseChargeRelevant: json['reverse_charge_relevant'] as String?,
      cart: (json['cart'] as List<dynamic>?)
          ?.map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
      cartSession: json['cart_session'] as String?,
      invoiceAddressAsked: json['invoice_address_asked'] as String?,
    )..itemQuestions = (json['item_questions'] as List<dynamic>?)
        ?.map((e) => ItemQuestions.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$QuestionTicketToJson(QuestionTicket instance) =>
    <String, dynamic>{
      'event': instance.event,
      'contact_form': instance.contactForm,
      'reverse_charge_relevant': instance.reverseChargeRelevant,
      'cart': instance.cart,
      'cart_session': instance.cartSession,
      'invoice_address_asked': instance.invoiceAddressAsked,
      'item_questions': instance.itemQuestions,
    };

ItemQuestions _$ItemQuestionsFromJson(Map<String, dynamic> json) =>
    ItemQuestions(
      id: json['id'] as String?,
      item: json['item'] == null
          ? null
          : ItemTicketQuestion.fromJson(json['item'] as Map<String, dynamic>),
      questions: (json['questions'] as List<dynamic>?)
          ?.map(
              (e) => QuestionsTicketPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ItemQuestionsToJson(ItemQuestions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
      'questions': instance.questions,
      'name': instance.name,
    };

QuestionsTicketPayment _$QuestionsTicketPaymentFromJson(
        Map<String, dynamic> json) =>
    QuestionsTicketPayment(
      name: json['name'] as String?,
      label: json['label'] as String?,
      required: json['required'] as bool?,
      initial: json['initial'] as String?,
      helpText: json['help_text'] as String?,
      type: json['type'] as String?,
      fieldParts: (json['field_parts'] as List<dynamic>?)
          ?.map((e) => FieldParts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionsTicketPaymentToJson(
        QuestionsTicketPayment instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'required': instance.required,
      'initial': instance.initial,
      'help_text': instance.helpText,
      'type': instance.type,
      'field_parts': instance.fieldParts,
    };

FieldParts _$FieldPartsFromJson(Map<String, dynamic> json) => FieldParts(
      label: json['label'] as String?,
      required: json['required'] as bool?,
      initial: json['initial'] as String?,
      helpText: json['help_text'] as String?,
      type: json['type'] as String?,
      maxLength: json['max_length'] as int?,
      multiline: json['multiline'] as bool?,
    );

Map<String, dynamic> _$FieldPartsToJson(FieldParts instance) =>
    <String, dynamic>{
      'label': instance.label,
      'required': instance.required,
      'initial': instance.initial,
      'help_text': instance.helpText,
      'type': instance.type,
      'max_length': instance.maxLength,
      'multiline': instance.multiline,
    };

ItemTicketQuestion _$ItemTicketQuestionFromJson(Map<String, dynamic> json) =>
    ItemTicketQuestion(
      str: json['str'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      defaultPrice: json['default_price'] as String?,
      price: json['price'] as String?,
      admission: json['admission'] as bool?,
    );

Map<String, dynamic> _$ItemTicketQuestionToJson(ItemTicketQuestion instance) =>
    <String, dynamic>{
      'str': instance.str,
      'name': instance.name,
      'description': instance.description,
      'default_price': instance.defaultPrice,
      'price': instance.price,
      'admission': instance.admission,
    };

ContactForm _$ContactFormFromJson(Map<String, dynamic> json) => ContactForm(
      name: json['name'] as String?,
      label: json['label'] as String?,
      required: json['required'] as bool?,
      initial: json['initial'] as String?,
      helpText: json['help_text'] as String?,
      type: json['type'] as String?,
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$ContactFormToJson(ContactForm instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'required': instance.required,
      'initial': instance.initial,
      'help_text': instance.helpText,
      'type': instance.type,
      'choices': instance.choices,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      defaultPrice: json['default_price'] as String?,
      price: json['price'] as String?,
      admission: json['admission'] as bool?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'default_price': instance.defaultPrice,
      'price': instance.price,
      'admission': instance.admission,
      'count': instance.count,
    };
