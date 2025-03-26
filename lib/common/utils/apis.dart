import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static String? baseUrl = dotenv.env['URL'];
  static String? database = dotenv.env['DATABASE'];

  static final String login = '$baseUrl/xmlrpc/2/common';
  static final String databaseIns = '$database';
}
