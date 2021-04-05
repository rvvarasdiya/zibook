class UpdateBusinessReq {
  String name;
  String countryCode;
  String mobile;
  String state;
  String city;
  String address;
  String postalCode;
  String category;

  UpdateBusinessReq(
      {this.name,
      this.countryCode,
      this.mobile,
      this.state,
      this.city,
      this.address,
      this.postalCode,
      this.category});

  UpdateBusinessReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    postalCode = json['postalCode'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['countryCode'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address'] = this.address;
    data['postalCode'] = this.postalCode;
    data['category'] = this.category;
    return data;
  }
}
