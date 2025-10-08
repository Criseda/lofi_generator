import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  JustAudioMediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lofi Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lofi Generator Home Page'),
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
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudioPlayer();
  }

  Future<void> _setupAudioPlayer() async {
    try {
      String audioUrl =
          '${AppConfig.baseUrl}/test/Cymatics%20-%20Lofi%20Vinyl%20Crackle%20Looped%206.wav';
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(audioUrl)));
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error setting up audio player: $e');
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lofi Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Test Audio'),
            const SizedBox(height: 10),
            // Use a StreamBuilder to react to player state changes
            StreamBuilder<PlayerState>(
              stream: _audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;

                // Show a loading indicator while the player is preparing
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return const CircularProgressIndicator();
                }

                // If playing, show a pause button
                if (playing == true) {
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 64.0,
                    onPressed: _audioPlayer.pause,
                  );
                } else {
                  // Otherwise, show a play button
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    iconSize: 64.0,
                    onPressed: _audioPlayer.play,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
