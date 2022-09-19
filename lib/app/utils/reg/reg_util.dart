class RegUtils {
  static String replaceHtml(String content) {
    final exp = RegExp('<[^>]*>', multiLine: true);
    final parsedString = content.replaceAll(exp, '');
    return parsedString;
  }
}
