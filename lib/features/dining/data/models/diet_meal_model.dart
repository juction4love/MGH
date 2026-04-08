class DietMeal {
  final String id;
  final String name;
  final String description; // उदा: "नरम जाउलो, पचाउन सजिलो"
  final double price;
  final String calories;
  final bool isVeggies;

  DietMeal({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.calories,
    this.isVeggies = true,
  });
}
