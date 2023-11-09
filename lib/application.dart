class application {
  var id;
  var name;

  application({required this.id, required this.name});

  factory application.fromjson(Map res) {
    return application(id: res['id'], name: res['name']);
  }
}
