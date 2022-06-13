import 'package:flutter/material.dart';
import 'package:recipes/recipe.dart';
import 'package:recipes/recipe_detail.dart';

void main() {
  runApp(
    const RecipesApp(),
  );
}

class RecipesApp extends StatelessWidget {
  const RecipesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //Scaffold - MaterialApp 안에서 사용 가능
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'this is the Recipes App',
        ),
      ),
      //Container: 말그대로 박스
      body: Container(
        color: Colors.grey,
        //변수 뒤 ?? null 일경우의 default 값 지정, 변수 뒤 ! null 일수 없다
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return RecipeDetail(text: 'Datail Page', recipe: recipes[index]);
                }));
              },
              child: buildRecipeCard(recipes[index]),
            );
          },
          itemCount: recipes.length,
        ),
      ),
      // Text(recipe.label?? 'default'),
    );
  }

  Widget buildRecipeCard(Recipe recipe) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(recipe.imageUrl!),
            const SizedBox(
              height: 12,
            ),
            Text(
              recipe.label!,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Palatino'),
            ),
          ],
        ),
      ),
    );
  }
}
