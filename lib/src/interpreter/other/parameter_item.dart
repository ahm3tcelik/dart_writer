class ParameterItem {
  
  final String name;
  final bool? isNamed;
  final bool? isRequired;

  /// Example
  ///```dart
  /// Parameter([
  ///   ParameterItem('BuildContext context'),
  ///   ParameterItem('User user', isNamed: true, isRequired: true),
  ///   ParameterItem('String? result', isNamed: true, isRequired: false)
  /// ]),
  ///```
  /// ParameterItem(paramName, isNamed: isNamedParamter?,
  /// [name]: parameter ex: String name
  /// [isNamed]: is named parameter? ex: {int x}
  /// [isRequired]: is required for named parameter RequiredForNamedParameter)
  ParameterItem(this.name, {this.isNamed, this.isRequired});
}