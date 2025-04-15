class DictionaryResponse {
  final String word;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;

  DictionaryResponse({
    required this.word,
    required this.phonetics,
    required this.meanings,
  });

  factory DictionaryResponse.fromJson(Map<String, dynamic> json) {
    return DictionaryResponse(
      word: json['word'],
      phonetics: List<Phonetic>.from(
          json['phonetics'].map((x) => Phonetic.fromJson(x))),
      meanings: List<Meaning>.from(
          json['meanings'].map((x) => Meaning.fromJson(x))),
    );
  }
}

class Phonetic {
  final String? text;
  final String? audio;

  Phonetic({this.text, this.audio});

  factory Phonetic.fromJson(Map<String, dynamic> json) {
    return Phonetic(
      text: json['text'],
      audio: json['audio'],
    );
  }
}

class Meaning {
  final String partOfSpeech;
  final List<Definition> definitions;
  final List<String> synonyms;
  final List<String> antonyms;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      partOfSpeech: json['partOfSpeech'],
      definitions: List<Definition>.from(
          json['definitions'].map((x) => Definition.fromJson(x))),
      synonyms: List<String>.from(json['synonyms']),
      antonyms: List<String>.from(json['antonyms']),
    );
  }
}

class Definition {
  final String definition;
  final String? example;

  Definition({required this.definition, this.example});

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      definition: json['definition'],
      example: json['example'],
    );
  }
}