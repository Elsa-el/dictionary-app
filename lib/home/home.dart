import 'package:dictonary/widgrts/antonyms_tab.dart';
import 'package:dictonary/widgrts/audio_player.dart';
import 'package:dictonary/widgrts/defination_tab.dart';
import 'package:dictonary/widgrts/recent_searches.dart';
import 'package:dictonary/widgrts/synonyms_tab.dart';
import 'package:flutter/material.dart';
import '../services/dictionary_service.dart';
import '../models/dictionary_model.dart';
import 'package:hive/hive.dart';

class DictionaryHomePage extends StatefulWidget {
  @override
  _DictionaryHomePageState createState() => _DictionaryHomePageState();
}

class _DictionaryHomePageState extends State<DictionaryHomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = [];
  bool _isLoading = false;
  String? _errorMessage;
  DictionaryResponse? _wordData;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _wordData = null;
    });

    try {
      final response = await DictionaryService.fetchWordDefinition(query);
      setState(() {
        _wordData = response;
        if (!_recentSearches.contains(query)) {
          _recentSearches.insert(0, query);
          if (_recentSearches.length > 5) {
            _recentSearches.removeLast();
          }
        }
        _tabController.animateTo(0);
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DICTIONARY'),
        centerTitle: true,
        bottom:
            _wordData != null
                ? TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(icon: Icon(Icons.info), text: 'Definition'),
                    Tab(icon: Icon(Icons.compare_arrows), text: 'Synonyms'),
                    Tab(icon: Icon(Icons.compare), text: 'Antonyms'),
                  ],
                )
                : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a word...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _wordData = null;
                      _errorMessage = null;
                    });
                  },
                ),
              ),
              onSubmitted: _performSearch,
            ),
            const SizedBox(height: 16),

            if (_isLoading) const CircularProgressIndicator(),

            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),

            if (_wordData != null)
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _wordData!.word,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AudioPlayerWidget(phonetics: _wordData!.phonetics),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          DefinitionTab(wordData: _wordData!),
                          SynonymsTab(
                            wordData: _wordData!,
                            onSearch: _performSearch,
                          ),
                          AntonymsTab(
                            wordData: _wordData!,
                            onSearch: _performSearch,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: RecentSearches(
                  recentSearches: _recentSearches,
                  onSearch: _performSearch,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
