import 'package:flutter/material.dart';
import '../widgets/app_widgets/custom_button.dart';
import '../widgets/tools_widgets/create_robot_widget.dart';

class ToolsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 1200,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.001),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: 'add moving',
                onPressed: (){},
              ),
              SizedBox(width: 10),
              CustomButton(
                text: 'add address',
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
