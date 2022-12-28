// ignore_for_file: prefer_if_null_operators

class SendMessageModel {
    SendMessageModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory SendMessageModel.fromJson(Map<String, dynamic> json) => SendMessageModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
    };
}

class Data {
    Data({
        this.siswaId,
        this.siswaSenderId,
        this.siswaReceiverId,
        this.komentar,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String? siswaId;
    String? siswaSenderId;
    String? siswaReceiverId;
    String? komentar;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        siswaId: json["siswa_id"] == null ? null : json["siswa_id"],
        siswaSenderId: json["siswa_sender_id"] == null ? null : json["siswa_sender_id"],
        siswaReceiverId: json["siswa_receiver_id"] == null ? null : json["siswa_receiver_id"],
        komentar: json["komentar"] == null ? null : json["komentar"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "siswa_id": siswaId == null ? null : siswaId,
        "siswa_sender_id": siswaSenderId == null ? null : siswaSenderId,
        "siswa_receiver_id": siswaReceiverId == null ? null : siswaReceiverId,
        "komentar": komentar == null ? null : komentar,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
    };
}