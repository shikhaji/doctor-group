import 'dart:convert';

GetWalletModel getWalletModelFromJson(String str) =>
    GetWalletModel.fromJson(json.decode(str));

String getWalletModelToJson(GetWalletModel data) => json.encode(data.toJson());

class GetWalletModel {
  GetWalletModel({
    required this.status,
    required this.balance,
  });

  int status;
  String balance;

  factory GetWalletModel.fromJson(Map<String, dynamic> json) => GetWalletModel(
        status: json["status"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "balance": balance,
      };
}
