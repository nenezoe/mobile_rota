// speech_text_model.dart
import 'package:hive/hive.dart';

// part 'speech_text_model.g.dart';

@HiveType(typeId: 0)
class SpeechTextModel extends HiveObject {
  @HiveField(0)
  String text;

  SpeechTextModel(this.text);
}






