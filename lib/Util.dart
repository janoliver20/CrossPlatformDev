import 'package:flutter_dotenv/flutter_dotenv.dart';

final String E_CONTROL_BASE_URI = dotenv.env['E_CONTROL_API_BASE_URI'] ?? 'api.e-control.at';
final String E_CONTROL_BASE_PATH = dotenv.env['E_CONTROL_API_BASE_PATH'] ?? 'sprit/1.0';
