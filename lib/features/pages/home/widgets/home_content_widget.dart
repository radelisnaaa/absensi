import 'package:absen/core/extensions/date_time_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class HomeContentWidget extends StatefulWidget {
  const HomeContentWidget({super.key});

  @override
  State<HomeContentWidget> createState() => _HoneContentWidgetState();
}

class _HoneContentWidgetState extends State<HomeContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Text(
            DateTime.now().toFormattedTime(),
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Text(
            DateTime.now().toFormattedDate(),
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
          const SizedBox(height: 18.0),
          const Divider(),
          const SizedBox(height: 30.0),
          Text(
            DateTime.now().toFormattedDate(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            '${DateTime(2024, 3, 14, 8, 0).toFormattedTime()}'
                ' - ${DateTime(2024, 3, 14, 16, 0).toFormattedTime()}',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}