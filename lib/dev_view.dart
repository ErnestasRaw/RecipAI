import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
              http.Response response = await http.get(
                Uri.parse('http://192.168.1.117:5041/Recipe/GetAllFavouriteRecipes/1'),
                headers: {
                  'accept': 'text/plain',
                },
              );
              print(response.body);
            },
            child: const Text('API test 1'),
          ),
        ],
      ),
    );
  }
}
