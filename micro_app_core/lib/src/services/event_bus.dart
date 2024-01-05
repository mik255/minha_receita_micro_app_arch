abstract class EventData{
  Map<String,dynamic> toJson();
}
abstract class EventBusService{
  void on<T extends EventData>(Function(T) callback);
  void emit<T extends EventData>(T event);
}