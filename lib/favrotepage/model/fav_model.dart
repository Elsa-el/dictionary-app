import 'package:hive/hive.dart';
//part 'fav_model.g.dart';

@HiveType(typeId: 0)
class FavoriteWord {
  @HiveField(0)
  final String word;

  @HiveField(1)
  final String meaning;

  FavoriteWord(this.word, this.meaning);
}
