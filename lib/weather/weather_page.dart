import 'package:bloc_weather_example/search/search_page.dart';
import 'package:bloc_weather_example/settings/settings_page.dart';
import 'package:bloc_weather_example/theme/cubit/theme_cubit.dart';
import 'package:bloc_weather_example/weather/cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_repository/weather_repository.dart';

import 'widgets/weather_widgets.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather Bloc'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push<void>(SettingsPage.route(context.read<WeatherCubit>()));
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<ThemeCubit>().updateTheme(state.weather);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherEmpty();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                return WeatherPopulated(
                  weather: state.weather,
                  units: state.temperatureUnits,
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  },
                );
              case WeatherStatus.failure:
                return const WeatherError();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());

          if (!mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city.toString());
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
