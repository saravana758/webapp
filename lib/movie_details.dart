import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'Dashborad/appbarsearchwidget.dart';
import 'Dashborad/logoutBTNwidget.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieName;
  final String movieImage;
  final String releaseDate;
  final String overview;
  final String originalLanguage;
  final String starRating;
  final String titlename;

  const MovieDetailScreen({
    Key? key,
    required this.movieName,
    required this.movieImage,
    required this.releaseDate,
    required this.overview,
    required this.originalLanguage,
    required this.starRating,
    required this.titlename,
  }) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/avar.mp4')
      ..initialize().then((_) {
        setState(() {}); // Ensure the video is initialized
        print("Video Initialized: ${_controller.value.isInitialized}");
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the video player controller
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = _controller.value.isPlaying;
      print("Play Button Clicked: isPlaying = $_isPlaying");
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/top.png'),
        ),
        backgroundColor: const Color.fromARGB(255, 82, 47, 122),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.03),
            child: SearchField(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
          ),
          SizedBox(width: screenWidth * 0.09),
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.04),
            child: buildLogoutButton(context, screenWidth),
          ),
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.black,
        child: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.12,
              left: screenWidth * 0.08,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.34,
                    child: Text(
                      widget.titlename,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.019,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    "Rating: ${widget.starRating} / 5",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 15, 200, 224),
                      fontSize: screenWidth * 0.013,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    width: screenWidth * 0.34,
                    child: Text(
                      widget.overview,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.013,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    "Release Date:  ${widget.releaseDate}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.014,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Original Language: ${widget.originalLanguage}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.014,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.12,
              left: screenWidth * 0.45,
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.6,
                  child:Stack(
  fit: StackFit.expand,
  children: [
    // Show the movie image if the video is not playing
    if (!_isPlaying)
      Image.network(
        widget.movieImage,
        fit: BoxFit.cover,
      ),
    // Show the video player if it's initialized and playing
    if (_controller.value.isInitialized && _isPlaying)
      AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    // Show the play button overlay if the video is not playing
    if (!_isPlaying)
      Center(
        child: GestureDetector(
          onTap: _togglePlayPause,
          child: Icon(
            Icons.play_circle_outline,
            size: screenWidth * 0.1,
            color: Colors.white,
          ),
        ),
      ),
  ],
),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
