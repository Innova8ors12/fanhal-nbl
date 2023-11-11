class PdfToImg {
  String? fileName;
  String? fileExt;
  int? fileSize;
  String? fileId;
  String? url;

  PdfToImg({this.fileName, this.fileExt, this.fileSize, this.fileId, this.url});

  PdfToImg.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
    fileExt = json['FileExt'];
    fileSize = json['FileSize'];
    fileId = json['FileId'];
    url = json['Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.fileName;
    data['FileExt'] = this.fileExt;
    data['FileSize'] = this.fileSize;
    data['FileId'] = this.fileId;
    data['Url'] = this.url;
    return data;
  }
}