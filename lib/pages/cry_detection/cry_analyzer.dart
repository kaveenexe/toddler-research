import 'package:flutter/material.dart';
import 'package:flutterapp/model/cry_reason.dart';
import 'package:flutterapp/components/piechart.dart';
import 'package:flutterapp/components/table.dart';
import 'package:flutterapp/components/infobox.dart';

const Color customOrange = Color(0xFFFF7000);
const Color customBeige = Color(0xFFFFF5ED);

class CryAnalyzer extends StatelessWidget {
  CryAnalyzer({Key? key}) : super(key: key);

  final List<CryReason> reasons = [
    CryReason(reason: "Hungry", percentage: 58.33),
    CryReason(reason: "Uncomfortable", percentage: 16.67),
    CryReason(reason: "Sleep", percentage: 25.00),
  ];

  final List<Color> colors = [
    Color(0xFF2656AB), // Deep blue color
    Color(0xFF1CE4E0), // Bright teal color
    Color(0xFFBA73F9), // Light purple color
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Cry Analyzer',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 18, // Set your desired font size
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true, // Centers the title in the AppBar
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              // Handle notifications
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomPieChart(data: reasons),
            CustomLegendTable(
                data: reasons,
                colors: colors), // Insert custom legend table here
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.9, // Adjust the width here
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal:
                        4), // Add horizontal padding inside the container
                margin: const EdgeInsets.only(
                    left: 9,
                    right: 2), // Add left and right margins to the container
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Adjust spacing between the children
                  children: [
                    InfoBox(title: "Hours Cried", content: "2hrs/Day"),
                    InfoBox(title: "Mostly", content: "Hungry"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 350, // Minimum width of the container
                  maxWidth: 350, // Maximum width of the container
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: customBeige,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset('assets/cry.jpg'),
                    ),
                  ),
                  title: Text('Crying Analyzer Result',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          fontFamily: 'Poppins')),
                  subtitle: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black, // Default text color
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Noah is crying due to ',
                          style: TextStyle(
                              height:
                                  1.5), // Line height for spacing between lines
                        ),
                        TextSpan(
                          text: 'hungry',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.5, // Maintain consistent line height
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment
                    .bottomCenter, // Align the button to the bottom center
                child: ElevatedButton(
                  onPressed: () {
                    // Handle navigation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customOrange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  ),
                  child: const Text(
                    'GO TO HOME',
                    style: TextStyle(fontSize: 16),
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
