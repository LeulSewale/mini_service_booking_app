import 'package:flutter/material.dart';
import '../../data/models/service_model.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceCard({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(service.imageUrl),
        ),
        title: Text(service.name),
        subtitle: Text('${service.category} • \$${service.price.toStringAsFixed(2)}'),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Get.toNamed(AppRoutes.serviceDetail, arguments: service.id);
        },
      ),
    );
  }
}
