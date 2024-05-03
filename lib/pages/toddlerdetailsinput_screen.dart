import "package:flutter/material.dart";

class ToddlerDetailsInput extends StatefulWidget {
  const ToddlerDetailsInput({super.key});

  @override
  State<ToddlerDetailsInput> createState() => _ToddlerDetailsInputState();
}

class _ToddlerDetailsInputState extends State<ToddlerDetailsInput> {
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press here
          },
        ),
        title: const Text('Toddler Details'), // Set the app bar title here
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Enter Toddler Details:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Toddler Age',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Toddler Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Toddler Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle input submission here
                  // For example, you can access the values using _ageController.text, _heightController.text, _weightController.text
                  // Perform validation and processing as needed
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF7000), // Color #FF7000
                ),
                child: Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
