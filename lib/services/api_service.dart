import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // She will replace this with her FastAPI URL
  static const String baseUrl = "http://YOUR_API_IP:8000";

  // TODO: She will link these to her FastAPI logic
  Future<Map<String, dynamic>> getFatigueData() async => {};
  Future<Map<String, dynamic>> getUsageData() async => {};
}