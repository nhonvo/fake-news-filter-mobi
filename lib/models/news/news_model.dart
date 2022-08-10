///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class NewsModelTopicInfo {
/*
{
  "topicId": 1,
  "topicName": "afghanistan"
}
*/

  int? topicId;
  String? topicName;

  NewsModelTopicInfo({
    this.topicId,
    this.topicName,
  });
  NewsModelTopicInfo.fromJson(Map<String, dynamic> json) {
    topicId = json['topicId']?.toInt();
    topicName = json['topicName']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['topicId'] = topicId;
    data['topicName'] = topicName;
    return data;
  }
}

class NewsModel {
/*
{
  "languageId": "en",
  "newsId": 1,
  "topicInfo": [
    {
      "topicId": 1,
      "topicName": "afghanistan"
    }
  ],
  "title": "Kabul’s Sudden Fall to Taliban Ends U.S. Era in Afghanistan",
  "urlNews": "https://www.independent.co.uk/arts-entertainment/eurovision/the-rasmus-eurovision-2022-finland-b2077365.html",
  "thumbNews": "https://travelweekly.co.uk/images/cmstw/original/4/e/6/4/4/easid-453165-media-id-34528.jpg",
  "socialBeliefs": 0,
  "officialRating": "real",
  "viewCount": 0,
  "publisher": "New York Times",
  "timestamp": "2022-08-08T15:03:50.165156",
  "status": 1,
  "sourceCreate": "GoogleApi"
}
*/

  String? languageId;
  int? newsId;
  List<NewsModelTopicInfo?>? topicInfo;
  String? title;
  String? urlNews;
  String? thumbNews;
  int? socialBeliefs;
  String? officialRating;
  int? viewCount;
  String? publisher;
  String? timestamp;
  int? status;
  String? sourceCreate;

  NewsModel({
    this.languageId,
    this.newsId,
    this.topicInfo,
    this.title,
    this.urlNews,
    this.thumbNews,
    this.socialBeliefs,
    this.officialRating,
    this.viewCount,
    this.publisher,
    this.timestamp,
    this.status,
    this.sourceCreate,
  });
  NewsModel.fromJson(Map<String, dynamic> json) {
    languageId = json['languageId']?.toString();
    newsId = json['newsId']?.toInt();
    if (json['topicInfo'] != null) {
      final v = json['topicInfo'];
      final arr0 = <NewsModelTopicInfo>[];
      v.forEach((v) {
        arr0.add(NewsModelTopicInfo.fromJson(v));
      });
      topicInfo = arr0;
    }
    title = json['title']?.toString();
    urlNews = json['urlNews']?.toString();
    thumbNews = json['thumbNews']?.toString();
    socialBeliefs = json['socialBeliefs']?.toInt();
    officialRating = json['officialRating']?.toString();
    viewCount = json['viewCount']?.toInt();
    publisher = json['publisher']?.toString();
    timestamp = json['timestamp']?.toString();
    status = json['status']?.toInt();
    sourceCreate = json['sourceCreate']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['newsId'] = newsId;
    if (topicInfo != null) {
      final v = topicInfo;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['topicInfo'] = arr0;
    }
    data['title'] = title;
    data['urlNews'] = urlNews;
    data['thumbNews'] = thumbNews;
    data['socialBeliefs'] = socialBeliefs;
    data['officialRating'] = officialRating;
    data['viewCount'] = viewCount;
    data['publisher'] = publisher;
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['sourceCreate'] = sourceCreate;
    return data;
  }
}
