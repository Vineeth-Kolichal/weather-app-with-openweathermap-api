import 'package:flutter/material.dart';
import 'package:weather/application/bloc/home_screen_bloc.dart';
import 'package:weather/domain/di/dependancy_injection.dart';
import 'package:weather/infrastructure/home_screen/home_screen_repo.dart';
import 'package:weather/presentation/home_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeScreenBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(218, 144, 174, 202),
          brightness: Brightness.dark,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
