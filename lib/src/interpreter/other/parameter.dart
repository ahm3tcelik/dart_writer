import '../IExpression.dart';
import '../editor_context.dart';

class Parameter implements IExpression {
  final List<MapEntry<String, bool>>? parameters;

  /// Example
  ///```dart
  /// Parameter([
  ///   MapEntry('this.name', true),
  ///   MapEntry('this.surname', true),
  ///   MapEntry('this.age', false)
  /// ]),
  ///```
  /// [Usage]: Parameter([MapEntry(param, isRequired), ....])
  /// [Output]: {required this.name, required this.surname, this.age}
  Parameter(this.parameters);

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    var paramsText = '';
    if (parameters != null) {
      parameters!.forEach((param) {
        // requried parameter
        if (param.value) {
          paramsText += 'required ${param.key}';
        }
        // optional parameter
        else {
          paramsText += param.key;
        }

        if (param != parameters!.last) {
          paramsText += ', ';
        }
      });
    }

    if (paramsText.isNotEmpty) {
      buffer.write('{$paramsText}');
    }
    return buffer.toString();
  }
}
