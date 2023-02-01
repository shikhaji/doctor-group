class StateModel {
  StateModel({
    this.stateId,
    this.stateName,
    this.countryId,
  });

  String? stateId;
  String? stateName;
  String? countryId;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        stateId: json["STATE_ID"],
        stateName: json["STATE_NAME"],
        countryId: json["COUNTRY_ID"],
      );

  Map<String, dynamic> toJson() => {
        "STATE_ID": stateId,
        "STATE_NAME": stateName,
        "COUNTRY_ID": countryId,
      };
}
