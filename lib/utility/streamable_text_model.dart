import 'dart:math';

class StreamableTextModel {
  final String message;

  StreamableTextModel(this.message);

  Stream<String> toStream({Function? callback}) async* {
    final random = Random();
    for (var i = 0; i < message.length; i++) {
      yield message.substring(0, i + 1);
      Future.delayed(Duration(milliseconds: max(100, random.nextInt(500))));
    }
    callback?.call();
  }
}
