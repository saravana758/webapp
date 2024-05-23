import 'package:flutter/material.dart';

import '../main.dart';

// Assuming you have a MainPageRoute defined somewhere in your app
final Route mainPageRoute = MaterialPageRoute(builder: (context) => MyHomePage());

Widget buildLogoutButton(BuildContext context, double screenWidth) {
  return InkWell(
    onTap: () {
      // Navigate to the main page
      Navigator.of(context).push(mainPageRoute);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // Example background color
      ),
      child: Text(
        "Logout",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontSize: screenWidth * 0.02,
        ),
      ),
    ),
  );
}
