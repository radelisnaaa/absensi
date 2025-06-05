import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeService {
  final Dio _dio = Dio();
  final String baseUrl = 'YOUR_API_BASE_URL'; // Replace with your API URL

  Future<bool> submitAttendance(String imagePath, BuildContext context) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Mengirim absensi...'),
              ],
            ),
          );
        },
      );

      FormData formData;
      if (kIsWeb) {
        // For web, the imagePath is already in base64 format
        formData = FormData.fromMap({
          'photo': await MultipartFile.fromBytes(
            base64Decode(imagePath.split(',').last),
            filename: 'photo.jpg',
          ),
          'timestamp': DateTime.now().toIso8601String(),
        });
      } else {
        // For mobile, use file path
        String fileName = imagePath.split('/').last;
        formData = FormData.fromMap({
          'photo': await MultipartFile.fromFile(
            imagePath,
            filename: fileName,
          ),
          'timestamp': DateTime.now().toIso8601String(),
        });
      }

      // Send attendance data to server
      final response = await _dio.post(
        '$baseUrl/api/attendance',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // Close loading dialog
      if (context.mounted) Navigator.pop(context);

      if (response.statusCode == 200) {
        // Show success dialog
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Sukses'),
                content: const Text('Absensi berhasil tercatat'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        return true;
      } else {
        throw Exception('Failed to submit attendance');
      }
    } catch (e) {
      // Close loading dialog if still showing
      if (context.mounted) Navigator.pop(context);
       
       
      
      // Show error dialog
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Gagal mengirim absensi: ${e.toString()}'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
      return false;
    }
  }
}