class ServiceModel {
  final String id;
  final String name;

  ServiceModel({required this.id, required this.name});
  
  factory ServiceModel.fromMap(String documentId, Map<String, dynamic> data) {
    return ServiceModel(
      id: documentId, 
      name: data['name'] ?? '');
  }
}