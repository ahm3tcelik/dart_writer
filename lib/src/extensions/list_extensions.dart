extension ListExtension on List {
  String get seperateWithComma {
    var list = this;
    var result = '';
    list.forEach((element) {
      result += element;
      if (element != list.last) result += ', ';
    });
    return result;
  }
}
