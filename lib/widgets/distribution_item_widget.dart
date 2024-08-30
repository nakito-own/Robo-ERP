import 'package:flutter/material.dart';
import '../models/distribution_model.dart';
import '../widgets/robot_widget.dart';
import 'package:flutter/services.dart';

class DistributionItemWidget extends StatelessWidget {
  final Distribution distribution;

  DistributionItemWidget({required this.distribution});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${distribution.storage} - ${distribution.client}  | ${distribution.robotCount}/${distribution.maxRobots} (min: ${distribution.minRobots})',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ...?distribution.robots?.map((robot) => RobotWidget(
              robot: robot,
            )).toList() ?? [],
          ],
        ),
      ),
    );
  }
}
