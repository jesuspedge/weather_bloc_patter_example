import 'package:flutter/material.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '🏙️',
          style: TextStyle(fontSize: 65),
        ),
        Text(
          'Please, select a city!',
          style: theme.textTheme.headlineSmall,
        )
      ],
    );
  }
}
