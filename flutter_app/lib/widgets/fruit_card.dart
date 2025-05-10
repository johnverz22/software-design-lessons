import 'package:app1/config/constants.dart';
import 'package:app1/pages/fruit_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:app1/models/fruit.dart';

class FruitCard extends StatelessWidget {
  final Fruit fruit;

  const FruitCard({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FruitDetailScreen(fruit: fruit),
              ),
            );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'fruit-image-${fruit.id}',
              child: _buildFruitImage(),
            ),

            // Fruit name at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: .7),
                    ],
                  ),
                ),
                child: Text(
                  fruit.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFruitImage() {
  // Check if imageUrl is null
  if (fruit.imageUrl == null) {
    // Return the placeholder with error icon directly
    return Builder(
      builder: (context) => Container(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: .2),
        child: Icon(
          Icons.image_not_supported,
          size: 50,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
  
  // If imageUrl exists, proceed with network image
  return Image.network(
    '${AppConstants.apiURL}/static/${fruit.imageUrl}',
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: .2),
        child: Icon(
          Icons.image_not_supported,
          size: 50,
          color: Theme.of(context).colorScheme.secondary,
        ),
      );
    },
  );
}
}
