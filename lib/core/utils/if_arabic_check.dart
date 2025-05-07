checkArabic(String value) {
  return RegExp(r'[\u0600-\u06FF]').hasMatch(value);
}
