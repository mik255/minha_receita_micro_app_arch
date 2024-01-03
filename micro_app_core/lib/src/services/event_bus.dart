class EventData{}
abstract class EventBusService{
  void on<EventData>(Function(EventData) callback);
  void emit<EventData>(EventData event);
}