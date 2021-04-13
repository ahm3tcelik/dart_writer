extension StringExtension on String {
  String get putSemicolon {
    var code = this;
    if (code.endsWith(';')) {
      return this;
    }
    return '$code;';
  }

  String get removeSemicolon {
    var code = this;
    if (code.endsWith(';')) {
      return code.substring(0,code.length - 1);
    }
    return '$code;';
  }
}
