import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/models/Auth/LogInResponseModel.dart';

class MasterResp extends BaseApiResp {
  Data data;

  MasterResp({this.data});

  MasterResp.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
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
  String lastSyncDate;
  User loggedInUser;

  List<Categories> categories;
  List<States> states;

  Data({
    this.lastSyncDate,
    this.loggedInUser,
    this.categories,
    this.states,
  });

  Data.fromJson(Map<String, dynamic> json) {
    lastSyncDate = json['lastSyncDate'];
    loggedInUser = json['loggedInUser'] != null
        ? new User.fromJson(json['loggedInUser'])
        : null;

    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['states'] != null) {
      states = new List<States>();
      json['states'].forEach((v) {
        states.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastSyncDate'] = this.lastSyncDate;
    if (this.loggedInUser != null) {
      data['loggedInUser'] = this.loggedInUser.toJson();
    }

    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.states != null) {
      data['states'] = this.states.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class User {
//   bool isConnected;
//   String sId;
//   String firstName;
//   String lastName;
//   String image;
//   String name;
//   int type;
//   List<Addresses> addresses;
//   List<Emails> emails;
//   List<Mobiles> mobiles;
//   String createdAt;
//   String loginToken;
//   String refreshToken;

//   User(
//       {this.isConnected,
//       this.sId,
//       this.firstName,
//       this.lastName,
//       this.image,
//       this.name,
//       this.type,
//       this.addresses,
//       this.emails,
//       this.mobiles,
//       this.createdAt,
//       this.loginToken,
//       this.refreshToken});

//   User.fromJson(Map<String, dynamic> json) {
//     isConnected = json['isConnected'];
//     sId = json['_id'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     image = json['image'];
//     name = json['name'];
//     type = json['type'];
//     if (json['addresses'] != null) {
//       addresses = new List<Addresses>();
//       json['addresses'].forEach((v) {
//         addresses.add(new Addresses.fromJson(v));
//       });
//     }
//     if (json['emails'] != null) {
//       emails = new List<Emails>();
//       json['emails'].forEach((v) {
//         emails.add(new Emails.fromJson(v));
//       });
//     }
//     if (json['mobiles'] != null) {
//       mobiles = new List<Mobiles>();
//       json['mobiles'].forEach((v) {
//         mobiles.add(new Mobiles.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     loginToken = json['loginToken'];
//     refreshToken = json['refreshToken'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isConnected'] = this.isConnected;
//     data['_id'] = this.sId;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['image'] = this.image;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     if (this.addresses != null) {
//       data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
//     }
//     if (this.emails != null) {
//       data['emails'] = this.emails.map((v) => v.toJson()).toList();
//     }
//     if (this.mobiles != null) {
//       data['mobiles'] = this.mobiles.map((v) => v.toJson()).toList();
//     }
//     data['createdAt'] = this.createdAt;
//     data['loginToken'] = this.loginToken;
//     data['refreshToken'] = this.refreshToken;
//     return data;
//   }
// }

class Addresses {
  String sId;
  City city;
  String state;
  String country;

  Addresses({this.sId, this.city, this.state, this.country});

  Addresses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class City {
  String sId;
  String name;

  City({this.sId, this.name});

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
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

class Categories {
  bool isActive;
  bool isDeleted;
  String sId;
  String name;
  String description;
  String addedBy;
  String code;
  String createdAt;
  String updatedAt;
  int iV;

  Categories(
      {this.isActive,
      this.isDeleted,
      this.sId,
      this.name,
      this.description,
      this.addedBy,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Categories.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    addedBy = json['addedBy'];
    code = json['code'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['addedBy'] = this.addedBy;
    data['code'] = this.code;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class States {
  bool isDeleted;
  bool isActive;
  String sId;
  String createdAt;
  String updatedAt;
  String name;
  String normalizeName;
  String sTDCode;
  String stateCode;
  String stateType;
  String remark;
  String countryId;
  int iV;

  States(
      {this.isDeleted,
      this.isActive,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.normalizeName,
      this.sTDCode,
      this.stateCode,
      this.stateType,
      this.remark,
      this.countryId,
      this.iV});

  States.fromJson(Map<String, dynamic> json) {
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    normalizeName = json['normalizeName'];
    sTDCode = json['STDCode'];
    stateCode = json['stateCode'];
    stateType = json['stateType'];
    remark = json['Remark'];
    countryId = json['countryId'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['name'] = this.name;
    data['normalizeName'] = this.normalizeName;
    data['STDCode'] = this.sTDCode;
    data['stateCode'] = this.stateCode;
    data['stateType'] = this.stateType;
    data['Remark'] = this.remark;
    data['countryId'] = this.countryId;
    data['__v'] = this.iV;
    return data;
  }
}
