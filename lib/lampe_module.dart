
class Lampe {
  String id;
  String address;
  String latitude;
  String longitude;
  String status;

  Lampe({required this.id,
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

  static Lampe fromJson(Map<String, dynamic> json) {
    return Lampe(id: json["id"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        status: json["status"]);
  }
}
