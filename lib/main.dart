import 'package:flutter/material.dart';
import 'package:bbgym/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Mock authentication (replace with your authentication logic)
    if (username == 'ADMIN' && password == 'password') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SchedulePage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff060012), // Set background color
            title: Text(
              'Login Failed',
              style: GoogleFonts.robotoFlex(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: Text(
              'Invalid username or password.',
              style: GoogleFonts.robotoFlex(
                color: Colors.white,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'TRY AGAIN',
                  style: GoogleFonts.robotoFlex(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                  ), // Set button text color
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xff000023), Colors.deepPurple[900]!],
              ),
            ),
          ),
          // Content Container
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logo.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'HOOPS',
                    style: GoogleFonts.bebasNeue(
                      color: const Color(0xffffffff),
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      height: 0.001,
                      letterSpacing: 5,
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 180.0), // Adjust the width as needed
                      Text(
                        'HUB',
                        style: GoogleFonts.rubik(
                          color: const Color(0xffff0c00),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          height: 5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _usernameController,
                    style: GoogleFonts.firaSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: GoogleFonts.robotoCondensed(
                          color: Colors.white,
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isHidden,
                    style: GoogleFonts.firaSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.robotoCondensed(
                        color: Colors.white,
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      suffixIcon: IconButton(
                        onPressed: _togglePasswordVisibility,
                        icon: _isHidden
                            ? const Icon(Icons.visibility_off, color: Colors.white)
                            : const Icon(Icons.visibility, color: Colors.white),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  // ElevatedButton with Gradient Background
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.deepPurple],
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 16,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
