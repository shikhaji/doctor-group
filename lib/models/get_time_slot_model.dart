class GetTimeSlotModel {
  int? status;
  List<GetTimeSlotList>? data;

  GetTimeSlotModel({this.status, this.data});

  GetTimeSlotModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GetTimeSlotList>[];
      json['data'].forEach((v) {
        data!.add(new GetTimeSlotList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetTimeSlotList {
  String? dTSID;
  String? dTSTT;
  String? dTSTIME;
  bool selectTime = false;

  GetTimeSlotList(
      {this.dTSID, this.dTSTT, this.dTSTIME, required this.selectTime});

  GetTimeSlotList.fromJson(Map<String, dynamic> json) {
    dTSID = json['DTS_ID'];
    dTSTT = json['DTS_TT'];
    dTSTIME = json['DTS_TIME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['DTS_ID'] = this.dTSID;
    data['DTS_TT'] = this.dTSTT;
    data['DTS_TIME'] = this.dTSTIME;
    return data;
  }
}
