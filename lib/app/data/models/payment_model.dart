class CreditCardModel {
  int id;
  String user;
  String cc;
  int month;
  int year;
  String cvv;

  CreditCardModel({
    required this.id,
    required this.user,
    required this.cc,
    required this.month,
    required this.year,
    required this.cvv,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) {
    return CreditCardModel(
      id: json['id'],
      user: json['user'],
      cc: json['cc'],
      month: json['month'],
      year: json['year'],
      cvv: json['cvv'],
    );
  }
}
