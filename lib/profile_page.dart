import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Informasi pengguna dapat diperoleh dari backend atau penyimpanan lokal.
    // Untuk contoh ini, kita menggunakan data statis.
    String profileImageUrl =
        'assets/profile_image.png'; // Ganti dengan path gambar lokal
    String name = 'TIF PAGI';
    String email = 'TIFPAGI@gmail.com';
    String phone = '+1234567890';

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100, // Ukuran avatar lebih besar
                backgroundImage: AssetImage(profileImageUrl),
              ),
              SizedBox(height: 30),
              Text(
                name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                email,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 5),
              Text(
                phone,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              // SizedBox(height: 30),
              // ElevatedButton(
              //   onPressed: () {
              //     // Tambahkan logika untuk mengedit profil di sini.
              //   },
              //   child: Text('Edit Profile'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
