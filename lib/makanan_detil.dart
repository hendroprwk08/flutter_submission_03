class Makanan_Detil {
  String idMeal, strMeal, strCategory, strInstructions, strMealThumb;

  Makanan_Detil(this.idMeal, this.strMeal, this.strCategory, this.strInstructions, this.strMealThumb);

  factory Makanan_Detil.fromJson(Map<String, dynamic> json) {
    return Makanan_Detil(
      json['idMeal'],
      json['strMeal'],
      json['strCategory'],
      json['strInstructions'],
      json['strMealThumb']
    );
  }
}