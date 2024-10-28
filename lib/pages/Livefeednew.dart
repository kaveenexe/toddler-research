import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const Color customOrange = Color(0xFFFF7000);

class LivefeedNew extends StatefulWidget {
  const LivefeedNew({Key? key}) : super(key: key);

  @override
  _LivefeedState createState() => _LivefeedState();
}

class _LivefeedState extends State<LivefeedNew> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  String _detectedEmotion = 'No emotion detected';
  String _detectedGesture = 'No gesture detected';
  bool _isProcessing = false;
  Timer? _timer;
  DateTime? _lastNotificationTime;
  IO.Socket? _socket;
  bool _notificationsEnabled = true;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String notificationChannelId = 'crying_detection_channel';
  static const String notificationChannelName = 'Crying Detection Alerts';
  static const String notificationChannelDescription =
      'Alerts when crying is detected';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeSocket();
    _initializeNotifications();
  }

  void _initializeSocket() {
    _socket = IO.io('http://192.168.1.102:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket!.onConnect((_) {
      print('Socket connection established');
    });

    _socket!.on('detection_result', (data) {
      setState(() {
        _detectedEmotion = data['emotion'] ?? 'No emotion detected';
        _detectedGesture = data['gesture'] ?? 'No gesture detected';
      });

      if (_isCryingEmotion(_detectedEmotion) && _notificationsEnabled) {
        _showCryingEmotionNotification();
      }
    });

    _socket!.onDisconnect((_) {
      print('Socket disconnected');
    });

    _socket!.connect();
  }

  Future<void> _initializeCamera() async {
    try {
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
    } catch (e) {
      print('Error initializing camera: $e');
      _showErrorDialog('Camera Error', 'Failed to initialize camera: $e');
    }
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    await _requestNotificationPermissions();
    await _createNotificationChannel();
  }

  Future<void> _requestNotificationPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      await androidImplementation.requestPermission();
    }
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId,
      notificationChannelName,
      description: notificationChannelDescription,
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
      showBadge: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void _startImageStream() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!_isProcessing && _socket != null && _socket!.connected) {
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

    try {
      final image = await _cameraController!.takePicture();
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      _socket!.emit('stream_frame', {'image': base64Image});
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      _isProcessing = false;
    }
  }

  bool _isCryingEmotion(String emotion) {
    final cryingIndicators = ['crying', 'sad', 'distressed', 'tears'];
    return cryingIndicators.any(
        (indicator) => emotion.toLowerCase().contains(indicator.toLowerCase()));
  }

  Future<void> _showCryingEmotionNotification() async {
    if (_lastNotificationTime != null) {
      final timeDifference = DateTime.now().difference(_lastNotificationTime!);
      if (timeDifference.inSeconds < 10) {
        return;
      }
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      notificationChannelId,
      notificationChannelName,
      channelDescription: notificationChannelDescription,
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      enableLights: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Crying Detected!',
      'Your toddler appears to be crying. Please check immediately.',
      platformChannelSpecifics,
      payload: 'crying_detected',
    );

    _lastNotificationTime = DateTime.now();
  }

  void _onNotificationTapped(NotificationResponse details) {
    if (details.payload == 'crying_detected') {
      print('Notification tapped: ${details.payload}');
    }
  }

  Future<void> _showErrorDialog(String title, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    _socket?.disconnect();
    _socket?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Toddler Monitor',
            style: TextStyle(color: Colors.white)),
        backgroundColor: customOrange,
        actions: [
          IconButton(
            icon: Icon(
              _notificationsEnabled
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _notificationsEnabled = !_notificationsEnabled;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _notificationsEnabled
                        ? 'Notifications enabled'
                        : 'Notifications disabled',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: _cameraController != null &&
                            _cameraController!.value.isInitialized
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              CameraPreview(_cameraController!),
                              Positioned(
                                left: 16,
                                top: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: customOrange.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.fiber_manual_record,
                                          color: Colors.red),
                                      SizedBox(width: 5),
                                      Text('Monitoring',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildIndicator('Detected Emotion', _detectedEmotion,
                  Icons.sentiment_satisfied, Colors.blue),
              const SizedBox(height: 16),
              _buildIndicator('Detected Gesture', _detectedGesture,
                  Icons.gesture, Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(
      String title, String value, IconData iconData, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: customOrange),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(iconData, color: color, size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: color),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
