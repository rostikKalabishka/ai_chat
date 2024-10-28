import 'package:flutter_dotenv/flutter_dotenv.dart';

String BASE_URL = 'https://api.openai.com/v1';
String API_KEY = '${dotenv.env['API_KEY']}';
