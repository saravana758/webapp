import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dashborad.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 14, 1, 36),
        ),
        useMaterial3: true,
      ),
     // home: const MyHomePage(),
     home: const DashboardScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  Color _currentContainerColor = Colors.white;
  Color _currentBackgroundColor = Colors.black;

  bool _showErrorMessage = false;
  String _errorMessage = '';

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
      ),
      body: Container(
        color: _currentBackgroundColor,
        child: Center(
          child: Container(
            width: screenWidth * 0.4,
            height: screenHeight * 0.57,
            decoration: BoxDecoration(
              color: _currentContainerColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.02, left: screenHeight * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Sign in To Your Self Service Portal',
                    style: TextStyle(
                        fontSize: screenWidth * 0.01,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.09,
                    width: screenWidth * 0.37,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.09,
                    width: screenWidth * 0.37,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.09,
                    width: screenWidth * 0.37,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 88, 153, 28)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _showErrorMessage,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: screenWidth * 0.02,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty) {
      setState(() {
        _showErrorMessage = true;
        _errorMessage = 'Please enter username';
      });
      _hideMessageAfterDelay();
    } else if (password.isEmpty) {
      setState(() {
        _showErrorMessage = true;
        _errorMessage = 'Please enter password';
      });
      _hideMessageAfterDelay();
    } else {
      // Check the username and password
      if (username == 'saro777' && password == '123456789@S') {
        try {
          var request = http.Request('GET', Uri.parse('https://api.themoviedb.org/3/authentication?api_key=77698cd2e68d7f5896d7ae7363eb6ceb'));

          http.StreamedResponse response = await request.send();

          if (response.statusCode == 200) {
            var responseString = await response.stream.bytesToString();
            print(responseString);
            setState(() {
              _showErrorMessage = true;
              _errorMessage = 'Successfully logged in';
            });
            _hideMessageAndNavigateAfterDelay();
          } else {
            setState(() {
              _showErrorMessage = true;
              _errorMessage = 'Error: ${response.reasonPhrase}';
            });
            _hideMessageAfterDelay();
          }
        } catch (e) {
          setState(() {
            _showErrorMessage = true;
            _errorMessage = 'Error: $e';
          });
          _hideMessageAfterDelay();
        }
      } else {
        setState(() {
          _showErrorMessage = true;
          _errorMessage = 'Invalid details';
        });
        _hideMessageAfterDelay();
      }
    }
  }

  void _hideMessageAfterDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showErrorMessage = false;
        _errorMessage = '';
      });
    });
  }

  void _hideMessageAndNavigateAfterDelay() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showErrorMessage = false;
        _errorMessage = '';
      });
      // Delay navigation to allow the success message to be displayed
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      });
    });
  }
}
