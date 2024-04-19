import 'package:bbgym/passing.dart';
import 'package:bbgym/rebounding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'defending.dart';
import 'dribbling.dart';
import 'shooting.dart';
import 'equipments.dart';
import 'home.dart';
import 'map.dart';

class TrainersCoachesPage extends StatefulWidget {
  const TrainersCoachesPage({super.key});

  @override
  _TrainersCoachesPageState createState() => _TrainersCoachesPageState();
}

class _TrainersCoachesPageState extends State<TrainersCoachesPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Trainers/Coaches',
          style: GoogleFonts.lateef(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color(0xff000157),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/hoops.png', // Replace with your image asset path
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white, // Set the color of the drawer icon to white
          ),
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // Open the drawer using GlobalKey
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff001130),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color(0xff000023),
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
              child: Column(
                children: [
                  Container(
                    height: 150, // Adjust the height of the image container
                    width: 150, // Adjust the width of the image container
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/logo.png'),
                        // Replace 'images/logo.png' with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0), // Adjust left padding as needed
                    child: Text(
                      'HUB',
                      style: GoogleFonts.rubik(
                        color: const Color(0xffff0c00),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 2, // Height of the horizontal line
              color: Colors.white, // Color of the horizontal line
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 1),
                  ListTile(
                    title: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0), // Adjust padding as needed
                        child: Text(
                          'SCHEDULES',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SchedulePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0), // Adjust padding as needed
                        child: Text(
                          'EQUIPMENTS',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EquipmentPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Padding(
                        padding:const  EdgeInsets.all(15.0), // Adjust padding as needed
                        child: Text(
                          'MAP',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    tileColor: const Color(0xffd60752),
                    title: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0), // Adjust padding as needed
                        child: Text(
                          'TRAINERS/COACHES',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xff000b1e),
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  'SPECIALTIES:',
                  style: GoogleFonts.robotoSerif(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 7,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity, // Use full width for buttons
              height: 75, // Set button height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShootingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xb510459d), // Change button background color
                ),
                child: Text(
                  'SHOOTING',
                  style: GoogleFonts.play(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Use full width for buttons
              height: 75, // Set button height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DribblingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xb510459d), // Change button background color
                ),
                child: Text(
                  'DRIBBLING',
                  style: GoogleFonts.play(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Use full width for buttons
              height: 75, // Set button height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DefendingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xb510459d), // Change button background color
                ),
                child: Text(
                  'DEFENDING',
                  style: GoogleFonts.play(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Use full width for buttons
              height: 75, // Set button height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReboundingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xb510459d), // Change button background color
                ),
                child: Text(
                  'REBOUNDING',
                  style: GoogleFonts.play(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Use full width for buttons
              height: 75, // Set button height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PassingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xb510459d), // Change button background color
                ),
                child: Text(
                  'PASSING',
                  style: GoogleFonts.play(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 5,
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