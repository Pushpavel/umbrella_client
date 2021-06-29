class Stand {
  final String name;
  final String id;

  Stand(this.name, this.id);

  factory Stand.fromDynamic(String key, data) {
    return Stand(data["name"], key);
  }
}
