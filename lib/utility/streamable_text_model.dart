import 'dart:math';

class StreamableTextModel {
  final String message;

  StreamableTextModel(this.message);

  Stream<String> toStream({Function? callback, Duration? initialDelay}) async* {
    final random = Random();
    if (initialDelay != null) {
      yield "";
      await Future.delayed(initialDelay);
    }
    for (var i = 0; i < message.length; i++) {
      yield message.substring(0, i + 1);
      await Future.delayed(
          Duration(milliseconds: max(70, random.nextInt(400))));
    }
    callback?.call();
  }
}
