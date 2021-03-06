import 'package:dart_writer/dart_writer.dart';

/// [Output]:
// abstract class Flyable extends Breathable {
//   void doFly();
// }
void main() {
  var context = EditorContext(enableDartFormatter:  true);
  var code = Interface('Flyable',
     baseClass: 'Breathable',
     prototypes: [
       Method(name: 'doFly', returnType: 'void')
     ]
  );
  print(context.build([code]));
}