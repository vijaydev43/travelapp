class api {
  var id;
  var name;

  api({required this.id, required this.name});

  factory api.fromjson(Map res) {
    return api(id: res['id'], name: res['name']);
  }
}
