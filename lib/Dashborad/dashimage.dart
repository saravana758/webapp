import 'package:flutter/material.dart';

class DashboradImage extends StatelessWidget {
  final String imagePath;

  const DashboradImage({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight *0.99,
      width: screenWidth,
     
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
