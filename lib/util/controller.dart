import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class Controller<I, O> extends Stream<O> implements StreamSink<I> {
  @protected
  final input = StreamController<I>();
  @protected
  final output = StreamController<O>();
  @protected
  final exceptions = StreamController<ControllerException>();
  late final Future<void> _processor;

  Controller() {
    _processor = _processorExec();
  }

  Future<void> _processorExec() async {
    await for (final event in input.stream) {
      await process(event);
      if (input.isClosed) break;
    }
  }

  @protected
  Future<void> process(I event);

  @override
  void add(I event) => input.add(event);

  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      exceptions.add(ControllerException(error, stackTrace));

  @override
  Future addStream(Stream<I> stream) async => input.addStream(stream);

  @override
  Future close() async {
    await input.close();
    await output.close();
    exceptions.close();
  }

  @override
  Future get done => Future.wait([_processor, input.done, output.done]);

  bool get isClosed => input.isClosed && output.isClosed;
  bool get isPaused => input.isPaused && output.isPaused;

  @override
  StreamSubscription<O> listen(void Function(O event)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      output.stream.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

class ControllerException implements Exception {
  Object error;
  StackTrace? stackTrace;
  ControllerException(this.error, this.stackTrace);
}

class UnknownInput extends ControllerException {
  UnknownInput(super.error, super.stackTrace);
}
