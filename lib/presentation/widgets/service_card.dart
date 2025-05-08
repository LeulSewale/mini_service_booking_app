import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/data/models/service_model.dart';
import '../controllers/service_controller.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final ServiceController controller = Get.find();

  ServiceCard({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(service.imageUrl),
        title: Text(service.name),
        subtitle: Text(service.category),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            controller.deleteService(service.id);
          },
        ),
      ),
    );
  }
}
