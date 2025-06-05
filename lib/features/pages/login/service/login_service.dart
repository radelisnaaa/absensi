import 'package:dio/dio.dart';
import '../model/login_response.dart';

// Service untuk handle API calls
class LoginService {
  final Dio _dio;
  final String baseUrl =
      'https://idbc.abdrrahmenz.my.id'; // Ganti dengan base URL API Anda

  LoginService() : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Future<LoginResponse> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/api/admin/login', // Sesuaikan dengan endpoint login Anda
        data: {'login': username, 'password': password},
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      return LoginResponse(
        message: e.response?.data['message'] ?? 'Terjadi kesalahan',
      );
    } catch (e) {
      return LoginResponse(message: 'Terjadi kesalahan yang tidak terduga');
    }
  }
}