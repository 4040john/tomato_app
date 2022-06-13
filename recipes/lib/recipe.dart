class Recipe {
  // ? : null가능, 없으면 기본값 필요(null x)
  String? label;
  String? imageUrl;
  int servings;
  List<Ingredient> ingredients;

  //생성자 : 마치 주문시의 주문서 ->주문시  instance 생성
  Recipe(
    this.label,
    this.imageUrl,
    this.servings,
    this.ingredients,
  );
}

class Ingredient {
  String name;
  String measure;
  double quantity;

  //중괄호가 없으면 순서대로
  Ingredient(
    this.quantity,
    this.measure,
    this.name,
  );
}

List<Recipe> recipes = [
  Recipe(
    'Spaghetti and Meatballs',
    'assets/image/cafe_1.jpeg',
    4,
    [
      Ingredient(
        1,
        'box',
        'Spaghetti',
      ),
      Ingredient(
        4,
        '',
        'Frozen Meatballs',
      ),
      Ingredient(
        0.5,
        'jar',
        'sauce',
      ),
    ],
  ),
  Recipe(
    'Tomato Soup',
    'assets/image/cafe_2.jpeg',
    2,
    [
      Ingredient(
        1,
        'can',
        'Tomato Soup',
      ),
    ],
  ),
  Recipe(
    'Grilled Cheese',
    'assets/image/cafe_3.jpeg',
    1,
    [
      Ingredient(
        2,
        'slices',
        'Cheese',
      ),
      Ingredient(
        2,
        'slices',
        'Bread',
      ),
    ],
  ),
  Recipe(
    'Chocolate Chip Cookies',
    'assets/image/cafe_4.jpeg',
    24,
    [
      Ingredient(
        4,
        'cups',
        'flour',
      ),
      Ingredient(
        2,
        'cups',
        'sugar',
      ),
      Ingredient(
        0.5,
        'cups',
        'chocolate chips',
      ),
    ],
  ),
  Recipe(
    'Taco Salad',
    'assets/image/ddukguk.jpeg',
    1,
    [
      Ingredient(
        4,
        'oz',
        'nachos',
      ),
      Ingredient(
        3,
        'oz',
        'taco meat',
      ),
      Ingredient(
        0.5,
        'cup',
        'cheese',
      ),
      Ingredient(
        0.25,
        'cup',
        'chopped tomatoes',
      ),
    ],
  ),
  Recipe(
    'Hawaiian Pizza',
    'assets/image/pizza.jpeg',
    4,
    [
      Ingredient(
        1,
        'item',
        'pizza',
      ),
      Ingredient(
        1,
        'cup',
        'pineapple',
      ),
      Ingredient(
        8,
        'oz',
        'ham',
      ),
    ],
  ),
];
