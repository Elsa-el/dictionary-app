import 'package:flutter/material.dart';
import '../models/dictionary_model.dart';

class SynonymsTab extends StatelessWidget {
  final DictionaryResponse wordData;
  final Function(String) onSearch;

  const SynonymsTab({
    super.key,
    required this.wordData,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final synonyms = <String>{};
    for (var meaning in wordData.meanings) {
      synonyms.addAll(meaning.synonyms);
    }

    if (synonyms.isEmpty) {
      return const Center(
        child: Text(
          'No synonyms found',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: synonyms.length,
      itemBuilder: (context, index) {
        final synonym = synonyms.elementAt(index);
        return Card(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            title: Text(synonym),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onSearch(synonym),
          ),
        );
      },
    );
  }
}