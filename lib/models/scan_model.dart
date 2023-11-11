class ScanCertificate {
  int? id;
  String? serialNo;
  int? userId;
  int? certificateId;
  String? img;
  String? pdf;
  String? type;
  String? status;
  String? chargeId;
  String? name;
  String? address;
  String? phone;
  String? qty;
  String? nflCertificateId;
  String? qrCode;
  String? createdAt;
  String? updatedAt;

  ScanCertificate(
      {this.id,
      this.serialNo,
      this.userId,
      this.certificateId,
      this.img,
      this.pdf,
      this.type,
      this.status,
      this.chargeId,
      this.name,
      this.address,
      this.phone,
      this.qty,
      this.nflCertificateId,
      this.qrCode,
      this.createdAt,
      this.updatedAt});

  ScanCertificate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNo = json['serial_no'];
    userId = json['user_id'];
    certificateId = json['certificate_id'];
    img = json['img'];
    pdf = json['pdf'];
    type = json['type'];
    status = json['status'];
    chargeId = json['charge_id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    qty = json['qty'];
    nflCertificateId = json['nfl_certificate_id'];
    qrCode = json['qr_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_no'] = this.serialNo;
    data['user_id'] = this.userId;
    data['certificate_id'] = this.certificateId;
    data['img'] = this.img;
    data['pdf'] = this.pdf;
    data['type'] = this.type;
    data['status'] = this.status;
    data['charge_id'] = this.chargeId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['qty'] = this.qty;
    data['nfl_certificate_id'] = this.nflCertificateId;
    data['qr_code'] = this.qrCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}