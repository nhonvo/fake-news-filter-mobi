class LanguageModel {
/*
{
  "id": "en",
  "name": "English",
  "flag": "en.png",
  "isDefault": false
}
*/

  String? id;
  String? name;
  String? flag;
  bool? isDefault;

  LanguageModel({
    this.id,
    this.name,
    this.flag,
    this.isDefault,
  });
  LanguageModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    flag = json['flag']?.toString();
    isDefault = json['isDefault'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['flag'] = flag;
    data['isDefault'] = isDefault;
    return data;
  }
}
