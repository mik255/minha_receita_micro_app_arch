import 'package:event_bus/event_bus.dart';
import 'package:micro_app_core/micro_app_core.dart';

class EventBusServiceImpl implements EventBusService {
  final _eventBus = EventBus();

  @override
  void emit<T>(T event) {
    _eventBus.fire(event);
  }

  @override
  void on<T>(Function(T p1) callback) {
    _eventBus.on<T>().listen((event) {
      callback(event);
    });
  }

}
