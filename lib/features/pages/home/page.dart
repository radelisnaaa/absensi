import 'package:absen/features/pages/home/camera_page.dart';
import 'package:absen/features/pages/home/widgets/home_menu_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/components/buttons.dart';
import 'widgets/home_content_widget.dart';
import 'widgets/home_profile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/images/bg_home.png'),
              alignment: Alignment.topCenter,
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeProfileWidget(),
              const SizedBox(height: 16),
              HomeContentWidget(),
              const SizedBox(height: 24),
              HomeMenuWidget(),
              const SizedBox(height: 24),
              Button(
                icon: Icon(Icons.face, size: 40, color: Colors.white),
                label: 'Absensi Sekarang',
                onPressed: () async {
                  final String? imagePath = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraPage(),
                    ),
                  );

                  if (imagePath != null) {
                    // TODO: Handle the captured image
                    // You can upload the image to your server here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Foto berhasil diambil: $imagePath')),
                    );
                  }
                },
              )


            ],
          ),
        ),
      ),
    );
  }
}