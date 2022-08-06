///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class VersionModel {
/*
{
  "versionId": 9,
  "versionNumber": "1.5.0",
  "content": "Bản beta",
  "platform": 0,
  "createTime": "2022-08-06T07:57:26.623841",
  "releaseTime": "2023-12-08T00:00:00",
  "isRequired": true,
  "status": 0
} 
*/

  int? versionId;
  String? versionNumber;
  String? content;
  int? platform;
  String? createTime;
  String? releaseTime;
  bool? isRequired;
  int? status;

  VersionModel({
    this.versionId,
    this.versionNumber,
    this.content,
    this.platform,
    this.createTime,
    this.releaseTime,
    this.isRequired,
    this.status,
  });
  VersionModel.fromJson(Map<String, dynamic> json) {
    versionId = json['versionId']?.toInt();
    versionNumber = json['versionNumber']?.toString();
    content = json['content']?.toString();
    platform = json['platform']?.toInt();
    createTime = json['createTime']?.toString();
    releaseTime = json['releaseTime']?.toString();
    isRequired = json['isRequired'];
    status = json['status']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['versionId'] = versionId;
    data['versionNumber'] = versionNumber;
    data['content'] = content;
    data['platform'] = platform;
    data['createTime'] = createTime;
    data['releaseTime'] = releaseTime;
    data['isRequired'] = isRequired;
    data['status'] = status;
    return data;
  }
}
