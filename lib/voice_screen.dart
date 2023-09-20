
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class SpeechToTextScreen extends StatefulWidget {
//   @override
//   _SpeechToTextScreenState createState() => _SpeechToTextScreenState();
// }

// class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
//   final SpeechToText _speech = SpeechToText();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isListening = false;
//   String _text = '';
//   List<int> _soundWaveSamples = [];

//   void _startListening() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize();
//       if (available) {
//         setState(() {
//           _isListening = true;
//         });
//         _speech.listen(
//           onSoundLevelChange: (level) {
//             setState(() {
//               _soundWaveSamples.add(level.toInt());
//             });
//           },
//           onResult: (result) {
//             setState(() {
//               _text = result.recognizedWords;
//             });
//           },
//         );
//         await _audioPlayer.setAsset('assets/audio/sound.wav');
//         await _audioPlayer.play();
//       }
//     }
//   }

//   void _stopListening() async {
//     if (_isListening) {
//       await _audioPlayer.stop();
//       setState(() {
//         _isListening = false;
//         _soundWaveSamples.clear();
//         _speech.stop();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Speech to Text with Sound Wave'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.blueGrey[100],
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Text(
//                 _text,
//                 style: TextStyle(fontSize: 18.0),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Container(
//               height: 200.0,
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(show: false),
//                   borderData: FlBorderData(show: false),
//                   minX: 0,
//                   maxX: 100,
//                   minY: 0,
//                   maxY: 200,
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: _soundWaveSamples
//                           .map((sample) =>
//                               FlSpot(_soundWaveSamples.indexOf(sample).toDouble(), sample.toDouble()))
//                           .toList(),
//                       isCurved: true,
//                       // colors: [Colors.blue],
//                       color: Colors.blue,
//                       dotData: FlDotData(show: false),
//                       belowBarData: BarAreaData(show: false),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: CustomFAB(
//         isListening: _isListening,
//         onStart: _startListening,
//         onStop: _stopListening,
//       ),
//     );
//   }
// }

// class CustomFAB extends StatelessWidget {
//   final bool isListening;
//   final VoidCallback onStart;
//   final VoidCallback onStop;

//   CustomFAB({required this.isListening, required this.onStart, required this.onStop});

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: isListening ? onStop : onStart,
//       child: Icon(isListening ? Icons.stop : Icons.mic),
//       backgroundColor: isListening ? Colors.red : Colors.blue,
//     );
//   }
// }



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';

class SpeechToTextScreen extends StatefulWidget {
  @override
  _SpeechToTextScreenState createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text with Waveform Display'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Waveform(
                data: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0, 0.8, 0.6, 0.4, 0.2],
                height: 100.0,
                color: Colors.blue,
                backgroundColor: Colors.grey[300],
                isPlaying: _isListening,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              _text,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        isListening: _isListening,
        onStartListening: () async {
          if (!_isListening) {
            var available = await _speech.initialize();
            if (available) {
              setState(() {
                _isListening = true;
              });
              _speech.listen(
                onResult: (result) {
                  setState(() {
                    _text = result.recognizedWords;
                  });
                },
              );
            }
          }
        },
        onStopListening: () {
          if (_isListening) {
            setState(() {
              _isListening = false;
              _text = '';
            });
            _speech.stop();
          }
        },
      ),
    );
  }
}

Waveform({required List<double> data, required double height, required MaterialColor color, Color? backgroundColor, required bool isPlaying}) {
}

class CustomFloatingActionButton extends StatelessWidget {
  final bool isListening;
  final VoidCallback onStartListening;
  final VoidCallback onStopListening;

  CustomFloatingActionButton({
    required this.isListening,
    required this.onStartListening,
    required this.onStopListening,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isListening ? onStopListening : onStartListening,
      child: Icon(isListening ? Icons.stop : Icons.mic),
      backgroundColor: isListening ? Colors.red : Colors.blue,
    );
  }
}