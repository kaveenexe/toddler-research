import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

const Color customOrange = Color(0xFFFF7000);

class Livefeed extends StatefulWidget {
  @override
  _LivefeedState createState() => _LivefeedState();
}

class _LivefeedState extends State<Livefeed> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  String _detectedEmotion = 'No emotion detected';
  bool _isProcessing = false;
  Timer? _timer;

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
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
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
        Uri.parse('http://192.168.1.102:5000/process_image'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() {
          _detectedEmotion = result['emotion'] ?? 'No emotion detected';
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      _isProcessing = false;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  Widget _buildEmotionIndicator(String emotion) {
    IconData iconData;
    Color color;

    switch (emotion.toLowerCase()) {
      case 'happy':
        iconData = Icons.sentiment_very_satisfied;
        color = Colors.green;
        break;
      case 'sad':
        iconData = Icons.sentiment_very_dissatisfied;
        color = Colors.blue;
        break;
      default:
        iconData = Icons.sentiment_neutral;
        color = Colors.grey;
    }

    return Row(
      children: [
        Icon(iconData, color: color, size: 28),
        SizedBox(width: 8),
        Text(
          emotion,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Toddler Monitor', style: TextStyle(color: Colors.white)),
        backgroundColor: customOrange,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: customOrange, width: 3),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: _cameraController != null && _cameraController!.value.isInitialized
                        ? Stack(
                      fit: StackFit.expand,
                      children: [
                        CameraPreview(_cameraController!),
                        Positioned(
                          left: 16,
                          top: 16,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: customOrange.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.fiber_manual_record, color: Colors.red, size: 12),
                                SizedBox(width: 4),
                                Text(
                                  'LIVE',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                        : Center(child: CircularProgressIndicator(color: customOrange)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detected Emotion',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: customOrange),
                    ),
                    SizedBox(height: 8),
                    _buildEmotionIndicator(_detectedEmotion),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}