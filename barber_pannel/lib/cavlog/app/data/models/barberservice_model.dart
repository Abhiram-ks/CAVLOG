class BarberServiceModel {
  final String serviceName;
  final double amount;

  BarberServiceModel({
    required this.serviceName,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'serviceName': serviceName,
      'amount': amount,
    };
  }

  factory BarberServiceModel.fromMap(String key, dynamic value) {
    return BarberServiceModel(
      serviceName: key,
      amount: (value as num).toDouble(),
    );
  }
}
