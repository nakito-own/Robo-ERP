import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/robot_model.dart';

class RobotListService {
  static const String _apiUrl = 'http://localhost:8000/api/robots/stat';

  Future<List<Robot>> fetchRobots() async {
    final response = await http.get(Uri.parse(_apiUrl), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 307) {
      final redirectUrl = response.headers['location'];
      if (redirectUrl != null) {
        final newResponse = await http.get(Uri.parse(redirectUrl));
        return _parseResponse(newResponse);
      }
    }

    return _parseResponse(response);
  }

  List<Robot> _parseResponse(http.Response response) {
    if (response.statusCode == 200) {
      List<dynamic> robotListJson = json.decode(utf8.decode(response.bodyBytes));
      return robotListJson.map((json) => Robot.fromJson(json)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else if (response.statusCode == 403) {
      throw Exception('Access denied');
    } else if (response.statusCode == 404) {
      throw Exception('API endpoint not found');
    } else {
      throw Exception('Failed to load robots');
    }
  }
}

