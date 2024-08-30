import 'package:flutter/material.dart';
import '../models/distribution_model.dart';
import '../services/distribution_service.dart';
import '../widgets/distribution_item_widget.dart';

class DistributionWidget extends StatefulWidget {
  @override
  _DistributionWidgetState createState() => _DistributionWidgetState();
}

class _DistributionWidgetState extends State<DistributionWidget> {
  late Stream<List<Distribution>> _distributionStream;
  late DistributionService _distributionService;

  @override
  void initState() {
    super.initState();
    _distributionService = DistributionService();
    _distributionStream = _distributionService.distributionStream;
  }

  void _updateRobotInDistribution(int robotId, String field, bool newValue) {
    setState(() {
      for (var distribution in _distributionService.currentDistributions) {
        final robot = distribution.robots?.firstWhere((r) => r.id == robotId);
        if (robot != null) {
          if (field == 'blockers') {
            robot.blockers = newValue;
          } else if (field == 'delivery') {
            robot.delivery = newValue;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _distributionService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1400),
        child: StreamBuilder<List<Distribution>>(
          stream: _distributionStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              final distributions = snapshot.data!;
              return ListView.builder(
                itemCount: distributions.length,
                itemBuilder: (context, index) {
                  final distribution = distributions[index];
                  return DistributionItemWidget(
                    distribution: distribution,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
