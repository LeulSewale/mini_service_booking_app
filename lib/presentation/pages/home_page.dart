import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/service_controller.dart';
import '../../routes/app_routes.dart';
import '../widgets/service_card.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<ServiceController>();

  final List<String> categories = ['All', 'Plumbing', 'Cleaning', 'Electrical'];
  final List<double> ratingOptions = [0.0, 3.0, 4.0, 4.5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Service Booking App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Get.offAllNamed(AppRoutes.login); // simulate logout
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.toNamed(AppRoutes.addService);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text('Error: ${controller.errorMessage}'));
              }

              final services = controller.filteredServices;

              if (services.isEmpty) {
                return const Center(child: Text('No services found.'));
              }

              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ServiceCard(service: services[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          // Search field
          TextField(
            onChanged: controller.setSearchQuery,
            decoration: const InputDecoration(
              labelText: 'Search service name...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          // Category & Rating dropdowns
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  return DropdownButtonFormField<String>(
                    value: controller.selectedCategory.value.isEmpty
                        ? 'All'
                        : controller.selectedCategory.value,
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller
                          .setCategoryFilter(value == 'All' ? '' : value!);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                  );
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() {
                  return DropdownButtonFormField<double>(
                    value: controller.selectedRating.value,
                    items: ratingOptions.map((rating) {
                      return DropdownMenuItem(
                        value: rating,
                        child: Text(
                            rating == 0.0 ? 'All Ratings' : '$rating+ Stars'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.setRatingFilter(value);
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Rating',
                      border: OutlineInputBorder(),
                    ),
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Clear filters
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: controller.clearFilters,
              icon: const Icon(Icons.clear),
              label: const Text('Clear Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
