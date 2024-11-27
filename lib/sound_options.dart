import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundScreen extends StatefulWidget {
  const SoundScreen({Key? key}) : super(key: key);

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String currentPlaying = "";

  final Map<String, String> sounds = {
    "Breathing Exercise": "assets/sounds/breathing_exercise.mp3",
    "Ocean Waves": "assets/sounds/ocean_waves.mp3",
    "Ambient Music": "assets/sounds/ambient_music.mp3",
  };

  Future<void> _playSound(String soundName, String filePath) async {
    try {
      if (currentPlaying == soundName) {
        // Stop the sound if already playing
        await _audioPlayer.stop();
        setState(() {
          currentPlaying = "";
        });
      } else {
        // Play the selected sound
        await _audioPlayer.stop(); // Ensure other sounds are stopped before playing
        await _audioPlayer.play(AssetSource(filePath));
        setState(() {
          currentPlaying = soundName;
        });
      }
    } catch (e) {
      print("Error playing sound: $e");
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
      appBar: AppBar(
        title: const Text('Music & Sounds'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Relaxing Sounds for Yoga",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: sounds.keys.length,
                itemBuilder: (context, index) {
                  String soundName = sounds.keys.elementAt(index);
                  String filePath = sounds[soundName] ?? "";

                  return ListTile(
                    title: Text(soundName),
                    trailing: Icon(
                      currentPlaying == soundName
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.blue,
                    ),
                    onTap: () => _playSound(soundName, filePath),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            if (currentPlaying.isNotEmpty)
              Text(
                "Currently Playing: $currentPlaying",
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              const Text(
                "No sound is playing.",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
