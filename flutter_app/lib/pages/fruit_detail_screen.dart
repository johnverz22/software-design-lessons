import 'package:app1/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:app1/models/fruit.dart';

class FruitDetailScreen extends StatelessWidget {
  final Fruit fruit;

  const FruitDetailScreen({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: mediaQuery.size.height * 0.4,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'fruit-image-${fruit.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Check if imageUrl is null
                    if (fruit.imageUrl == null)
                      // Return a placeholder with error icon
                      Builder(
                        builder: (context) => Container(
                          color: theme.colorScheme.secondary.withValues(alpha: .2),
                          child: Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              size: 64,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      )
                    else
                      // If imageUrl exists, load the network image
                      Image.network(
                        '${AppConstants.apiURL}/static/${fruit.imageUrl}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: theme.colorScheme.secondary.withValues(alpha: .2),
                            child: Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                size: 64,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          );
                        },
                      ),
                    // Add a gradient overlay for better text visibility
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: .7),
                            ],
                            stops: const [0.7, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // title: Text(fruit.name),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          fruit.name,
                          style: theme.textTheme.displayMedium,
                        ),
                      ),
                      Chip(
                        label: Text(
                          fruit.seedless ? 'Seedless' : 'Has Seeds',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: fruit.seedless 
                          ? theme.colorScheme.tertiary 
                          : Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Information',
                            style: theme.textTheme.titleLarge,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            context,
                            'ID',
                            '${fruit.id}',
                            Icons.tag,
                          ),
                          _buildInfoRow(
                            context,
                            'Seeds',
                            fruit.seedless ? 'No seeds' : 'Has seeds',
                            Icons.grain,
                          ),
                         _buildInfoRow(
                          context,
                          'Image Path',
                          fruit.imageUrl ?? 'No image available',
                          Icons.image,
                        ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Description',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'This is a ${fruit.seedless ? 'seedless' : 'seeded'} ${fruit.name}. '
                        'It was added to the fruit basket collection and can be found in your virtual garden.',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.tertiary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}