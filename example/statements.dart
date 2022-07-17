import 'package:code_generator/code_generator.dart';

/// [Output]:
/// ```dart
/// int do() {
///  var i = 5;
///  var name = getName();
///  return i;
/// }
/// ```
void main() {
  var context = EditorContext();
  var code = Method(name: 'do', returnType: 'int',
    statements: [
      Assign('var i', '5'),
      Assign('var name', Call('getName')),
      Return('i')
    ] 
  );
  print(context.build([code]));
}