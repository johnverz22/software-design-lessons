import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(23),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    )),
            SizedBox(
              height: 20,
            ),
            Text(
              'Fruit Basket',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 96),
            ),
          ],
        ));
  }
}
