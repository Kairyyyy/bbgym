import 'package:bbgym/schedules.dart';
import 'package:flutter/material.dart';
import 'package:bbgym/equipments.dart';
import 'package:bbgym/map.dart';
import 'package:bbgym/trainers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Schedule> schedules = [];
  DateTime selectedCalendarDate = DateTime.now();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // Add some pre-existing schedules to the list
    schedules.addAll([
      Schedule(
        name: 'Magno, Kairy Ken',
        date: DateTime.now(),
        // Yesterday
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 9, minute: 0),
        color: const Color(0xffe5004b),
        courtName: 'Court 1',
      ),
      Schedule(
        name: 'Cheng, Jeric Daniel',
        date: DateTime.now(),
        // Today
        startTime: const TimeOfDay(hour: 10, minute: 30),
        endTime: const TimeOfDay(hour: 11, minute: 30),
        color: Colors.blue[900]!,
        courtName: 'Court 2',
      ),
      Schedule(
        name: 'Buenaventura, Geuel Lei',
        date: DateTime.now().add(const Duration(days: 2)),
        // Tomorrow
        startTime: const TimeOfDay(hour: 15, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
        color: const Color(0xffdc9600),
        courtName: 'Court 1',
      ),
    ]);
  }

  void handleAddSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleFormPage(
          onSave: (newSchedule) {
            setState(() {
              schedules.add(newSchedule);
            });
          },
          existingSchedules: schedules,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Schedules',
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
                    tileColor: const Color(0xffd60752),
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
                      Navigator.pop(context);
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
        color: const Color(0xff000b1e), // Set your desired background color here
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('MMMM d, y').format(DateTime.now()),
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Today',
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffd0d0d0),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: handleAddSchedule,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                          ),
                          child: Text(
                            '+ Add Schedule',
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    DateTime cellDate =
                        DateTime.now().add(Duration(days: index));
                    bool hasSchedule = schedules.any((schedule) =>
                        schedule.date.year == cellDate.year &&
                        schedule.date.month == cellDate.month &&
                        schedule.date.day == cellDate.day);

                    bool isSelected =
                        selectedCalendarDate.year == cellDate.year &&
                            selectedCalendarDate.month == cellDate.month &&
                            selectedCalendarDate.day == cellDate.day;

                    if (hasSchedule) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCalendarDate =
                                cellDate; // Update selected date
                          });
                        },
                        child: Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue[900]
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('MMM').format(cellDate),
                                style: GoogleFonts.lato(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('d').format(cellDate),
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('E').format(cellDate),
                                style: GoogleFonts.lato(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(); // Empty container if no schedules on this day
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    Schedule schedule = schedules[index];
                    if (schedule.date.year == selectedCalendarDate.year &&
                        schedule.date.month == selectedCalendarDate.month &&
                        schedule.date.day == selectedCalendarDate.day) {
                      return Card(
                        color: schedule.color,
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 25.0),
                          title: Text(
                            schedule.name,
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                color: Colors
                                    .white, // Set the color of the divider
                                thickness:
                                    2, // Set the thickness of the divider
                                height:
                                    16, // Set the height (vertical space) above the divider
                                indent:
                                    0, // Set the indent (space on the left of the divider)
                                endIndent:
                                    0, // Set the end indent (space on the right of the divider)
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                DateFormat('MMMM d, y').format(schedule.date),
                                style: GoogleFonts.lato(
                                    color: Colors.white, fontSize: 13),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  Text(
                                    '${schedule.startTime.format(context)} - ${schedule.endTime.format(context)}',
                                    style: GoogleFonts.lato(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'Court: ${schedule.courtName}',
                                style: GoogleFonts.lato(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              // Show a confirmation dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: const Color(0xff000021),
                                    title: Text("Delete Schedule",
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                        "Are you sure you want to delete this schedule?",
                                      style: GoogleFonts.lato(
                                      color: Colors.white,
                                    ),
                                  ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text("Cancel",
                                            style:
                                                TextStyle(color: Colors.blue)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            schedules.removeAt(
                                                index); // Remove the schedule
                                          });
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text("Delete",
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Container(); // Return empty container if not matching selected date
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Schedule {
  final String name;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Color color;
  final String courtName; // New field to store the court name

  Schedule({
    required this.name,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.courtName, // Initialize court name in constructor
  });
}
