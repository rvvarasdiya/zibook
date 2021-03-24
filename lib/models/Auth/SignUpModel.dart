class SignUpModel {
  String firstName;
  String lastName;
  String email;
  String countryCode;
  String mobile;
  String state;
  String city;
  String password;

  SignUpModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.countryCode,
      this.mobile,
      this.state,
      this.city,
      this.password});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    state = json['state'];
    city = json['city'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['countryCode'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['state'] = this.state;
    data['city'] = this.city;
    data['password'] = this.password;
    return data;
  }
}