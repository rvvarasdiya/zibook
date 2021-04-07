
import 'package:zaviato/app/base/BaseApiResp.dart';

class FaqsResp extends BaseApiResp {
  
  Data data;

  FaqsResp({ this.data});

  FaqsResp.fromJson(Map<String, dynamic> json) : super.fromJson(json)  {
   
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Faqs> list;
  int count;

  Data({this.list, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<Faqs>();
      json['list'].forEach((v) {
        list.add(new Faqs.fromJson(v));
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

class Faqs {
  bool isActive;
  bool isDeleted;
  bool isShowMoreLess=false;
  String sId;
  String question;
  String answer;
  int sequence;
  String createdAt;
  String updatedAt;
  int iV;

  Faqs(
      {this.isActive,
      this.isDeleted,
      this.isShowMoreLess=false,
      this.sId,
      this.question,
      this.answer,
      this.sequence,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Faqs.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    question = json['question'];
    answer = json['answer'];
    sequence = json['sequence'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['sequence'] = this.sequence;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
