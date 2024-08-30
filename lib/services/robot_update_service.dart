import 'dart:convert';
import 'package:http/http.dart' as http;

class RobotUpdateService {
  final String baseUrl = 'http://localhost:8000/api/robots/';

  Future<Map<String, dynamic>> updateRobot(
      int id, Map<String, dynamic> updates) async {
    final url = Uri.parse('$baseUrl$id');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(updates),
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to update robot: ${response.reasonPhrase}');
    }
  }
}
