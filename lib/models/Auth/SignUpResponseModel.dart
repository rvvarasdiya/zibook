import 'package:zaviato/app/base/BaseApiResp.dart';

class SignUpResponseModel extends BaseApiResp{  
  Data data;

  SignUpResponseModel({ this.data});

  SignUpResponseModel.fromJson(Map<String, dynamic> json)  : super.fromJson(json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Token token;
  User user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.token != null) {
      data['token'] = this.token.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Token {
  String jwt;

  Token({this.jwt});

  Token.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    return data;
  }
}

class User {
  bool isConnected;
  String sId;
  String firstName;
  String lastName;
  String image;
  String name;
  int type;
  List<Addresses> addresses;
  List<Emails> emails;
  List<Mobiles> mobiles;
  String createdAt;
  String loginToken;
  String refreshToken;

  User(
      {this.isConnected,
      this.sId,
      this.firstName,
      this.lastName,
      this.image,
      this.name,
      this.type,
      this.addresses,
      this.emails,
      this.mobiles,
      this.createdAt,
      this.loginToken,
      this.refreshToken});

  User.fromJson(Map<String, dynamic> json) {
    isConnected = json['isConnected'];
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
    name = json['name'];
    type = json['type'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    if (json['emails'] != null) {
      emails = new List<Emails>();
      json['emails'].forEach((v) {
        emails.add(new Emails.fromJson(v));
      });
    }
    if (json['mobiles'] != null) {
      mobiles = new List<Mobiles>();
      json['mobiles'].forEach((v) {
        mobiles.add(new Mobiles.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    loginToken = json['loginToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isConnected'] = this.isConnected;
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['image'] = this.image;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    if (this.emails != null) {
      data['emails'] = this.emails.map((v) => v.toJson()).toList();
    }
    if (this.mobiles != null) {
      data['mobiles'] = this.mobiles.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['loginToken'] = this.loginToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}

class Addresses {
  String sId;
  String city;
  String state;
  String country;

  Addresses({this.sId, this.city, this.state, this.country});

  Addresses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class Emails {
  String sId;
  String email;
  bool isPrimary;
  bool isVerified;

  Emails({this.sId, this.email, this.isPrimary, this.isVerified});

  Emails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    isPrimary = json['isPrimary'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['isPrimary'] = this.isPrimary;
    data['isVerified'] = this.isVerified;
    return data;
  }
}

class Mobiles {
  String sId;
  String countryCode;
  String mobile;
  bool isPrimary;
  bool isVerified;

  Mobiles(
      {this.sId,
      this.countryCode,
      this.mobile,
      this.isPrimary,
      this.isVerified});

  Mobiles.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    isPrimary = json['isPrimary'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['countryCode'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['isPrimary'] = this.isPrimary;
    data['isVerified'] = this.isVerified;
    return data;
  }
}
