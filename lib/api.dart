
class DictionaryWord {
  final String word;
  final List<Meaning> meanings;
  final List<Phonetic> phonetics;

  DictionaryWord({
    required this.word,
    required this.meanings,
    required this.phonetics,
  });

  factory DictionaryWord.fromJson(Map<String, dynamic> json) {
    return DictionaryWord(
      word: json['word'],
      meanings: (json['meanings'] as List)
          .map((meaning) => Meaning.fromJson(meaning))
          .toList(),
      phonetics: (json['phonetics'] as List)
          .map((phonetic) => Phonetic.fromJson(phonetic))
          .toList(),
    );
  }
}

class Meaning {
  final String partOfSpeech;
  final List<Definition> definitions;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      partOfSpeech: json['partOfSpeech'],
      definitions: (json['definitions'] as List)
          .map((def) => Definition.fromJson(def))
          .toList(),
    );
  }
}

class Definition {
  final String definition;
  final String? example;

  Definition({
    required this.definition,
    this.example,
  });

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      definition: json['definition'],
      example: json['example'],
    );
  }
}

class Phonetic {
  final String? text;
  final String? audio;

  Phonetic({
    this.text,
    this.audio,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) {
    return Phonetic(
      text: json['text'],
      audio: json['audio'],
    );
  }
}