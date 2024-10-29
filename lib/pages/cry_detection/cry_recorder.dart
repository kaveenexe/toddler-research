import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutterapp/pages/cry_detection/cry_analyzer.dart';
import 'package:flutterapp/pages/cry_detection/cry_history.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

const Color customOrange = Color(0xFFFF7000);
const Color lightOrange = Color(0xFFFFA85C);

class CryRecorder extends StatefulWidget {
  const CryRecorder({Key? key}) : super(key: key);

  @override
  _CryRecorderState createState() => _CryRecorderState();
}

class _CryRecorderState extends State<CryRecorder>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _blowAnimation;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String _filePath = '';

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _blowAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  // Future<void> _initializeRecorder() async {
  //   // Request microphone permission
  //   var micStatus = await Permission.microphone.request();
  //   // Request storage permission
  //   var storageStatus = await Permission.storage.request();
  //
  //   // Check if permissions are granted
  //   if (micStatus != PermissionStatus.granted ||
  //       storageStatus != PermissionStatus.granted) {
  //     print('Microphone or Storage permission not granted');
  //     return;
  //   }
  //
  //   await _recorder.openRecorder();
  //   _recorder.setSubscriptionDuration(Duration(milliseconds: 500));
  // }



  Future<void> _initializeRecorder() async {
    var micStatus = await Permission.microphone.request();

    if (Platform.isAndroid && micStatus.isGranted) {
      if (await Permission.storage.request().isDenied ||
          (await Permission.manageExternalStorage.isDenied &&
              await Permission.manageExternalStorage.request().isDenied)) {
        print("Storage permission not granted");
        return;
      }
    }

    if (micStatus.isGranted) {
      await _recorder.openRecorder();
      _recorder.setSubscriptionDuration(Duration(milliseconds: 500));
    } else {
      print('Microphone permission not granted');
      return;
    }
  }


  Future<void> startRecording() async {
    if (isRecording) return;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    _filePath = '${appDocDir.path}/buffer.wav';

    setState(() {
      isRecording = true;
    });

    _controller.stop(); // Stop the pulsating animation when recording starts

    try {
      // Ensure the recorder is open
      if (!_recorder.isRecording) {
        await _recorder.openRecorder();
      }

      await _recorder.startRecorder(
        toFile: _filePath,
        codec: Codec.pcm16WAV, // Save as .wav file
      );

      // Simulate a 10-second recording
      Future.delayed(const Duration(seconds: 10), () {
        stopRecording();
      });
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  // Future<void> startRecording() async {
  //   if (isRecording) return;
  //
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   _filePath = '${appDocDir.path}/buffer.wav';
  //
  //   // Directory tempDir = await getTemporaryDirectory();
  //   // _filePath = '${tempDir.path}/buffer.wav'; // Path for .wav file
  //
  //   setState(() {
  //     isRecording = true;
  //   });
  //
  //   _controller.stop(); // Stop the pulsating animation when recording starts
  //
  //   try {
  //     await _recorder.startRecorder(
  //       toFile: _filePath,
  //       codec: Codec.pcm16WAV, // Save as .wav file
  //     );
  //
  //     // Simulate a 10-second recording
  //     Future.delayed(const Duration(seconds: 10), () {
  //       stopRecording();
  //     });
  //   } catch (e) {
  //     print('Error starting recording: $e');
  //   }
  // }

  Future<void> stopRecording() async {
    if (!isRecording) return;

    try {
      await _recorder.stopRecorder();
      setState(() {
        isRecording = false;
      });

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Recording Complete'),
            content: const Text('Your recording has been successfully saved.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CryAnalyzer(),
                  ));
                },
              ),
            ],
          );
        },
      );

      // Upload the file to the backend
      await _uploadRecording();
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  // Future<void> stopRecording() async {
  //   await _recorder.stopRecorder();
  //   setState(() {
  //     isRecording = false;
  //   });

  //   // Handle recording completion and navigate to another page
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => CryAnalyzer(),
  //   ));

  //   // Upload the file to the backend
  //   await _uploadRecording();
  // }

  Future<void> _uploadRecording() async {
    if (_filePath.isEmpty) return;

    try {
      File file = File(_filePath);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://e2f7-212-104-231-182.ngrok-free.app/predict'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('File upload failed with status: ${response.statusCode}');
        // Optionally, show an error dialog to the user
      }
    } catch (e) {
      print('Error uploading file: $e');
      // Optionally, show an error dialog to the user
    }
  }

  void cancelRecording() {
    if (!isRecording) return;

    setState(() {
      isRecording = false;
    });

    // Stop the animation if it is running
    _controller.stop();

    // Navigate back to the recording page
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CryRecorder(),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Recording',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: customOrange,
        elevation: 1,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: Container(
        color: customOrange,
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Tap to translate',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 65),
            GestureDetector(
              onTap: isRecording ? null : startRecording,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 230,
                          height: 230,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                lightOrange.withOpacity(0),
                                lightOrange.withOpacity(0.7),
                              ],
                              stops: const [0.5, 1.0],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  if (!isRecording)
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _blowAnimation.value,
                          child: Container(
                            width: 230,
                            height: 230,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                                width: 5,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  if (isRecording)
                    SizedBox(
                      width: 230,
                      height: 230,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: customOrange,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orangeAccent.withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: cancelRecording,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryHistory(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'VIEW CRY HISTORY',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
