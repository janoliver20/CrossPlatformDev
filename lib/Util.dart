import 'package:flutter_dotenv/flutter_dotenv.dart';

final String E_CONTROL_BASE_PATH = dotenv.env['E_CONTROL_API_BASE_PATH'] ?? 'https://api.e-control.at/sprit/1.0';
