/// status : "ok"
/// totalResults : 5
/// articles : [{"source":{"id":"reuters","name":"Reuters"},"author":"Pei Li, Tony Munroe","title":"Exclusive: Tencent's Timi gaming studio generated $10 billion in 2020, sources say - Reuters","description":"Chinese tech giant Tencent's Timi Studios, maker of popular video games Honor of Kings and Call of Duty Mobile, generated revenue of $10 billion last year, two people with direct knowledge of the matter told Reuters.","url":"https://www.reuters.com/article/us-tencent-videogames-exclusive-idUSKBN2BP0FG","urlToImage":"https://static.reuters.com/resources/r/?m=02&d=20210402&t=2&i=1557116908&r=LYNXMPEH3106S&w=800","publishedAt":"2021-04-02T06:53:00Z","content":"(Reuters) - Chinese tech giant Tencents Timi Studios, maker of popular video games Honor of Kings and Call of Duty Mobile, generated revenue of $10 billion last year, two people with direct knowledge… [+2458 chars]"},{"source":{"id":"buzzfeed","name":"Buzzfeed"},"author":"[{\"@type\":\"Person\",\"name\":\"Joyann Jeffrey\",\"url\":\"https://www.buzzfeed.com/joyannjeffrey\",\"jobTitle\":\"BuzzFeed Staff\"}]","title":"Demi Lovato's \"Dancing With The Devil\" Music Video Recreates The Night Of Her Overdose - BuzzFeed","description":"Demi Lovato's \"Dancing With the Devil\" music video is a companion piece to her recent documentary.","url":"https://www.buzzfeed.com/joyannjeffrey/demi-lovato-dancing-with-the-devil-music-video-secrets","urlToImage":"https://img.buzzfeed.com/buzzfeed-static/static/2021-04/2/4/tmp/2a50fc7f1020/tmp-name-2-716-1617337748-22_dblbig.jpg","publishedAt":"2021-04-02T05:00:05Z","content":"If you or someone you know is in need of support, its OK to ask for help. If you or someone you know is struggling with addiction, call 1-800-662-HELP (4357) or visit samhsa.gov for free information … [+325 chars]"},{"source":{"id":"engadget","name":"Engadget"},"author":"https://www.engadget.com/about/editors/mariella-moon","title":"Sony will unveil a new Xperia device on April 14th | Engadget - Engadget","description":"Sony is launching a new Xperia product on April 14th at 4:30PM Japan time or 3:30AM Eastern time in the US.","url":"https://www.engadget.com/sony-unveil-xperia-april-14th-045740880.html","urlToImage":"https://s.yimg.com/os/creatr-uploaded-images/2021-04/91fa0140-9366-11eb-9f3f-324723c83524","publishedAt":"2021-04-02T04:59:48Z","content":"Sony has quietly updated the official Xperia page's YouTube banner to reveal that it's announcing a new product in a couple of weeks. As noticed by Droid Life, the banner says the company is launchin… [+1181 chars]"},{"source":{"id":"reuters","name":"Reuters"},"author":"Lucia Mutikani","title":"Robust U.S. employment growth expected in March, jobs deficit remains large - Reuters","description":"U.S. employers hired more workers than expected in March, spurred by increased vaccinations and more pandemic relief money from the government, cementing expectations that an economic boom was underway.","url":"https://www.reuters.com/article/us-usa-economy-idUSKBN2BP09L","urlToImage":"https://static.reuters.com/resources/r/?m=02&d=20210402&t=2&i=1557107133&r=LYNXMPEH3103Y&w=800","publishedAt":"2021-04-02T04:07:00Z","content":"FILE PHOTO: Construction workers wait in line to do a temperature test to return to the job site after lunch, amid the coronavirus disease (COVID-19) outbreak, in the Manhattan borough of New York Ci… [+2306 chars]"},{"source":{"id":null,"name":"New York Post"},"author":"Tamar Lapin","title":"DOJ probing whether Matt Gaetz paid for sex with multiple women: report - New York Post ","description":"The FBI has questioned several women who claim they were paid to sleep with Florida Rep. Matt Gaetz and his friends in drug-fueled trysts, according to a report on Thursday. The interviews were con…","url":"https://nypost.com/2021/04/01/doj-probs-matt-gaetz-for-paying-multiple-women-for-sex/","urlToImage":"https://nypost.com/wp-content/uploads/sites/2/2021/04/matt-gaetz.jpg?quality=90&strip=all&w=1200","publishedAt":"2021-04-02T03:42:00Z","content":"The FBI has questioned several women who claim they were paid to sleep with Florida Rep. Matt Gaetz and his friends in drug-fueled trysts, according to a report on Thursday.\r\nThe interviews were cond… [+2504 chars]"}]

class NewsResponse {
  String _status;
  String _message;
  int _totalResults;
  List<Articles> _articles;

  String get status => _status;
  String get message => _message;
  int get totalResults => _totalResults;
  List<Articles> get articles => _articles;

  NewsResponse({
      String status, 
      String message,
      int totalResults,
      List<Articles> articles}){
    _status = status;
    _message = message;
    _totalResults = totalResults;
    _articles = articles;
}

  NewsResponse.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _totalResults = json["totalResults"];
    if (json["articles"] != null) {
      _articles = [];
      json["articles"].forEach((v) {
        _articles.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    map["totalResults"] = _totalResults;
    if (_articles != null) {
      map["articles"] = _articles.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// source : {"id":"reuters","name":"Reuters"}
/// author : "Pei Li, Tony Munroe"
/// title : "Exclusive: Tencent's Timi gaming studio generated $10 billion in 2020, sources say - Reuters"
/// description : "Chinese tech giant Tencent's Timi Studios, maker of popular video games Honor of Kings and Call of Duty Mobile, generated revenue of $10 billion last year, two people with direct knowledge of the matter told Reuters."
/// url : "https://www.reuters.com/article/us-tencent-videogames-exclusive-idUSKBN2BP0FG"
/// urlToImage : "https://static.reuters.com/resources/r/?m=02&d=20210402&t=2&i=1557116908&r=LYNXMPEH3106S&w=800"
/// publishedAt : "2021-04-02T06:53:00Z"
/// content : "(Reuters) - Chinese tech giant Tencents Timi Studios, maker of popular video games Honor of Kings and Call of Duty Mobile, generated revenue of $10 billion last year, two people with direct knowledge… [+2458 chars]"

class Articles {
  Source _source;
  String _author;
  String _title;
  String _description;
  String _url;
  String _urlToImage;
  String _publishedAt;
  String _content;

  Source get source => _source;
  String get author => _author;
  String get title => _title;
  String get description => _description;
  String get url => _url;
  String get urlToImage => _urlToImage;
  String get publishedAt => _publishedAt;
  String get content => _content;

  Articles({
      Source source, 
      String author, 
      String title, 
      String description, 
      String url, 
      String urlToImage, 
      String publishedAt, 
      String content}){
    _source = source;
    _author = author;
    _title = title;
    _description = description;
    _url = url;
    _urlToImage = urlToImage;
    _publishedAt = publishedAt;
    _content = content;
}

  Articles.fromJson(dynamic json) {
    _source = json["source"] != null ? Source.fromJson(json["source"]) : null;
    _author = json["author"];
    _title = json["title"];
    _description = json["description"];
    _url = json["url"];
    _urlToImage = json["urlToImage"];
    _publishedAt = json["publishedAt"];
    _content = json["content"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_source != null) {
      map["source"] = _source.toJson();
    }
    map["author"] = _author;
    map["title"] = _title;
    map["description"] = _description;
    map["url"] = _url;
    map["urlToImage"] = _urlToImage;
    map["publishedAt"] = _publishedAt;
    map["content"] = _content;
    return map;
  }

}

/// id : "reuters"
/// name : "Reuters"

class Source {
  String _id;
  String _name;

  String get id => _id;
  String get name => _name;

  Source({
      String id, 
      String name}){
    _id = id;
    _name = name;
}

  Source.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}