class ArgumentItem {
  final dynamic arg;
  final String? name;

  /// Example
  ///```dart
  /// Argument([
  ///   ArgumentItem('user'),
  ///   ArgumentItem('user1', name: 'user'),
  /// ]),
  ///```
  /// [Output]: (user, user: user1)
  /// Argument(arg, name: named argument?),
  /// [name]: name of argument
  ArgumentItem(this.arg, {this.name});
}