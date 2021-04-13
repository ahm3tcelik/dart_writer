import 'package:dart_writer/dart_writer.dart';

/// [ Output ]
/*
Widget get buildScaffold {
  return Scaffold(
    appBar: AppBar(title: 'ahm3tcelik'),
    body: Center(child: Text('Selam'))
  );
}
*/

void main() {
  var context = EditorContext(enableDartFormatter: true);

  var appBar = Call(
    'AppBar',
    argument: Argument([
      MapEntry('title', "'ahm3tcelik'")
    ])
  );

  var body = Call(
    'Center',
    argument: Argument([
      MapEntry('child', Call('Text',
        argument: Argument([
          MapEntry(null, "'Selam'")])
        )
      )
    ])
  );

  var scaffold = Call(
    'Scaffold',
    argument: Argument([
      MapEntry('appBar', appBar),
      MapEntry('body', body)
    ])
  );

  var code = context.build([
    Getter(
      name: 'buildScaffold',
      returnType: 'Widget',
      statements: [
        Return(scaffold)
      ]
    ),
  ]);

  print(code);
}