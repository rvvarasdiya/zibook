import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/utils/string_utils.dart';

class LogInResponseModel extends BaseApiResp{

  Data data;

  LogInResponseModel({this.data});

  LogInResponseModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
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
  Token refreshToken;
  User user;

  Data({this.token, this.refreshToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    refreshToken = json['refreshToken'] != null
        ? new Token.fromJson(json['refreshToken'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.token != null) {
      data['token'] = this.token.toJson();
    }
    if (this.refreshToken != null) {
      data['refreshToken'] = this.refreshToken.toJson();
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
  int type;
  String firstName;
  String lastName;
  int gender;
  String dob;
  String image;
  String name;
  // List<Null> addresses;
  List<Emails> emails;
  List<Mobiles> mobiles;
  String createdAt;
  String loginToken;
  String refreshToken;

  User(
      {this.isConnected,
      this.sId,
      this.type,
      this.firstName,
      this.lastName,
      this.gender,
      this.dob,
      this.image,
      this.name,
      // this.addresses,
      this.emails,
      this.mobiles,
      this.createdAt,
      this.loginToken,
      this.refreshToken});

  User.fromJson(Map<String, dynamic> json) {
    isConnected = json['isConnected'];
    sId = json['_id'];
    if(!isNullEmptyOrFalse(json['type']))
      type = json['type'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    dob = json['dob'];
    image = json['image'];
    name = json['name'];
    // if (json['addresses'] != null) {
    //   addresses = new List<Null>();
    //   json['addresses'].forEach((v) {
    //     addresses.add(new Null.fromJson(v));
    //   });
    // }
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
    data['type'] = this.type;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['image'] = this.image;
    data['name'] = this.name;
    // if (this.addresses != null) {
    //   data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    // }
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