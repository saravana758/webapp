import 'package:flutter/material.dart';

class DynamicWidthRow extends StatefulWidget {
  @override
  _DynamicWidthRowState createState() => _DynamicWidthRowState();
}

class _DynamicWidthRowState extends State<DynamicWidthRow> {
  Color _forwardButtonColor = Colors.white;
  Color _backButtonColor = Colors.white;
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0; // Initialize with the first item selected

  void _handleForwardButtonPress() {
    setState(() {
      _forwardButtonColor = Colors.red;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _forwardButtonColor = Colors.white;
      });
    });

    // Scroll the ListView forward by a fixed amount
    _scrollController.animateTo(
      _scrollController.offset + 100, // Adjust the value as needed
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleBackButtonPress() {
    setState(() {
      _backButtonColor = Colors.red;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _backButtonColor = Colors.white;
      });
    });

    // Scroll the ListView backward by a fixed amount
    _scrollController.animateTo(
      _scrollController.offset - 100, // Adjust the value as needed
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleItemClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min, // Ensures the Row takes minimal space
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            color: _backButtonColor,
            onPressed: _handleBackButtonPress,
          ),
          SizedBox(
            width: screenWidth * 0.2, // Set a fixed width for the Container
            child: Container(
              height: screenHeight * 0.08, // Adjust height as needed
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  bool isSelected = index == _selectedIndex;
                  return GestureDetector(
                    onTap: () => _handleItemClick(index),
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      width: screenWidth * 0.03,
                      height:  screenWidth * 0.03,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize:screenWidth * 0.012,
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            color: _forwardButtonColor,
            onPressed: _handleForwardButtonPress,
          ),
        ],
      ),
    );
  }
}
