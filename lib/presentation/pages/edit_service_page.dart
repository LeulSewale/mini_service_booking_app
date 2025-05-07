import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/service_model.dart';
import '../controllers/service_controller.dart';

class EditServicePage extends StatefulWidget {
  @override
  _EditServicePageState createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<ServiceController>();

  late ServiceModel service;

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final imageUrlController = TextEditingController();
  final durationController = TextEditingController();
  final ratingController = TextEditingController();
  bool availability = true;

  @override
  void initState() {
    super.initState();
    final String serviceId = Get.arguments;
    service = _controller.getServiceById(serviceId)!;

    nameController.text = service.name;
    categoryController.text = service.category;
    priceController.text = service.price.toString();
    imageUrlController.text = service.imageUrl;
    durationController.text = service.duration.toString();
    ratingController.text = service.rating.toString();
    availability = service.availability;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final updatedService = service.copyWith(
        name: nameController.text,
        category: categoryController.text,
        price: double.parse(priceController.text),
        imageUrl: imageUrlController.text,
        availability: availability,
        duration: int.parse(durationController.text),
        rating: double.parse(ratingController.text),
      );

      _controller.updateService(service.id, updatedService).then((_) {
        Get.back(); // return to detail or home page
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Service')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField(nameController, 'Name'),
                _buildTextField(categoryController, 'Category'),
                _buildTextField(priceController, 'Price', isNumber: true),
                _buildTextField(imageUrlController, 'Image URL'),
                _buildTextField(durationController, 'Duration (min)', isNumber: true),
                _buildTextField(ratingController, 'Rating (0.0 - 5.0)', isNumber: true),
                SwitchListTile(
                  value: availability,
                  title: const Text('Available'),
                  onChanged: (val) => setState(() => availability = val),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _controller.isLoading.value ? null : _submit,
                  child: _controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Update Service'),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label is required';
          }
          if (isNumber && double.tryParse(value) == null) {
            return '$label must be a number';
          }
          return null;
        },
      ),
    );
  }
}
