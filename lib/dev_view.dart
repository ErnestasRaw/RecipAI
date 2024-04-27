import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:receptai/api/recipe_api.dart';
import 'package:receptai/helpers/logger_helper.dart';

class DevView extends StatefulWidget {
  const DevView({super.key});

  @override
  State<DevView> createState() => _DevViewState();
}

class _DevViewState extends State<DevView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev View'),
      ),
      body: Column(
        children: [
          const Text('Dev View'),
          ElevatedButton(
            onPressed: () async {
              Response response = await RecipeApi.getIngredients(2);
              xlog("Data: ${response.data}");
            },
            child: const Text('API test 1'),
          ),
        ],
      ),
    );
  }
}
