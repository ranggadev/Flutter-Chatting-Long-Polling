// ignore_for_file: prefer_if_null_operators

class ChattingModel {
    ChattingModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    List<Datum>? data;

    factory ChattingModel.fromJson(Map<String, dynamic> json) => ChattingModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.siswaId,
        this.siswaSenderId,
        this.siswaReceiverId,
        this.komentar,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.siswa,
    });

    int? id;
    int? siswaId;
    int? siswaSenderId;
    int? siswaReceiverId;
    String? komentar;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    Siswa? siswa;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        siswaId: json["siswa_id"] == null ? null : json["siswa_id"],
        siswaSenderId: json["siswa_sender_id"] == null ? null : json["siswa_sender_id"],
        siswaReceiverId: json["siswa_receiver_id"] == null ? null : json["siswa_receiver_id"],
        komentar: json["komentar"] == null ? null : json["komentar"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        siswa: json["siswa"] == null ? null : Siswa.fromJson(json["siswa"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "siswa_id": siswaId == null ? null : siswaId,
        "siswa_sender_id": siswaSenderId == null ? null : siswaSenderId,
        "siswa_receiver_id": siswaReceiverId == null ? null : siswaReceiverId,
        "komentar": komentar == null ? null : komentar,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "siswa": siswa == null ? null : siswa!.toJson(),
    };
}

class Siswa {
    Siswa({
        this.id,
        this.nama,
        this.nis,
        this.password,
        this.nisn,
        this.jenisKelamin,
        this.tempatLahir,
        this.tanggalLahir,
        this.alamat,
        this.noKk,
        this.nik,
        this.foto,
        this.noHp,
        this.nonaktif,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    int? id;
    String? nama;
    String? nis;
    String? password;
    String? nisn;
    String? jenisKelamin;
    String? tempatLahir;
    DateTime? tanggalLahir;
    String? alamat;
    String? noKk;
    String? nik;
    String? foto;
    String? noHp;
    int? nonaktif;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
        id: json["id"] == null ? null : json["id"],
        nama: json["nama"] == null ? null : json["nama"],
        nis: json["nis"] == null ? null : json["nis"],
        password: json["password"] == null ? null : json["password"],
        nisn: json["nisn"] == null ? null : json["nisn"],
        jenisKelamin: json["jenis_kelamin"] == null ? null : json["jenis_kelamin"],
        tempatLahir: json["tempat_lahir"] == null ? null : json["tempat_lahir"],
        tanggalLahir: json["tanggal_lahir"] == null ? null : DateTime.parse(json["tanggal_lahir"]),
        alamat: json["alamat"] == null ? null : json["alamat"],
        noKk: json["no_kk"] == null ? null : json["no_kk"],
        nik: json["nik"] == null ? null : json["nik"],
        foto: json["foto"] == null ? null : json["foto"],
        noHp: json["no_hp"] == null ? null : json["no_hp"],
        nonaktif: json["nonaktif"] == null ? null : json["nonaktif"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama": nama == null ? null : nama,
        "nis": nis == null ? null : nis,
        "password": password == null ? null : password,
        "nisn": nisn == null ? null : nisn,
        "jenis_kelamin": jenisKelamin == null ? null : jenisKelamin,
        "tempat_lahir": tempatLahir == null ? null : tempatLahir,
        "tanggal_lahir": tanggalLahir == null ? null : "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
        "alamat": alamat == null ? null : alamat,
        "no_kk": noKk == null ? null : noKk,
        "nik": nik == null ? null : nik,
        "foto": foto == null ? null : foto,
        "no_hp": noHp == null ? null : noHp,
        "nonaktif": nonaktif == null ? null : nonaktif,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
    };
}