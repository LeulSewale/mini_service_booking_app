import 'package:get/get.dart';
import '../../data/models/service_model.dart';
import '../../data/providers/service_provider.dart';
import 'package:hive/hive.dart';

class ServiceController extends GetxController {
  final ServiceProvider _provider = ServiceProvider();

  var services = <ServiceModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var searchQuery = ''.obs;
  var selectedCategory = ''.obs;
  var selectedRating = 0.0.obs;
  @override
  @override
void onInit() {
  super.onInit();
  loadCachedServices();  // Try to show offline data first
  fetchAllServices();    // Then try to update from network
}


void fetchAllServices() async {
  try {
    isLoading.value = true;
    errorMessage.value = '';
    final data = await _provider.fetchServices();
    services.assignAll(data);
    saveServicesToCache(data); // ✅ Cache the result
  } catch (e) {
    errorMessage.value = 'Could not fetch from network. Showing cached data.';
    loadCachedServices(); // ✅ fallback
  } finally {
    isLoading.value = false;
  }
}
  

  Future<void> addService(ServiceModel service) async {
    try {
      isLoading.value = true;
      final newService = await _provider.addService(service);
      services.add(newService);
      Get.snackbar('Success', 'Service added');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteService(String id) async {
    try {
      isLoading.value = true;
      await _provider.deleteService(id);
      services.removeWhere((s) => s.id == id);
      Get.snackbar('Success', 'Service deleted');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateService(String id, ServiceModel updated) async {
    try {
      isLoading.value = true;
      final result = await _provider.updateService(id, updated);
      final index = services.indexWhere((s) => s.id == id);
      if (index != -1) {
        services[index] = result;
      }
      Get.snackbar('Success', 'Service updated');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ServiceModel? getServiceById(String id) {
    return services.firstWhereOrNull((s) => s.id == id);
  }

  List<ServiceModel> get filteredServices {
    return services.where((service) {
      final matchesSearch =
          service.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesCategory = selectedCategory.value.isEmpty ||
          service.category == selectedCategory.value;
      final matchesRating =
          selectedRating.value == 0.0 || service.rating >= selectedRating.value;
      return matchesSearch && matchesCategory && matchesRating;
    }).toList();
  }

  void saveServicesToCache(List<ServiceModel> services) async {
    final box = Hive.box('servicesBox');
    final encoded = services.map((e) => e.toJson()).toList();
    await box.put('cachedServices', encoded);
  }

  void loadCachedServices() {
    final box = Hive.box('servicesBox');
    final cached = box.get('cachedServices');
    if (cached != null) {
      final List<ServiceModel> cachedServices = (cached as List)
          .map((json) => ServiceModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
      services.assignAll(cachedServices);
    }
  }

  void setSearchQuery(String query) => searchQuery.value = query;
  void setCategoryFilter(String category) => selectedCategory.value = category;
  void setRatingFilter(double rating) => selectedRating.value = rating;

  void clearFilters() {
    searchQuery.value = '';
    selectedCategory.value = '';
    selectedRating.value = 0.0;
  }
}
