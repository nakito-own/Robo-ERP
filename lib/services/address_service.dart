import 'dart:convert';
import 'package:http/http.dart' as http;

class AddressService {
  final String baseUrl = 'http://localhost:8000/api/addresses';

  Future<List<String>> fetchStorageOptions() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item.toString()).toList();
    } else {
      throw Exception('Failed to load storage options: ${response.reasonPhrase}');
    }
  }
}
