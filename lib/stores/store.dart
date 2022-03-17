import 'package:Me_Fuel/services/e-control/e-control_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Store {
  Store._internal();
  static final Store _store = Store._internal();
  final EControlAPI _eControlAPI = EControlAPI(dotenv.env['E_CONTROL_API_BASE_PATH'] ?? 'https://api.e-control.at/sprit/1.0');

  factory Store () => _store;
}