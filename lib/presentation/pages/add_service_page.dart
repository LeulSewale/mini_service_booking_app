import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/service_controller.dart';

class AddServicePage extends StatelessWidget {
  final ServiceController controller = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();

  AddServicePage({Key? key}) : super(key: key);

  void _addService() {
    final name = nameController.text.trim();
    final category = categoryController.text.trim();
    final imageUrl = imageUrlController.text.trim();
    final price = double.tryParse(priceController.text.trim()) ?? 0.0;
    final rating = double.tryParse(ratingController.text.trim()) ?? 0.0;
    final duration = durationController.text.trim();
    final availability =
        availabilityController.text.trim().toLowerCase() == 'true';

    controller.addService(
        name, category, imageUrl, price, rating, duration, availability);
    Get.back(); // optional: go back after adding
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Service'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Service Name', nameController),
              _buildTextField('Category', categoryController),
              _buildTextField('Image URL', imageUrlController),
              _buildTextField('Price', priceController,
                  keyboardType: TextInputType.number),
              _buildTextField('Rating', ratingController,
                  keyboardType: TextInputType.number),
              _buildTextField('Duration', durationController),
              _buildTextField(
                  'Availability (true/false)', availabilityController),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _addService,
                icon: const Icon(Icons.add),
                label: const Text('Add Service'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
