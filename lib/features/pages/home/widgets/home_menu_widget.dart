import 'package:absen/core/constants/colors.dart';
import 'package:flutter/material.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.symmetric(horizontal: 36),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMenuItem(title: 'Datang', icon: Icons.access_time, onTap: () {}),
        _buildMenuItem(
          title: 'Pulang',
          icon: Icons.access_time_filled,
          onTap: () {},
        ),
        _buildMenuItem(title: 'Izin', icon: Icons.person, onTap: () {}),
        _buildMenuItem(
          title: 'Catatan',
          icon: Icons.note_alt_outlined,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(18.0),
            border:
            Border.all(
                color: Colors.grey)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),


    );
  }
}