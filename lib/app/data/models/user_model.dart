class UserModel {
  int id;
  bool status;
  String? phone;
  String? company;
  String firstName;
  String roleId;
  String userId;
  DateTime registerDate;
  String lastName;

  UserModel({
    required this.id,
    required this.status,
    this.phone,
    this.company,
    required this.firstName,
    required this.roleId,
    required this.userId,
    required this.registerDate,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      status: json['status'],
      phone: json['phone'],
      company: json['company'],
      firstName: json['first_name'],
      roleId: json['role_id'],
      userId: json['user_id'],
      registerDate: DateTime.parse(json['register_date']),
      lastName: json['last_name'],
    );
  }
}
