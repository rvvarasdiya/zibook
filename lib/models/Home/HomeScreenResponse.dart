import 'package:zaviato/app/base/BaseApiResp.dart';

class HomeScreenResponse extends BaseApiResp{

  Data data;

  HomeScreenResponse({this.data});

  HomeScreenResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
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
  List<ListData> list;
  int count;

  Data({this.list, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<ListData>();
      json['list'].forEach((v) {
        list.add(new ListData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class ListData {
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

  ListData(
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

  ListData.fromJson(Map<String, dynamic> json) {
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
