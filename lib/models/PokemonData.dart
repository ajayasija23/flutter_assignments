class PokemonData {
  PokemonData({
      num? count, 
      String? next, 
      dynamic previous, 
      List<Results>? results,}){
    _count = count;
    _next = next;
    _previous = previous;
    _results = results;
}

  PokemonData.fromJson(dynamic json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  num? _count;
  String? _next;
  dynamic _previous;
  List<Results>? _results;
PokemonData copyWith({  num? count,
  String? next,
  dynamic previous,
  List<Results>? results,
}) => PokemonData(  count: count ?? _count,
  next: next ?? _next,
  previous: previous ?? _previous,
  results: results ?? _results,
);
  num? get count => _count;
  String? get next => _next;
  dynamic get previous => _previous;
  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['next'] = _next;
    map['previous'] = _previous;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Results {
  Results({
      String? name, 
      String? url,}){
    _name = name;
    _url = url;
}

  Results.fromJson(dynamic json) {
    _name = json['name'];
    _url = json['url'];
  }
  String? _name;
  String? _url;
Results copyWith({  String? name,
  String? url,
}) => Results(  name: name ?? _name,
  url: url ?? _url,
);
  String? get name => _name;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['url'] = _url;
    return map;
  }

}