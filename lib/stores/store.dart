class Store {
  Store._internal();
  static final Store _store = Store._internal();

  factory Store () => _store;
}