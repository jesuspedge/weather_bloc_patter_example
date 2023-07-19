import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '⛅',
          style: TextStyle(fontSize: 65),
        ),
        Text(
          'Loading weather...',
          style: theme.textTheme.headlineSmall,
        )
      ],
    );
  }
}
