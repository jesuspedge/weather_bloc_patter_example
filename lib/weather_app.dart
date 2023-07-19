import 'package:bloc_weather_example/theme/cubit/theme_cubit.dart';
import 'package:bloc_weather_example/weather/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({required WeatherRepository weatherRepository, super.key})
      : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: BlocProvider(
        create: (_) => ThemeCubit(),
        child: const WeatherAppView(),
      ),
    );
  }
}

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final textThme = Theme.of(context).textTheme;
    return BlocBuilder<ThemeCubit, Color>(
      builder: (context, color) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: color,
            textTheme: GoogleFonts.rajdhaniTextTheme(),
            appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.rajdhaniTextTheme(textThme)
                  .apply(bodyColor: Colors.white)
                  .titleLarge,
            ),
          ),
          home: const WeatherPage(),
        );
      },
    );
  }
}
