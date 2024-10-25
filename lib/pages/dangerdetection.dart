import 'dart:async';  
import 'dart:convert';  
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;  
import 'package:audioplayers/audioplayers.dart';  
import 'package:flutter_tts/flutter_tts.dart';  // Text-to-Speech for English

class DangerLivefeed extends StatefulWidget {
  @override
  _LivefeedState createState() => _LivefeedState();
}

class _LivefeedState extends State<DangerLivefeed> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  String _detectedObjects = 'No dangerous objects detected';
  bool _isProcessing = false;
  Timer? _timer;

  AudioPlayer _audioPlayer = AudioPlayer(); // Initialize AudioPlayer
  FlutterTts _flutterTts = FlutterTts(); // Initialize FlutterTTS for English

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.medium,
      );

      await _cameraController!.initialize();
      if (mounted) {
        setState(() {});
        _startImageStream();
      }
    }
  }

  void _startImageStream() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (!_isProcessing) {
        _isProcessing = true;
        _processImage();
      }
    });
  }

  Future<void> _processImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      _isProcessing = false;
      return;
    }

    final image = await _cameraController!.takePicture();
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.7:5000/process_image'), // Sends the image as a POST request to the Flask backend
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() {
          _detectedObjects = result['alert_message'] ?? 'No dangerous objects detected';

          // Trigger the alert sequence if a dangerous object is detected
          if (result['alert_message'] != null && result['alert_message'].isNotEmpty) {
            _triggerAlertSequence(result['alert_message']);
          }
        });
      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          _detectedObjects = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      print('Error processing image: $e');
      setState(() {
        _detectedObjects = 'Error processing image: $e';
      });
    } finally {
      _isProcessing = false;
    }
  }

  // Function to handle the alert sequence
  Future<void> _triggerAlertSequence(String detectedObject) async {
    // Play the initial alert sound
    await _playAlertSound();

    // Delay to allow sound to play fully
    await Future.delayed(Duration(seconds: 1));

    // Speak the relevant message based on the detected object
    await _speakAlert(detectedObject);

    // Delay for the TTS to complete before replaying the alert sound
    await Future.delayed(Duration(seconds: 2));

    // Play the alert sound again
    await _playAlertSound();
  }

  Future<void> _playAlertSound() async {
    // Play alert sound from assets
    await _audioPlayer.play(AssetSource('alert.mp3')); // Correct method for asset playback
  }

  // Updated _speakAlert function to give appropriate voice messages
  Future<void> _speakAlert(String detectedObject) async {
    String message = '';

    // Check detected object and create appropriate alert message
    if (detectedObject.contains("knife")) {
      message = 'Knife is detected! This is not a safe zone.';
    } else if (detectedObject.contains("scissor")) {
      message = 'Scissor is detected! Please remove them immediately.';
    } else if (detectedObject.contains("plug")) {
      message = 'Plug point is detected! This is not a safe zone.';
    } else {
      message = 'No dangerous objects detected.';
    }

    // Speak the message using text-to-speech
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(message); // English TTS for the alert
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    _audioPlayer.dispose(); // Dispose the audio player
    _flutterTts.stop(); // Stop TTS when screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text('Real-time Dangerous Object Detection')),
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(_cameraController!),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Detected Objects: $_detectedObjects',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

