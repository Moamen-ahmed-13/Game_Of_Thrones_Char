class Continents {
  late String continent;

  Continents.fromJson(Map<String,dynamic> json){
    continent = json['name'];
  }
}
