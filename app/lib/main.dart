import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intellicrews/camera.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliCrews',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'IntelliCrews'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isCameraOn = false;
  String? _cameraError;
  List<CameraDescription> _cameras = [];

  Future<void> _onCameraToggled() async {
    final isCameraOn = !_isCameraOn;
    if (isCameraOn && _cameras.isEmpty) {
      try {
        final cameras = await availableCameras();
        setState(() {
          _isCameraOn = true;
          _cameras = cameras;
          _cameraError = null;
        });
      } on CameraException catch (error) {
        setState(() {
          _isCameraOn = false;
          _cameraError = error.description ?? 'Failed to find a camera';
        });
      }
    } else {
      setState(() {
        _isCameraOn = isCameraOn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_cameraError != null)
              Text(_cameraError!)
            else if (_isCameraOn && _cameras.isNotEmpty)
              SizedBox.fromSize(
                size: const Size(600, 400),
                child: Camera(cameras: _cameras),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onCameraToggled,
        tooltip: _isCameraOn ? 'Turn off camera' : 'Turn on camera',
        child: _isCameraOn
            ? const Icon(Icons.toggle_on)
            : const Icon(Icons.toggle_off_outlined),
      ),
    );
  }
}
