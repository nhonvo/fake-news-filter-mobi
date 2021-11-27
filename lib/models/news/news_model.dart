class NewsModel {
/*
{
  "newsId": 1,
  "name": "Kabul’s Sudden Fall to Taliban Ends U.S. Era in Afghanistan",
  "description": "Follow live as the Taliban seizes territory across Afghanistan in the wake of the U.S. withdrawal.",
  "officialRating": null,
  "publisher": null,
  "content": "Test",
  "thumbNews": null,
  "status": 1,
  "timestamp": "2021-11-18T20:40:15.046708",
  "languageId": "en",
  "topicInfo": null
}
*/

  int? newsId;
  String? name;
  String? description;
  String? officialRating;
  String? publisher;
  String? content;
  String? thumbNews;
  int? status;
  String? timestamp;
  String? languageId;
  String? topicInfo;

  NewsModel({
    this.newsId,
    this.name,
    this.description,
    this.officialRating,
    this.publisher,
    this.content,
    this.thumbNews,
    this.status,
    this.timestamp,
    this.languageId,
    this.topicInfo,
  });
  NewsModel.fromJson(Map<String, dynamic> json) {
    newsId = json['newsId']?.toInt();
    name = json['name']?.toString();
    description = json['description']?.toString();
    officialRating = json['officialRating']?.toString();
    publisher = json['publisher']?.toString();
    content = json['content']?.toString();
    thumbNews = json['thumbNews']?.toString();
    status = json['status']?.toInt();
    timestamp = json['timestamp']?.toString();
    languageId = json['languageId']?.toString();
    topicInfo = json['topicInfo']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['newsId'] = newsId;
    data['name'] = name;
    data['description'] = description;
    data['officialRating'] = officialRating;
    data['publisher'] = publisher;
    data['content'] = content;
    data['thumbNews'] = thumbNews;
    data['status'] = status;
    data['timestamp'] = timestamp;
    data['languageId'] = languageId;
    data['topicInfo'] = topicInfo;
    return data;
  }
}
