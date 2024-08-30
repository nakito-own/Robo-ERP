import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/distribution_model.dart';

class DistributionService {
  final String _url = 'http://localhost:8000/api/distribution';
  final StreamController<List<Distribution>> _distributionStreamController =
  StreamController<List<Distribution>>.broadcast();

  List<Distribution> _currentDistributions = [];

  DistributionService() {
    _startFetching();
  }

  Stream<List<Distribution>> get distributionStream => _distributionStreamController.stream;
  List<Distribution> get currentDistributions => _currentDistributions;

  Future<void> _startFetching() async {
    while (true) {
      try {
        final response = await http.get(Uri.parse(_url));
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
          final distributions = jsonData.map((json) => Distribution.fromJson(json)).toList();

          if (!_areDistributionsEqual(_currentDistributions, distributions)) {
            _currentDistributions = distributions;
            _distributionStreamController.sink.add(_currentDistributions);
          }
        } else {
          throw Exception('Error fetching data');
        }
      } catch (e) {
        print('Error fetching data: $e');
      }

      await Future.delayed(Duration(seconds: 2));
    }
  }

  bool _areDistributionsEqual(List<Distribution> oldDistributions, List<Distribution> newDistributions) {
    if (oldDistributions.length != newDistributions.length) {
      return false;
    }
    for (int i = 0; i < oldDistributions.length; i++) {
      if (oldDistributions[i] != newDistributions[i]) {
        return false;
      }
    }
    return true;
  }

  void dispose() {
    _distributionStreamController.close();
  }
}
