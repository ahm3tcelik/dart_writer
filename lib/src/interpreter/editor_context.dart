import 'dart:collection';
import 'package:dart_writer/dart_writer.dart';

import 'IExpression.dart';
import '../constants.dart';
import 'scope.dart';

class EditorContext {
  final Queue<Scope> _scopes = Queue();
  final StringBuffer _buffer = StringBuffer();
  bool enableDartFormatter;

  EditorContext({this.enableDartFormatter = false});

  String build(List<IExpression> codeList) {
    codeList.forEach((e) => _buffer.write(e.interpret(this)));
    if (enableDartFormatter) {
      return DartFormatter().format(_buffer.toString());
    }
    return _buffer.toString();
  }

  String openScope(Scope scope) {
    _scopes.addLast(scope);
    return ' {';
  }

  String closeScope({int stepNum = 1}) {
    var _buffer = StringBuffer();
    for (var i = 0; i < stepNum; i++) {
      _scopes.removeLast();
      _buffer.write(indent());
      _buffer.writeln('}');
    }
    return _buffer.toString();
  }

  String space({int spaceNum = 1}) {
    return (' ' * spaceNum);
  }

  String indent() {
    return space(spaceNum: _scopes.length * Constants.INDENT_LEN);
  }
}
