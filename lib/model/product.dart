class Products {
  String? id;
  String? name;
  String? desc;
  String? price;
  String? guest;
  String? address;
  String? state;
  String? local;

  Products(
      {this.id,
      this.name,
      this.desc,
      this.price,
      this.guest,
      this.address,
      this.state,
      this.local});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    guest = json['guest'];
    address = json['address'];
    state = json['state'];
    local = json['local'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['price'] = price;
    data['guest'] = guest;
    data['address'] = address;
    data['state'] = state;
    data['local'] = local;
    return data;
  }
}