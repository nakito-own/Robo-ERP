import 'package:flutter/material.dart';
import '../models/robot_model.dart';
import '../services/robot_list_service.dart';
import '../widgets/robot_widget.dart';
import '../widgets/app_widgets/app_bar.dart';
import '../widgets/tools_widget.dart';

class RobotsScreen extends StatefulWidget {
  @override
  _RobotsScreenState createState() => _RobotsScreenState();
}

class _RobotsScreenState extends State<RobotsScreen> {
  late Future<List<Robot>> futureRobots;

  @override
  void initState() {
    super.initState();
    futureRobots = RobotListService().fetchRobots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<List<Robot>>(
        future: futureRobots,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  ToolsWidget(),
                  SizedBox(height: 50),
                  //RobotWidget(robot: robot),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load robots'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
