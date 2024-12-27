import 'package:flutter_dotenv/flutter_dotenv.dart';

final String auth0Domain = dotenv.env["AUTH0_DOMAIN"]!;
final String auth0ClientId = dotenv.env["AUTH0_CLIENT_ID"]!;
final String callbackUrl = dotenv.env["CALLBACK_URL"]!;
final String audience = dotenv.env["AUDIENCE"]!;