import 'package:flutter/material.dart';
import '../models/dictionary_model.dart';

class AntonymsTab extends StatelessWidget {
  final DictionaryResponse wordData;
  final Function(String) onSearch;

  const AntonymsTab({
    Key? key,
    required this.wordData,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final antonyms = <String>{};
    for (var meaning in wordData.meanings) {
      antonyms.addAll(meaning.antonyms);
    }

    if (antonyms.isEmpty) {
      return const Center(
        child: Text(
          'No antonyms found',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: antonyms.length,
      itemBuilder: (context, index) {
        final antonym = antonyms.elementAt(index);
        return Card(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            title: Text(antonym),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onSearch(antonym),
          ),
        );
      },
    );
  }
}