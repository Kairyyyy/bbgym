import 'package:bbgym/trainers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'equipments.dart';
import 'home.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> locationConditions = ['Excellent', 'Good', 'Fair', 'Poor'];

  late List<String> selectedConditions;
  late List<bool> selectedCleanliness;

  @override
  void initState() {
    super.initState();
    initializeLists();
  }

  void initializeLists() {
    List<String> locations = [
      'Lobby',
      'Court 1',
      'Court 2',
      'Shower Room',
      'Locker Room',
      'Storage Room'
    ];

    selectedConditions = List.filled(locations.length, 'Excellent');
    selectedCleanliness = List.filled(locations.length, true);
  }

  Widget _buildCleanlinessDropdown(int index) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<bool>(
        value: selectedCleanliness[index],
        onChanged: (newValue) {
          _showCleanlinessChangeDialog(index, newValue);
        },
        items: const [
          DropdownMenuItem<bool>(
            value: true,
            child: Icon(Icons.check, color: Colors.green),
          ),
          DropdownMenuItem<bool>(
            value: false,
            child: Icon(Icons.close, color: Colors.red),
          ),
        ],
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: const Color(0xff031232),
        style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
        underline: Container(), // Remove underline
      ),
    );
  }

  void _showCleanlinessChangeDialog(int index, bool? newValue) {
    if (newValue != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Confirm Cleanliness Change',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: const Color(0xff000021),
            content: Text(
              'Are you sure you want to change the cleanliness status?',
              style: GoogleFonts.lato(
                color: Colors.white,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.lato( color: const Color(0xffff2323),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCleanliness[index] = newValue;
                  });
                  Navigator.pop(context); // Close the dialog
                },
                child: Text(
                  'Confirm',
                  style: GoogleFonts.lato(
                    color: const Color(0xff0f86e1),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildConditionsDropdown(int index) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedConditions[index],
        onChanged: (newValue) {
          _showConditionsChangeDialog(index, newValue!);
        },
        items: locationConditions.map((condition) {
          return DropdownMenuItem<String>(
            value: condition,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Text(
                condition,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }).toList(),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: const Color(0xff031232),
        style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
        underline: Container(), // Remove underline
      ),
    );
  }

  void _showConditionsChangeDialog(int index, String newValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Condition Change',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xff000021),
          content: Text(
            'Are you sure you want to change the condition?',
            style: GoogleFonts.lato(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.lato(color: const Color(0xffff2323),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedConditions[index] = newValue;
                });
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Confirm',
                style: GoogleFonts.lato(color: const Color(0xff0f86e1),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<TableRow> _buildTableRows(List<String> locations) {
    List<TableRow> rows = [];

    for (int i = 0; i < locations.length; i++) {
      rows.add(
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  locations[i],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildConditionsDropdown(i),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildCleanlinessDropdown(i),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    List<String> locations = [
      'Lobby',
      'Court 1',
      'Court 2',
      'Shower Room',
      'Locker Room',
      'Storage Room'
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Map',
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
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
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
                    padding: const EdgeInsets.only(left: 100.0),
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
              height: 2,
              color: Colors.white,
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
                        padding: const EdgeInsets.all(15.0),
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
                        padding: const EdgeInsets.all(15.0),
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
                    tileColor: const Color(0xffd60752),
                    title: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrainersCoachesPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xff000b1e),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                const SizedBox(height: 10), // Adjust spacing as needed
                // Image Widget
                Image.asset(
                  'images/map.jpg', // Replace with your image path
                  width: 330,
                ),
                const SizedBox(height: 20), // Additional spacing after the image
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1.35), // Adjust width for location column
                    1: FlexColumnWidth(2), // Adjust width for conditions column
                    2: FlexColumnWidth(1.65), // Adjust width for cleanliness column
                  },
                  border: TableBorder.all(
                    color: Colors.white, // Set the border color to white
                    width: 1.0, // Set the border width
                    style: BorderStyle.solid, // Set the border style
                  ),
                  children: [
                    TableRow(
                      children: [
                        _buildTableHeader('Locations'),
                        _buildTableHeader('Conditions'),
                        _buildTableHeader('Cleanliness'),
                      ],
                    ),
                    ..._buildTableRows(locations),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
