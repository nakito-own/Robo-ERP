import 'package:flutter/material.dart';
import '../widgets/distribution_widget.dart';
import '../widgets/app_widgets/app_bar.dart';
import '../widgets/app_widgets/side_panel_widget.dart';
import '../widgets/tools_widget.dart';

class DistributionScreen extends StatefulWidget {
  @override
  _DistributionScreenState createState() => _DistributionScreenState();
}

class _DistributionScreenState extends State<DistributionScreen> {
  bool _isPanelOpen = false;

  void _togglePanel() {
    setState(() {
      _isPanelOpen = !_isPanelOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ToolsWidget(),
                  SizedBox(height: 16),
                  Expanded(
                    child: DistributionWidget(),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _isPanelOpen ? 400 : 0,
            child: _isPanelOpen ? SidePanel() : null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePanel,
        child: Icon(_isPanelOpen ? Icons.close : Icons.menu),
      ),
    );
  }
}
