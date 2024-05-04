import 'package:flutter/material.dart';

const Color customOrange = Color(0xFFFF7000);
const Color customBeige = Color(0xFFFFF5ED);

class CryRecorder extends StatelessWidget {
  const CryRecorder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Recording',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 223, 222, 222).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: customBeige,
                  radius:
                      30, 
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), 
                    child: Image.asset('assets/smile.jpg'),
                  ),
                ),
                title: Text('Crying Alert',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 18,
                        fontFamily: 'Poppins')),
                subtitle: Text('Noah is crying right now', 
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                    )),),
              ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 200, 
                height: 200, 
                decoration: BoxDecoration(
                  color: Colors.transparent, 
                  shape: BoxShape.circle, 
                  border: Border.all(
                    color: customOrange, 
                    width: 8, 
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/mic.jpg',
                    width:
                        150, 
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 163,
                  height: 50, 
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('CANCEL',
                        style: TextStyle(
                            color: customOrange, fontFamily: 'Poppins')),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: customOrange),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(
                          vertical:
                              15), 
                    ),
                  ),
                ),
                SizedBox(
                  width: 163, 
                  height: 50, 
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('GO TO ANALYZER',
                        style: TextStyle(fontFamily: 'Poppins')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(
                          vertical:
                              15), 
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin:
                EdgeInsets.only(bottom: 20), 
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(30), 
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), 
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3), 
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize
                  .min, 
              children: [
                Image.asset(
                  'assets/cry_dark.jpg', 
                  width: 26, 
                  height: 26,
                ),
                SizedBox(width: 10), 
                Text('Sound Recorded Successfully...',
                    style: TextStyle(
                        color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}