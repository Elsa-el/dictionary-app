import 'package:flutter/material.dart';
import '../models/dictionary_model.dart';

class DefinitionTab extends StatelessWidget {
  final DictionaryResponse wordData;

  const DefinitionTab({super.key, required this.wordData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...wordData.meanings.map((meaning) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meaning.partOfSpeech,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                      //  style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...meaning.definitions.map((definition) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ${definition.definition}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          if (definition.example != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                top: 4.0,
                              ),
                              child: Text(
                                '"${definition.example}"',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
