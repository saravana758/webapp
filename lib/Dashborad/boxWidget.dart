import 'package:flutter/material.dart';
import '../movie_details.dart';

class BoxWidget extends StatelessWidget {
  final String moviename;
  final String movieImage;
  final int starRating;
  final String releaseDate;
  final String overview;
  final String originalLanguage;
  final String titlename;

  const BoxWidget({
    required this.moviename,
    required this.movieImage,
    required this.starRating,
    required this.releaseDate,
    required this.overview,
    required this.originalLanguage,
    required this.titlename,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Function to build star icons based on starRating
    List<Widget> buildStars(int starRating) {
      List<Widget> stars = [];
      for (int i = 0; i < starRating; i++) {
        stars.add(Icon(
          Icons.star,
          color: Colors.yellow,
          size: screenWidth * 0.018,
        ));
      }
      return stars;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              movieName: moviename,
              movieImage: movieImage,
              starRating: starRating.toString(),titlename :titlename,
              releaseDate: releaseDate,
              overview: overview,
              originalLanguage: originalLanguage,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.22,
            height: screenWidth * 0.17,
            color: Colors.blue,
            // Image Container
            child: Image.network(
              movieImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: screenWidth * 0.22,
            height: screenWidth * 0.05,
            color: Color.fromARGB(255, 75, 47, 107),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenWidth * 0.003, left: screenWidth * 0.005),
                      child: Text(
                        moviename,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.010,
                        ),
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.001),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.002),
                      child: Row(
                        children: buildStars(
                            starRating), // Use the buildStars function
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.005),
                  child: Icon(Icons.play_circle_filled,
                      color: Color.fromARGB(255, 162, 157, 167),
                      size: screenWidth * 0.04),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
