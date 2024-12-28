import 'package:flutter_dotenv/flutter_dotenv.dart';

final String auth0Domain = dotenv.env["AUTH0_DOMAIN"]!;
final String auth0ClientId = dotenv.env["AUTH0_CLIENT_ID"]!;
final String callbackUrl = dotenv.env["CALLBACK_URL"]!;
final String audience = dotenv.env["AUDIENCE"]!;
final String apiUrl = dotenv.env["API_URL"]!;

const double headerSize = 15;
const double titleSize = 13;
const double productNameSize = 13;
const double productPriceSize = 12;

const int productPerPage = 4;
