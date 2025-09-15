import 'package:dealsapp/Bloc/dealBloc.dart';
import 'package:dealsapp/repository/dealRepository.dart';
import 'package:dealsapp/screeens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => DealRepository(), // Provide repository first
      child: BlocProvider(
        create:
            (context) => DealBloc(
              RepositoryProvider.of<DealRepository>(
                context,
              ), // inject repository into bloc
            ),
        child: MaterialApp(
          title: 'DealsApp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
