import 'package:flutter/material.dart';

class HomeProfileWidget extends StatefulWidget {
  const HomeProfileWidget({super.key});

  @override
  State<HomeProfileWidget> createState() => _HomeProfileWidgetState();
}

class _HomeProfileWidgetState extends State<HomeProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              'https://placehold.co/600x400/png',
              width:48.0,
              height:48.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width:16),
          Expanded(
            child: Text(
              'Hello, User',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
              maxLines: 2,
            ),
          ),
        ],
      );
  }
}