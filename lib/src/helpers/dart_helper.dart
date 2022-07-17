import '../interpreter/other/argument_item.dart';
import '../interpreter/IExpression.dart';
import '../interpreter/statements/call.dart';
import '../interpreter/other/argument.dart';

class DartHelper {
  static DartHelper? _instance;
  static DartHelper get instance {
    _instance ??= DartHelper._init();
    return _instance!;
  }

  DartHelper._init();

  ///```dart
  /// {
  ///   "as": "Scaffold",
  ///   "appBar": {
  ///      "as": "AppBar",
  ///      "title": "'Ahmet'",
  ///      "centerTitle": "false"
  ///    },
  ///  }
  /// ```
  /// [Output]: Scaffold(appBar: AppBar(title: 'Ahmet', centerTitle: false))
  IExpression getCodeFromMap(Map map) {
    return Call(map['as'], argument: _getArgument(map));
  }

  Argument _getArgument(Map data) {
    var list = <ArgumentItem>[];
    for (var entry in data.entries) {
      if (entry.key == 'as') continue;
      
      // Positional params ex: {as: 'Text', params: ["Ahmet", 5]} --> Text('Ahmet', 5)
      if (entry.key == 'params') {
        List positionalArgs = entry.value;
        positionalArgs.forEach((arg) {
          list.add(ArgumentItem(arg));
        });
        continue;
      }

      if (entry.value is Map) {
        var innerArg = _getArgument(entry.value);

        var arg = Call(entry.value['as'], argument: innerArg);
        list.add(ArgumentItem(arg, name: entry.key));
      }
      else if (entry.value is List) {
        List children = entry.value;
        var callList = [];
        children.forEach((child) {
          var innerArg = _getArgument(child);
          callList.add(Call(child['as'], argument: innerArg));
        });
        list.add(ArgumentItem(callList, name: entry.key));
      } else {
        list.add(ArgumentItem(entry.value, name: entry.key));
      }
    }

    return Argument(list);
  }
}
