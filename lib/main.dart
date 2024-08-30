import 'package:flutter/material.dart';
import '../screens/distribution_screen.dart';
import '../screens/robots_screen.dart';
import '../screens/outsourcing_routes_screen.dart';

void main() {
  runApp(RSH());
}

class RSH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSH',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DistributionScreen(),
        routes: {
          '/distribution': (context) => DistributionScreen(),
          '/robots': (context) => RobotsScreen(),
          '/outsource': (context) => OutsourcingRoutesScreen(),
        }
    );
  }
}
