import 'package:flutter/material.dart';
import 'custom_appbar_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 8,
      shadowColor: Colors.black,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Row(
            children: [
              Text(
                "RSH - alpha test",
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 30),
              CustomAppBarButton(
                label: 'Distribution',
                onPressed: () {
                  Navigator.pushNamed(context, '/distribution');
                },
              ),
              CustomAppBarButton(
                label: 'Robots',
                onPressed: () {
                  Navigator.pushNamed(context, '/robots');
                },
              ),
              CustomAppBarButton(
                label: 'Locations',
                onPressed: () {
                },
              ),
              CustomAppBarButton(
                label: 'Outsource',
                onPressed: () {
                  Navigator.pushNamed(context, '/outsource');
                },
              ),
              CustomAppBarButton(
                label: 'Battery counter',
                onPressed: () {
                },
              ),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.account_circle, size: 30)),
              SizedBox(width: 30)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
