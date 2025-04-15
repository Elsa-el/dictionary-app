import 'package:flutter/material.dart';
import '../models/dictionary_model.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final List<Phonetic> phonetics;

  const AudioPlayerWidget({Key? key, required this.phonetics})
    : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  Future<void> playAudioFromUrl(String url) async {
    final player = AudioPlayer();

    try {
      await player.setUrl(url);
      player.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioPhonetics = widget.phonetics.where(
      (p) => p.audio?.isNotEmpty ?? false,
    );

    if (audioPhonetics.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children:
          audioPhonetics.map((phonetic) {
            return Row(
              children: [
                if (phonetic.text != null)
                  Text(
                    phonetic.text!,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {
                    print("This is the url  ${phonetic.audio.toString()}");
                    playAudioFromUrl(phonetic.audio.toString());
                    
                  },
                ),
              ],
            );
          }).toList(),
    );
  }
}
