import 'dart:async';  // managing time-based actions such as delays and periodic function calls
import 'dart:convert';  //encoding and decoding JSON data
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;  //send the captured images to the backend API for object detection and receive responses.
import 'package:audioplayers/audioplayers.dart'; // Only use Audioplayers package

class Livefeed extends StatefulWidget {
  @override
  _LivefeedState createState() => _LivefeedState();
}

class _LivefeedState extends State<Livefeed> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  String _detectedObjects = 'No dangerous objects detected';
  bool _isProcessing = false;
  Timer? _timer;

  AudioPlayer _audioPlayer = AudioPlayer(); // Initialize AudioPlayer

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

     //Sets up a periodic timer that triggers the image capture every second
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

          // Play alert sound if a dangerous object is detected
          if (result['alert_message'] != null && result['alert_message'].isNotEmpty) {
            _playAlertSound();
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

  Future<void> _playAlertSound() async {
    // Play alert sound from assets
    await _audioPlayer.play(AssetSource('alert.mp3')); // Correct method for asset playback
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    _audioPlayer.dispose(); // Dispose the audio player
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
