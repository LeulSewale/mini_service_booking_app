// lib/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../controllers/service_controller.dart';
import '../widgets/service_card.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<ServiceController>();

  final List<String> categories = ['All', 'Plumbing', 'Cleaning', 'Electrical'];
  final List<double> ratingOptions = [0.0, 3.0, 4.0, 4.5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Mini Service Booking App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.offAllNamed(AppRoutes.login),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.toNamed(AppRoutes.addService),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFilters(),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      '⚠️ ${controller.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final services = controller.filteredServices;

                if (services.isEmpty) {
                  return const Center(
                    child: Text(
                      'No services found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return ServiceCard(service: services[index]);
                  },
                  separatorBuilder: (context, _) => const SizedBox(height: 12),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        TextField(
          onChanged: controller.setSearchQuery,
          decoration: InputDecoration(
            hintText: 'Search services...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 12),

        // Category and Rating Dropdown Filters
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
                    controller.setCategoryFilter(value == 'All' ? '' : value!);
                  },
                  decoration: InputDecoration(
                    labelText: 'Category',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                        rating == 0.0 ? 'All Ratings' : '$rating+ Stars',
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) controller.setRatingFilter(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Rating',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              }),
            ),
          ],
        ),

        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: controller.clearFilters,
            icon: const Icon(Icons.clear),
            label: const Text('Clear Filters'),
          ),
        ),
      ],
    );
  }
}
