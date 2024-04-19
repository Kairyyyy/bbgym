import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRowPage extends StatefulWidget {
  final List<String> conditionOptions;
  final Function(String, String) onAddRow;

  const AddRowPage({super.key,
    required this.conditionOptions,
    required this.onAddRow,
  });

  @override
  _AddRowPageState createState() => _AddRowPageState();
}

class _AddRowPageState extends State<AddRowPage> {
  late String selectedCondition;
  late String selectedTable;

  @override
  void initState() {
    super.initState();
    selectedCondition = widget.conditionOptions.first;
    selectedTable = 'Basketball'; // Default to Basketball
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Row',
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
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xff001333), // Page background color
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Table:',
              style: GoogleFonts.roboto(
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            // Radio list tiles with blue selected color
            radioListTile('Basketball'),
            radioListTile('Ball Racks'),
            radioListTile('Cones'),
            radioListTile('Medicine Ball'),
            const SizedBox(height: 10),
            Text(
              'Condition:',
              style: GoogleFonts.roboto(
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            // Radio list tiles for condition options
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.conditionOptions.map((condition) {
                return ListTile(
                  title: Text(
                    condition,
                    style: GoogleFonts.robotoCondensed(
                        color: Colors.white
                    ), // Text color
                  ),
                  leading: Radio(
                    value: condition,
                    groupValue: selectedCondition,
                    onChanged: (value) {
                      setState(() {
                        selectedCondition = value.toString();
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
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onAddRow(selectedCondition, selectedTable);
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[900]), // Button background color
                ),
                child: Text(
                  'ADD ROW',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ), // Button text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget radioListTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.robotoCondensed(color: Colors.white), // Text color
      ),
      leading: Radio(
        value: title,
        groupValue: selectedTable,
        onChanged: (value) {
          setState(() {
            selectedTable = value.toString();
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
    );
  }
}
