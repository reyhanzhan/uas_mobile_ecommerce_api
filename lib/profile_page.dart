import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final List<Map<String, String>> profiles = [
    {
      'profileImageUrl': 'assets/reyhan.jpeg',
      'name': 'Reyhan',
    },
    {
      'profileImageUrl': 'assets/rosi.jpeg',
      'name': 'Roszi',
    },
    {
      'profileImageUrl': 'assets/wulan.jpeg',
      'name': 'Wulan',
    },
    {
      'profileImageUrl': 'assets/andi.jpeg',
      'name': 'Andi',
    },
    {
      'profileImageUrl': 'assets/iqbal.jpeg',
      'name': 'Iqbal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profiles'),
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(profiles[index]['profileImageUrl']!),
                ),
                SizedBox(height: 30),
                Text(
                  profiles[index]['name']!,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(thickness: 2),
              ],
            ),
          );
        },
      ),
    );
  }
}
