import 'package:bloc_weather_example/weather/models/weather.dart' as weat;
import 'package:flutter/material.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    required this.weather,
    required this.units,
    required this.onRefresh,
    super.key,
  });

  final weat.Weather weather;
  final weat.TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        _WeatherBackground(),
        RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  _WeatherIcon(condition: weather.condition),
                  Text(
                    weather.location,
                    style: theme.textTheme.displayMedium
                        ?.copyWith(fontWeight: FontWeight.w200),
                  ),
                  Text(
                    weather.formattedTemperature(units),
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}'''),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.condition});
  final WeatherCondition condition;

  static const _iconSize = 75.0;

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji,
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

extension on WeatherCondition {
  String get toEmoji {
    switch (this) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.snowy:
        return '🌨️';
      case WeatherCondition.unknown:
        return '❓';
    }
  }
}

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color,
              color.brighten(),
              color.brighten(33),
              color.brighten(50),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100, 'percent must be between 1 and 100');

    final p = percent / 100;

    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}

extension on weat.Weather {
  String formattedTemperature(weat.TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}
