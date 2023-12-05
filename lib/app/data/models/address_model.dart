class AddressModel {
  int id;
  String country;
  String state;
  String city;
  String postalCode;
  String mainAddress;
  String? streetAddress1;
  String? streetAddress2;
  String description;

  AddressModel({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.postalCode,
    required this.mainAddress,
    this.streetAddress1,
    this.streetAddress2,
    required this.description,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      postalCode: json['postal_code'],
      mainAddress: json['main_address'],
      streetAddress1: json['street_address1'],
      streetAddress2: json['street_address2'],
      description: json['description'],
    );
  }
}
