class User {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? address;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      required this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}