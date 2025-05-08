import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/service_model.dart';
import '../../constants/api_constants.dart';

class ApiService {
  final String baseUrl = "https://681d1447f74de1d219aebf17.mockapi.io/api/v1";

  // Get all services
  Future<List<ServiceModel>> getServices() async {
    final response = await http.get(Uri.parse('$baseUrl/services'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((serviceData) => ServiceModel.fromJson(serviceData)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  // Create a new service
  Future<ServiceModel> createService(String name, String category, String imageUrl, double price, double rating, String duration, bool availability) async {
    final response = await http.post(
      Uri.parse('$baseUrl/services'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'category': category,
        'imageUrl': imageUrl,
        'price': price,
        'rating': rating,
        'duration': duration,
        'availability': availability,
      }),
    );

    if (response.statusCode == 201) {
      return ServiceModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add service');
    }
  }

  // Update an existing service
  Future<ServiceModel> updateService(String id, String name, String category, String imageUrl, double price, double rating, String duration, bool availability) async {
    final response = await http.put(
      Uri.parse('$baseUrl/services/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'category': category,
        'imageUrl': imageUrl,
        'price': price,
        'rating': rating,
        'duration': duration,
        'availability': availability,
      }),
    );

    if (response.statusCode == 200) {
      return ServiceModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update service');
    }
  }

  // Delete a service
  Future<void> deleteService(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/services/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete service');
    }
  }
}
