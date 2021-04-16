import '../../extensions/list_extensions.dart';
import 'parameter_item.dart';
import '../IExpression.dart';
import '../editor_context.dart';

class Parameter implements IExpression {
  final List<ParameterItem>? parameters;

  /// Example
  ///```dart
  /// Parameter([
  ///   ParameterItem('BuildContext context'),
  ///   ParameterItem('String name', isNamed: true, isRequired: true),
  ///   ParameterItem('String? name', isNamed: true, isRequired: false)
  /// ]),
  ///```
  /// [Usage]: Parameter([ParameterItem() ...), ....])
  /// [Output]: BuildContext context, {required String name, String? name}
  Parameter(this.parameters);

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    var namedParams = <String>[];
    var positionalParams = <String>[];
    
    if (parameters != null) {
      parameters!.forEach((param) {
        if (param.isNamed ?? false) {
          /// [named] - [required]
          if (param.isRequired ?? false) {
            namedParams.add('required ${param.name}');          
          }
          /// [named] - [optional] param 
          else {
            namedParams.add(param.name);
          }
        }
        /// [positional]
        else {
          positionalParams.add(param.name);
        }
      });
    }

    buffer.write(positionalParams.seperateWithComma);
    if (positionalParams.isNotEmpty && namedParams.isNotEmpty) buffer.write(', ');
    if (namedParams.isNotEmpty) buffer.write('{${namedParams.seperateWithComma}}');

    return buffer.toString();
  }
}
