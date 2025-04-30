class AdminServiceModel {
  final String id;
  final String name;

  AdminServiceModel({required this.id, required this.name});
  
  factory AdminServiceModel.fromMap(String documentId, Map<String, dynamic> data) {
    return AdminServiceModel(
      id: documentId, 
      name: data['name'] ?? '');
  }
}