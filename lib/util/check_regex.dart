bool checkRegex(String input) {
  final regex = RegExp(r'^[가-힣a-zA-Z]+$');
  return regex.hasMatch(input);
}
