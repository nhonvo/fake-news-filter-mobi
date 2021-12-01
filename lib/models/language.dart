class LanguageModel {
/*
{
  "id": "en",
  "name": "English",
  "isDefault": false
}
*/

  String? id;
  String? name;
  bool? isDefault;

  LanguageModel({
    this.id,
    this.name,
    this.isDefault,
  });
  LanguageModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    isDefault = json['isDefault'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isDefault'] = isDefault;
    return data;
  }
}
