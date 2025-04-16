import 'package:flutter/material.dart';

class RecentSearches extends StatelessWidget {
  final List<String> recentSearches;
  final Function(String) onSearch;

  const RecentSearches({
    Key? key,
    required this.recentSearches,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) {
      return const Center(
        child: Text(
          'Search for a word to begin',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Recent Searches',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(recentSearches[index]),
                  trailing: const Icon(Icons.search),
                  onTap: () => onSearch(recentSearches[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}