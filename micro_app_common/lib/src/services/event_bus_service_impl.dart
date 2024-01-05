import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:logger/logger.dart';
import 'package:micro_app_core/micro_app_core.dart';

class EventBusServiceImpl implements EventBusService {
  final bool tracing;

  EventBusServiceImpl({this.tracing = true});

  final _eventBus = EventBus();
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 4,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  _log(String message, EventData event) {
    _logger.i(message, stackTrace: StackTrace.current);
    if (tracing) {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyJson = encoder.convert(event.toJson());
      _logger.i(prettyJson);
      _logger.i('Stacktrace');
      _logger.i(StackTrace.current.toString().split('\n').take(6).join('\n'));

    }
  }

  @override
  void emit<T extends EventData>(T event) {
    _eventBus.fire(event);
  }

  @override
  void on<T extends EventData>(Function(T p1) callback) {
    _eventBus.on<T>().listen((event) {
      _log('Event name: ${event.runtimeType}', event);
      callback(event);
    });
  }
}
