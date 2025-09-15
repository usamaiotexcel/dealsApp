import 'dart:convert';
import 'package:dealsapp/models/Deals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DealRepository {
  final String baseUrl = "http://stagingauth.desidime.com/v4";
  final Map<String, String> headers = {
    "X-Desidime-Client": "08b4260e5585f282d1bd9d085e743fd9",
  };

Future<List<Deal>> fetchDeals(String endpoint, int page) async {
    final url = Uri.parse(
      "$baseUrl/$endpoint?per_page=10&page=$page&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store{name}",
    );

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List dealsJson = data["data"] ?? data["deals"] ?? [];
      return dealsJson.map((e) => Deal.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch deals");
    }
  }


  Future<void> cacheDeals(String key, List<Deal> deals) async {
    final prefs = await SharedPreferences.getInstance();
    final list = deals.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(key, list);
  }

  Future<List<Deal>> loadCachedDeals(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    return list.map((e) => Deal.fromJson(json.decode(e))).toList();
  }
}
