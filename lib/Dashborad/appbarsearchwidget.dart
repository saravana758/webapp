// search_field.dart

import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const SearchField({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.03),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.15,
            height: screenHeight * 0.04,
            child: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.01,
              ),
              decoration: InputDecoration(
                hintText: 'Search Movies',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.01,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(16),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(16),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(16),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                suffixIcon: Container(
                  width: screenWidth * 0.03,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(8.0),
                    ),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: screenWidth * 0.015,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}


