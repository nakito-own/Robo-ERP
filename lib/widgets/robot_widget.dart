import 'package:flutter/material.dart';
import '../models/robot_model.dart';
import '../services/robot_update_service.dart';
import '../widgets/add_move_widget.dart';

class RobotWidget extends StatelessWidget {
  final Robot robot;
  final RobotUpdateService robotUpdateService = RobotUpdateService();

  RobotWidget({required this.robot});

  void _updateRobotField(String field, bool newValue) async {
    try {
      await robotUpdateService.updateRobot(robot.id, {field: newValue});
    } catch (e) {
      print('Failed to update robot: $e');
    }
  }

  void _showAddMoveWidget(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddMoveWidget(
          robotId: robot.id,
          currentStorage: robot.storage,
          robotName: robot.name,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadowColor: robot.blockers ? Colors.red[800] : Colors.white,
            color: robot.blockers ? Colors.red[100] : Colors.white,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    ' ${robot.name}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 60),
                  Text('Storage: ${robot.storage}', style: TextStyle(fontSize: 16)),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      _updateRobotField('blockers', !robot.blockers);
                    },
                    icon: Icon(
                      Icons.warning_outlined,
                      size: 20,
                      color: robot.blockers ? Colors.red[800] : Colors.grey[400],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _updateRobotField('delivery', !robot.delivery);
                    },
                    icon: Icon(
                      Icons.local_shipping,
                      size: 20,
                      color: robot.delivery ? Colors.green[800] : Colors.grey[400],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showAddMoveWidget(context);
                    },
                    child: Text('add move'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
