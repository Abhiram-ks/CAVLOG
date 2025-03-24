class ServiceModels {
  final String serviceId;
  final String serviceName;

  ServiceModels({
    required this.serviceId,
    required this.serviceName,
  });

  factory ServiceModels.fromFirestore(Map<String, dynamic> data) {
    return ServiceModels(
      serviceId: data['id'] ?? '',  
      serviceName: data['name'] ?? '',
    );
  }
}