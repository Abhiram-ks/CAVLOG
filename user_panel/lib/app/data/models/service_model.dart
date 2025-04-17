class BarberServiceModel {
  final String barberId;
  final String serviceName;
  final double amount;

  BarberServiceModel({
    required this.barberId,
    required this.serviceName,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'barberId': barberId,
      'serviceName': serviceName,
      'amount': amount,
    };
  }

  factory BarberServiceModel.fromMap({
    required String barberID,
    required String key,
    required dynamic value,
  }) {
    return BarberServiceModel(
      barberId: barberID,
      serviceName: key,
      amount: (value as num).toDouble(),
    );
  }
}