import 'package:bbgym/home.dart';
import 'package:bbgym/trainers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'addequipment.dart';
import 'map.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({super.key});

  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  List<String> conditionOptions = ['Excellent', 'Good', 'Poor', 'Severe'];
  List<String> itemConditions = ['Good', 'Excellent', 'Excellent', 'Excellent', 'Excellent'];
  List<String> ballRackConditions = ['Excellent', 'Good', 'Good', 'Poor'];
  List<String> coneConditions = ['Excellent', 'Good', 'Poor', 'Excellent', 'Good'];
  List<String> medicineBallConditions = ['Excellent', 'Good', 'Poor'];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showAddRowPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRowPage(
          conditionOptions: conditionOptions,
          onAddRow: (String newCondition, String selectedTable) {
            setState(() {
              if (selectedTable == 'Basketball') {
                itemConditions.add(newCondition);
              } else if (selectedTable == 'Ball Racks') {
                ballRackConditions.add(newCondition);
              } else if (selectedTable == 'Cones') {
                coneConditions.add(newCondition);
              } else if (selectedTable == 'Medicine Ball') {
                medicineBallConditions.add(newCondition);
              }
            });
          },
        ),
      ),
    );
  }

  String formatId(String prefix, int index) {
    if (index >= 0 && index < itemConditions.length) {
      return '$prefix${(index + 1).toString().padLeft(2, '0')}';
    }
    return '';
  }

  IconData getReplaceIcon(String condition) {
    return condition == 'Poor' || condition == 'Severe' ? Icons.change_circle : Icons.close;
  }

  Widget createTable(String title, List<String> conditions, String idPrefix) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Number of Items: ${conditions.length}',
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1.25),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(1.5),
          },
          border: TableBorder.all(
            color: Colors.white, // Set the border color to white
            width: 1.0, // Set the border width
            style: BorderStyle.solid, // Set the border style
          ),
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ID:',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Condition',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Replace',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            for (int i = 0; i < conditions.length; i++)
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$idPrefix${(i + 1).toString().padLeft(2, '0')}',
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: conditions[i],
                          onChanged: (newValue) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    dialogBackgroundColor: const Color(
                                        0xff000021), // Set the desired background color
                                  ),
                                  child: AlertDialog(
                                    title: Text(
                                      'Confirm Condition Change',
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      'Are you sure you want to change the condition to "$newValue"?',
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.lato(
                                            color: const Color(0xffff2323),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            conditions[i] = newValue!;
                                          });
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: Text(
                                          'Confirm',
                                          style: GoogleFonts.lato(
                                            color: const Color(0xff0f86e1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          items: conditionOptions.map((condition) {
                            return DropdownMenuItem<String>(
                              value: condition,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                                child: Text(
                                  condition,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    color: Colors.white, // Set the text color of the dropdown menu
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          underline: Container(),
                          dropdownColor: const Color(0xff031232),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        getReplaceIcon(conditions[i]),
                        color: conditions[i] == 'Poor' || conditions[i] == 'Severe'
                            ? Colors.lightBlue[400] // Set icon color to red for 'Poor' or 'Severe' conditions
                            : Colors.white, // Set default icon color to white
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Equipments',
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
                            fontWeight: FontWeight.w500,
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
                    tileColor: const Color(0xffd60752),
                    title: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0), // Adjust padding as needed
                        child: Text(
                          'EQUIPMENTS',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
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
                            fontWeight: FontWeight.w500,
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
                    title: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0), // Adjust padding as needed
                        child: Text(
                          'TRAINERS/COACHES',
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
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
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff000b1e), // Set your desired background color here
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0), // Adjust bottom padding for FAB
          children: [
            createTable('Basketball', itemConditions, 'B'),
            const SizedBox(height: 20),
            createTable('Ball Racks', ballRackConditions, 'BR'),
            const SizedBox(height: 20),
            createTable('Cones', coneConditions, 'C'),
            const SizedBox(height: 20),
            createTable('Medicine Ball', medicineBallConditions, 'MB'), // New table for Medicine Ball
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRowPage(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
