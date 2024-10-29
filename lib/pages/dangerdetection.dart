import 'dart:async';  
import 'dart:convert';  
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;  
import 'package:audioplayers/audioplayers.dart';  
import 'package:flutter_tts/flutter_tts.dart';

class DangerLivefeed extends StatefulWidget {
  @override
  _DangerLivefeedState createState() => _DangerLivefeedState();
}

class _DangerLivefeedState extends State<DangerLivefeed> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  String _detectedObjects = 'No dangerous objects detected';
  bool _isProcessing = false;
  Timer? _timer;
  DateTime? _lastAlertTime;

  AudioPlayer _audioPlayer = AudioPlayer();
  FlutterTts _flutterTts = FlutterTts();

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
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
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
        Uri.parse('https://b354-2402-4000-13d0-5df4-7488-f71d-fb87-319d.ngrok-free.app/process_image'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() {
          _detectedObjects = result['alert_message'] ?? 'No dangerous objects detected';

          // Trigger the alert sequence if a dangerous object is detected and avoid repeated alerts
          if (result['alert_message'] != null && result['alert_message'].isNotEmpty) {
            _triggerAlertSequence(result['alert_message']);
          }
        });
      } else {
        setState(() {
          _detectedObjects = 'Server Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _detectedObjects = 'Network Error: Unable to process image';
      });
      print('Error processing image: $e');
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _triggerAlertSequence(String detectedObject) async {
    final currentTime = DateTime.now();
    if (_lastAlertTime == null || currentTime.difference(_lastAlertTime!) > Duration(seconds: 5)) {
      _lastAlertTime = currentTime;

      await _playAlertSound();
      await Future.delayed(Duration(seconds: 1));
      await _speakAlert(detectedObject);
      await Future.delayed(Duration(seconds: 2));
      await _playAlertSound();
    }
  }

  Future<void> _playAlertSound() async {
    await _audioPlayer.play(AssetSource('alert.mp3'));
  }

  Future<void> _speakAlert(String detectedObject) async {
    String message = '';

    if (detectedObject.contains("knife")) {
      message = 'Knife detected! This is not a safe zone.';
    } else if (detectedObject.contains("scissor")) {
      message = 'Scissor detected! Please remove it immediately.';
    } else if (detectedObject.contains("plug")) {
      message = 'Plug point detected! This is not a safe zone.';
    } else {
      message = 'No dangerous objects detected.';
    }

    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(message);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    _audioPlayer.dispose();
    _flutterTts.stop();
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
          Expanded(child: CameraPreview(_cameraController!)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Detected Objects:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                AnimatedOpacity(
                  opacity: _detectedObjects.contains('No dangerous objects') ? 0.5 : 1.0,
                  duration: Duration(seconds: 1),
                  child: Text(
                    _detectedObjects,
                    style: TextStyle(
                      fontSize: 18,
                      color: _detectedObjects.contains('No dangerous objects') ? Colors.green : Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
