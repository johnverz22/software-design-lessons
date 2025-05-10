import 'package:flutter/material.dart';
import 'package:app1/models/fruit.dart';
import 'package:app1/services/api_service.dart';
import 'package:app1/widgets/fruit_card.dart';

class FruitListScreen extends StatefulWidget {
  const FruitListScreen({super.key});
  @override
  State<FruitListScreen> createState() => _FruitListScreenState();
}

class _FruitListScreenState extends State<FruitListScreen> {
  final ApiService _apiService = ApiService();
  List<Fruit> _fruits = [];
  List<Fruit> _filteredFruits = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFruits();
    _searchController.addListener(_filterFruits);
  }

  Future<void> _loadFruits() async {
    try {
      final fruits = await _apiService.getFruits();
      setState(() {
        _fruits = fruits;
        _filteredFruits = fruits;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return; // If widget is not mounted, return
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading fruits: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  void _filterFruits() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _filteredFruits = _fruits;
      });
    } else {
      setState(() {
        _filteredFruits = _fruits
            .where((fruit) => fruit.name
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Fruits',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search fruits',
                  hintText: 'Enter fruit name',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                ),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredFruits.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.no_food,
                                size: 64,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No fruits found',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              if (_searchController.text.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Try a different search term',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ]
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadFruits,
                          child: GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.0,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _filteredFruits.length,
                            itemBuilder: (context, index) {
                              return FruitCard(fruit: _filteredFruits[index]);
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
