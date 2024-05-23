import 'package:flutter/material.dart';

import 'Dashborad/appbarsearchwidget.dart';
import 'Dashborad/boxWidget.dart';
import 'Dashborad/dashimage.dart';
import 'Dashborad/logoutBTNwidget.dart';
import 'Dashborad/page_change.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding

class DashboardScreen extends StatefulWidget {
  final String title;

  const DashboardScreen({Key? key, this.title = ''}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<dynamic> nowPlayingMovies;
   late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    fetchNowPlayingMovies();
     _scrollController = ScrollController();
  }

  Future<void> fetchNowPlayingMovies() async {
    try {
      var headers = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NzY5OGNkMmU2OGQ3ZjU4OTZkN2FlNzM2M2ViNmNlYiIsInN1YiI6IjY2NGVlOGMxZmZhZDk0OWNjOGJiM2Q3YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uZbWq8z3yMpP59glshOlltCEYTBbnfb3qMMqow9jAoo'
      };
      var response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/now_playing'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          nowPlayingMovies = data['results'];
        });
        print(data);
        print("ok");
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  int calculateStarRating(double voteAverage) {
    if (voteAverage >= 1 && voteAverage < 3) {
      return 1;
    } else if (voteAverage >= 3 && voteAverage < 5) {
      return 2;
    } else if (voteAverage >= 5 && voteAverage < 7) {
      return 3;
    } else if (voteAverage >= 7 && voteAverage < 9) {
      return 4;
    } else {
      return 5;
    }
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
          )
        ],
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
             Stack(
  children: [
    DashboradImage(
      imagePath: 'assets/div.png',
    ),
    Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding:  EdgeInsets.only(top: screenHeight * 0.2),
          child:ElevatedButton(
  onPressed: () {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500), // Adjust the duration as needed
      curve: Curves.easeOut,
    );
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.red, // Background color
    onPrimary: Colors.white, // Text color
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
  child: Text(
    'Read more',
    style: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
  ),
),

      ),
     ) ),
  ],
),

              SizedBox(height: screenHeight * 0.3),
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: nowPlayingMovies.skip(4).take(4).map((movie) {
                        // Calculate star rating dynamically for each movie
                        int starRating = calculateStarRating(
                            movie['vote_average'].toDouble());
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: BoxWidget(
                            moviename: movie['title'],
                            starRating:
                                starRating, // Pass dynamically calculated star rating
                            movieImage:
                                'https://image.tmdb.org/t/p/w500/${movie['poster_path']}',
                            releaseDate: movie['release_date'],
                            overview: movie['overview'],
                            originalLanguage: movie['original_language'],
                            titlename: movie['original_title'],
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(
                        height: screenHeight * 0.06), // SizedBox with height 10
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.15),
              DynamicWidthRow()
            ],
          ),
        ),
      ),
    );
  }
}
