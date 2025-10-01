import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqldemo/core/graphql_client.dart';
import 'package:graphqldemo/views/countries_screen.dart';

void main() async {
  // Initialize GraphQL client
  await initHiveForFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GraphQL Demo with GetX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 2,
          centerTitle: true,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: GraphQLProvider(
        client: GraphQLConfig.clientNotifier,
        child: CountriesScreen(),
      ),
      // Configure GetX routing if needed for future expansion
      getPages: [
        GetPage(
          name: '/countries',
          page: () => CountriesScreen(),
        ),
      ],
      initialRoute: '/countries',
    );
  }
}
