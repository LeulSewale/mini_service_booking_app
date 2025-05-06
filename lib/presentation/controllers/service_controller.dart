import 'package:get/get.dart';
import '../../data/models/service_model.dart';
import '../../data/providers/service_provider.dart';

class ServiceController extends GetxController {
  final ServiceProvider _provider = ServiceProvider();

  var services = <ServiceModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllServices();
  }

  void fetchAllServices() async {
    try {
      isLoading.value = true;
      final data = await _provider.fetchServices();
      services.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
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
}
