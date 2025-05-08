import 'package:get/get.dart';
import 'package:mini_service_booking_app/data/models/service_model.dart';
import 'package:mini_service_booking_app/data/services/api_service.dart';

class ServiceController extends GetxController {
  var services = <ServiceModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Filters
  var searchQuery = ''.obs;
  var selectedCategory = ''.obs;
  var selectedRating = 0.0.obs;

  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  // Fetch all services
  Future<void> fetchServices() async {
    isLoading.value = true;
    try {
      services.value = await apiService.getServices();
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Error fetching services: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Filtered list of services
  List<ServiceModel> get filteredServices {
    return services.where((service) {
      final matchesSearch =
          service.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesCategory = selectedCategory.value.isEmpty ||
          service.category == selectedCategory.value;
      final matchesRating = service.rating >= selectedRating.value;
      return matchesSearch && matchesCategory && matchesRating;
    }).toList();
  }

  // Filter setters
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setCategoryFilter(String category) {
    selectedCategory.value = category;
  }

  void setRatingFilter(double rating) {
    selectedRating.value = rating;
  }

  void clearFilters() {
    searchQuery.value = '';
    selectedCategory.value = '';
    selectedRating.value = 0.0;
  }

  // CRUD operations
  Future<void> addService(String name, String category, String imageUrl,
      double price, double rating, String duration, bool availability) async {
    try {
      final newService = await apiService.createService(
          name, category, imageUrl, price, rating, duration, availability);
      services.add(newService);
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Error adding service: $e';
    }
  }

  Future<void> editService(
      String id,
      String name,
      String category,
      String imageUrl,
      double price,
      double rating,
      String duration,
      bool availability) async {
    try {
      final updatedService = await apiService.updateService(
          id, name, category, imageUrl, price, rating, duration, availability);
      final index = services.indexWhere((service) => service.id == id);
      if (index != -1) {
        services[index] = updatedService;
      }
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Error editing service: $e';
    }
  }

  Future<void> deleteService(String id) async {
    try {
      await apiService.deleteService(id);
      services.removeWhere((service) => service.id == id);
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Error deleting service: $e';
    }
  }

  ServiceModel? getServiceById(String id) {
    return services.firstWhereOrNull((service) => service.id == id);
  }
}
