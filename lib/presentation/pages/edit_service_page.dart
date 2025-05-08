import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/service_controller.dart';

class EditServicePage extends StatefulWidget {
  final String serviceId;

  const EditServicePage({Key? key, required this.serviceId}) : super(key: key);

  @override
  _EditServicePageState createState() => _EditServicePageState();
}

class _EditServicePageState extends State<EditServicePage> {
  final ServiceController controller = Get.find<ServiceController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final service = controller.getServiceById(widget.serviceId);
    if (service != null) {
      nameController.text = service.name;
      categoryController.text = service.category;
      imageUrlController.text = service.imageUrl;
      priceController.text = service.price.toString();
      ratingController.text = service.rating.toString();
      durationController.text = service.duration;
      availabilityController.text = service.availability.toString();
    } else {
      // Handle case where service is null (for example, show an error message)
      print('Service not found or null response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Service')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Service Name'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: ratingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Rating'),
              ),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(labelText: 'Duration'),
              ),
              TextField(
                controller: availabilityController,
                decoration: const InputDecoration(labelText: 'Availability'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.editService(
                    widget.serviceId,
                    nameController.text,
                    categoryController.text,
                    imageUrlController.text,
                    double.parse(priceController.text),
                    double.parse(ratingController.text),
                    durationController.text,
                    availabilityController.text.toLowerCase() == 'true',
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
