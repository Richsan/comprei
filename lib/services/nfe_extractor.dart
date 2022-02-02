import 'package:comprei/models/purchase.dart';

import '../logics/nfe_extractor.dart' as logic;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import '../adapters/html_document.dart';

Future<Purchase> extractFromUrl(String urlStr) async {
  final url = Uri.parse(urlStr);
  if (!logic.isNFeURL(url)) {
    throw Exception("Not Valid url");
  }

  final urlResponse = await http.get(url);

  if (urlResponse.statusCode != 200) {
    throw Exception(
        'Error requesting url status-code=${urlResponse.statusCode} body=${urlResponse.body}');
  }

  return html.parse(urlResponse.body).toPurchase();
}
