// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/service_controller.dart';
// import '../../routes/app_routes.dart';
// import '../../data/models/service_model.dart';

// class ServiceDetailPage extends StatelessWidget {
//   final controller = Get.find<ServiceController>();

//   @override
//   Widget build(BuildContext context) {
//     final String serviceId = Get.arguments;
//     final ServiceModel? service = controller.getServiceById(serviceId);

//     if (service == null) {
//       return Scaffold(
//         appBar: AppBar(title: const Text('Service Detail')),
//         body: const Center(child: Text('Service not found')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(service.name),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               Get.toNamed(AppRoutes.editService, arguments: service.id);
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () => _confirmDelete(context, service.id),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             Image.network(service.imageUrl, height: 200, fit: BoxFit.cover),
//             const SizedBox(height: 16),
//             Text(service.name, style: Theme.of(context).textTheme.headlineSmall),
//             const SizedBox(height: 8),
//             Text('Category: ${service.category}'),
//             Text('Price: \$${service.price}'),
//             Text('Duration: ${service.duration} min'),
//             Text('Rating: ${service.rating} ⭐'),
//             Text('Available: ${service.availability ? "Yes" : "No"}'),
//           ],
//         ),
//       ),
//     );
//   }

//   void _confirmDelete(BuildContext context, String id) {
//     Get.defaultDialog(
//       title: 'Delete Service',
//       middleText: 'Are you sure you want to delete this service?',
//       textCancel: 'Cancel',
//       textConfirm: 'Delete',
//       confirmTextColor: Colors.white,
//       onConfirm: () async {
//         await controller.deleteService(id);
//         Get.back(); // close dialog
//         Get.back(); // go back to HomePage
//       },
//     );
//   }
// }
