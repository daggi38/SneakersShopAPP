import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class myynavbar extends StatelessWidget {
  void Function(int)? onTabChange;
  myynavbar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GNav(
          color: Colors.grey[400],
          activeColor: Colors.grey.shade700,
          mainAxisAlignment: MainAxisAlignment.center,
          tabActiveBorder: Border.all(color: Colors.white),
          tabBackgroundColor: Colors.grey.shade300,
          tabBorderRadius: 16,
          onTabChange: onTabChange,
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.shop,
              text: "Cart",
            ),
          ]),
    );
  }
}
