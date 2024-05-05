
class LampeModel {
  String id;
  String address;
  String latitude;
  String longitude;
  int status;

  LampeModel({required this.id,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.status
  });

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "status": status
      };

  static LampeModel fromJson(Map<String, dynamic> json) {
    return LampeModel(id: json["id"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        status: json["status"]);
  }
}
