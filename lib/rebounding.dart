import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bbgym/addshootingcoach.dart';

class ReboundingPage extends StatefulWidget {
  const ReboundingPage({super.key});

  @override
  _ReboundingPageState createState() => _ReboundingPageState();
}

class _ReboundingPageState extends State<ReboundingPage> {
  List<MemberInfo> members = [
    MemberInfo(
      name: 'Wilt',
      details: 'Wilt Chaberlain\nSpecialty: Rebounding',
      imagePath: 'images/Wilt.avif',
      yearsOfCoaching: '25yrs',
    ),
    MemberInfo(
      name: 'Lebron',
      details: 'Lebron James\nSpecialty: Rebounding',
      imagePath: 'images/lebron.webp',
      yearsOfCoaching: '8yrs',
    ),
  ];

  void _removeMember(MemberInfo member) {
    setState(() {
      members.remove(member);
    });
  }

  Future<void> _addNewCoach() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCoachPage()),
    );

    if (result != null) {
      final String name = result['name'];
      final String years = result['years'];
      final File? imageFile = result['image']; // File object from ImagePicker

      setState(() {
        members.add(MemberInfo(
          name: name,
          details: '$name\nSpecialty: Rebounding',
          imagePath: 'images/default_avatar.webp', // Default asset path
          imageFile: imageFile, // Store the File object
          yearsOfCoaching: years,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shooting Coaches',
          style: GoogleFonts.lateef(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color(0xff000157),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
      backgroundColor: const Color(0xff000b1e),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (final member in members)
                MemberCard(
                  member: member,
                  onDelete: _removeMember,
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCoach,
        tooltip: 'Add Coach',
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MemberCard extends StatefulWidget {
  final MemberInfo member;
  final Function(MemberInfo) onDelete; // Callback for deletion

  const MemberCard({super.key, required this.member, required this.onDelete});

  @override
  _MemberCardState createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Card(
        elevation: 5,
        color: const Color.fromRGBO(22, 70, 158, 0.30196078431372547),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: widget.member.imageFile != null
                      ? FileImage(widget.member.imageFile!) as ImageProvider<Object>?
                      : AssetImage(widget.member.imagePath) as ImageProvider<Object>,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.member.details.split('\n')[0],
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5), // Add spacing
                    Text(
                      widget.member.details.split('\n')[1],
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5), // Add spacing
                    Text(
                      'Years of Coaching: ${widget.member.yearsOfCoaching}',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    _buildAvailabilityDropdown(),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  _showDeleteConfirmationDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailabilityDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Availability :',
          style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        DropdownButton<bool>(
          value: isAvailable,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              _showConfirmationDialog(newValue);
            }
          },
          items: const [
            DropdownMenuItem<bool>(
              value: true,
              child: Icon(Icons.check, color: Colors.green, size: 24),
            ),
            DropdownMenuItem<bool>(
              value: false,
              child: Icon(Icons.close, color: Colors.red, size: 24),
            ),
          ],
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          iconSize: 32,
          underline: Container(),
          dropdownColor: const Color(0xff000b1e),
          elevation: 5,
          style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }

  void _showConfirmationDialog(bool newValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff000021),
          title: Text(
            'Confirm Availability Change',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to change the availability?',
            style: GoogleFonts.lato(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                  isAvailable = newValue;
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Confirm',
                style: GoogleFonts.lato(
                  color: const Color(0xff0f86e1),
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff000021),
          title: Text(
            'Confirm Deletion',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this member?',
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
                widget.onDelete(widget.member); // Call onDelete callback
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Delete',
                style: GoogleFonts.lato(
                  color: const Color(0xff0f86e1),
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        );
      },
    );
  }
}

class MemberInfo {
  final String name;
  final String details;
  final String imagePath;
  final File? imageFile;
  final String yearsOfCoaching;

  MemberInfo({
    required this.name,
    required this.details,
    required this.imagePath,
    this.imageFile,
    required this.yearsOfCoaching,
  });
}