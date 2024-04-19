import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'home.dart';

class ScheduleFormPage extends StatefulWidget {
  final Function(Schedule) onSave;
  final List<Schedule> existingSchedules; // Existing schedules list

  const ScheduleFormPage({
    super.key,
    required this.onSave,
    required this.existingSchedules,
  });

  @override
  _ScheduleFormPageState createState() => _ScheduleFormPageState(existingSchedules);
}

class _ScheduleFormPageState extends State<ScheduleFormPage> {
  String scheduleName = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 0);
  Color selectedColor = Colors.blue[900]!;
  String selectedCourt = 'Court 1';

  List<Schedule> existingSchedules; // Existing schedules list

  _ScheduleFormPageState(this.existingSchedules) {
    selectedColor = Colors.blue[900]!;
  }

  bool isTimeRangeValid() {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    for (var schedule in existingSchedules) {
      if (schedule.courtName == selectedCourt) {
        int existingStartMinutes = schedule.startTime.hour * 60 + schedule.startTime.minute;
        int existingEndMinutes = schedule.endTime.hour * 60 + schedule.endTime.minute;

        if ((startMinutes >= existingStartMinutes && startMinutes < existingEndMinutes) ||
            (endMinutes > existingStartMinutes && endMinutes <= existingEndMinutes) ||
            (startMinutes <= existingStartMinutes && endMinutes >= existingEndMinutes)) {
          if (schedule.date.year == selectedDate.year &&
              schedule.date.month == selectedDate.month &&
              schedule.date.day == selectedDate.day) {
            return false;
          }
        }
      }
    }
    return true;
  }

  Widget colorCircle(Color color, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? color : null,
        ),
        child: isSelected
            ? const Icon(
          Icons.check,
          size: 15,
          color: Colors.white,
        )
            : CircleAvatar(
          radius: 15,
          backgroundColor: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Schedule',
          style: GoogleFonts.lateef(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color(0xff000157),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
      ),
      backgroundColor: const Color(0xff001333), // Set the background color of the entire page
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: GoogleFonts.lato(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    scheduleName = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date: ${DateFormat('MMMM d, y').format(selectedDate)}',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[900]!),
                    ),
                    child: Text(
                      'Select Date',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start Time: ${startTime.format(context)}',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final TimeOfDay? pickedStartTime = await showTimePicker(
                        context: context,
                        initialTime: startTime,
                      );
                      if (pickedStartTime != null) {
                        setState(() {
                          startTime = pickedStartTime;
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[900]!),
                    ),
                    child: Text(
                      'Select Time',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'End Time: ${endTime.format(context)}',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final TimeOfDay? pickedEndTime = await showTimePicker(
                        context: context,
                        initialTime: endTime,
                      );
                      if (pickedEndTime != null) {
                        setState(() {
                          endTime = pickedEndTime;
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[900]!),
                    ),
                    child: Text(
                      'Select Time',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Court:',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Court 1',
                        groupValue: selectedCourt,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCourt = value!;
                          });
                        },
                        activeColor: Colors.blue[300], // Selected radio color
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                        visualDensity: VisualDensity.standard, // Adjust visual density
                        toggleable: true,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            // Customize radio button color based on its state
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue[300]!; // Selected color
                            } else {
                              return Colors.white60; // Unselected color
                            }
                          },
                        ), // Set radio button color when selected
                      ),
                      Text(
                        'Court 1',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Court 2',
                        groupValue: selectedCourt,
                        onChanged: (String? value) {
                          setState(() {
                            selectedCourt = value!;
                          });
                        },
                        activeColor: Colors.blue[300], // Selected radio color
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                        visualDensity: VisualDensity.standard, // Adjust visual density
                        toggleable: true,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            // Customize radio button color based on its state
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue[300]!; // Selected color
                            } else {
                              return Colors.white60; // Unselected color
                            }
                          },
                        ),
                      ),
                      Text(
                        'Court 2',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Color:',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                      colorCircle(Colors.blue[900]!, selectedColor == Colors.blue[900]!),
                      const SizedBox(width: 10),
                      colorCircle(const Color(0xffdc9600), selectedColor == const Color(0xffdc9600)),
                      const SizedBox(width: 10),
                      colorCircle(const Color(0xffe5004b), selectedColor == const Color(0xffe5004b)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (scheduleName.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Missing Schedule Name"),
                          content: const Text(
                            "Please enter a schedule name before creating the schedule.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (!isTimeRangeValid()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Time Conflict"),
                          content: const Text(
                            "There is a schedule conflict for the selected court and time range.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    final newSchedule = Schedule(
                      name: scheduleName,
                      date: selectedDate,
                      startTime: startTime,
                      endTime: endTime,
                      color: selectedColor,
                      courtName: selectedCourt,
                    );
                    widget.onSave(newSchedule);
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[900]!),
                ),
                child: Text(
                  'Create Schedule',
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
