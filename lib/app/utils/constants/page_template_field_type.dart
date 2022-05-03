enum PageTemplateFieldType {
  textarea,
  multiselect,
  text,
  radio,
  select,
}

extension PageTemplateFieldTypeExtension on PageTemplateFieldType {
  static PageTemplateFieldType? init(String string) {
    switch (string) {
      case 'textarea':
        return PageTemplateFieldType.textarea;
      case 'multiselect':
        return PageTemplateFieldType.multiselect;
      case 'text':
        return PageTemplateFieldType.text;
      case 'radio':
        return PageTemplateFieldType.radio;
      case 'select':
        return PageTemplateFieldType.select;
      default:
        return null;
    }
  }
}
