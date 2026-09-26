import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recipe.dart';
import 'package:flutter_application_1/models/recipe_ingredient.dart';
import 'package:flutter_application_1/widgets/bottom_sheet_option_ui.dart';
import 'package:flutter_application_1/widgets/number_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipesScreen extends StatefulWidget {
  final Recipe? initialRecipe;

  const CreateRecipesScreen({super.key, this.initialRecipe});

  @override
  State<CreateRecipesScreen> createState() => _CreateRecipesScreenState();
}

class _CreateRecipesScreenState extends State<CreateRecipesScreen> {
  // =========================================================
  // MEAL TYPE
  // =========================================================

  String? selectedMealType;

  final List<String> mealTypes = ["Breakfast", "Lunch", "Dinner", "Snack"];

  // =========================================================
  // RECIPE NAME
  // =========================================================

  final TextEditingController nameController = TextEditingController();

  String recipeName = "";

  // =========================================================
  // IMAGE
  // =========================================================

  File? selectedImage;
  String? selectedAssetImage;

  final ImagePicker imagePicker = ImagePicker();

  // =========================================================
  // INGREDIENTS
  // =========================================================

  final List<RecipeIngredient> ingredients = [];

  // =========================================================
  // TOTALS
  // =========================================================

  double totalCalories = 0;
  double totalCarbs = 0;
  double totalProtein = 0;

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    final recipe = widget.initialRecipe;

    if (recipe != null) {
      recipeName = recipe.title;

      selectedMealType = recipe.mealType;

      selectedImage = recipe.imageFile;

      selectedAssetImage = recipe.assetImage;

      // -------------------------------------------------------
      // Clone ingredients
      // -------------------------------------------------------

      for (final oldIngredient in recipe.ingredients) {
        ingredients.add(
          RecipeIngredient(
            itemController: TextEditingController(
              text: oldIngredient.itemController.text,
            ),
            quantityController: TextEditingController(
              text: oldIngredient.quantityController.text,
            ),
            caloriesController: TextEditingController(
              text: oldIngredient.caloriesController.text,
            ),
            carbsController: TextEditingController(
              text: oldIngredient.carbsController.text,
            ),
            proteinController: TextEditingController(
              text: oldIngredient.proteinController.text,
            ),
          ),
        );
      }

      _calculateTotals(notify: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.initialRecipe != null;

    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =========================================================
            // RECIPE NAME + MEAL TYPE
            // =========================================================

            Row(
              children: [
                Flexible(
                  child: Text(
                    recipeName.isEmpty ? "Type Recipe Name" : recipeName,

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                      color: recipeName.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),

                const SizedBox(width: 5),

                IconButton(
                  padding: EdgeInsets.zero,

                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),

                  icon: const Icon(Icons.edit, size: 19),

                  onPressed: () {
                    _showEditRecipeNameDialog();
                  },
                ),

                const SizedBox(width: 3),

                Container(
                  height: 32.h,
                  width: 150.w,

                  padding: const EdgeInsets.symmetric(horizontal: 7),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(8),

                    border: Border.all(color: Colors.black26),
                  ),

                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedMealType,

                      hint: const Text(
                        "Meal",
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      ),

                      icon: const Icon(Icons.keyboard_arrow_down, size: 16),

                      isDense: true,

                      items: mealTypes.map((meal) {
                        return DropdownMenuItem<String>(
                          value: meal,

                          child: Text(
                            meal,
                            style: const TextStyle(fontSize: 11),
                          ),
                        );
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedMealType = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // =========================================================
            // IMAGE
            // =========================================================
            GestureDetector(
              onTap: _showImagePickerBottomSheet,

              child: Container(
                width: double.infinity,
                height: 190,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 233, 233),

                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(color: Colors.black26, width: 2),
                ),

                child: Stack(
                  children: [
                    Center(child: _buildRecipeImage()),

                    Positioned(
                      right: 8,
                      bottom: 8,

                      child: Row(
                        children: [
                          const Text(
                            "Add Image",
                            style: TextStyle(fontSize: 11),
                          ),

                          const SizedBox(width: 5),

                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),

                            child: const Icon(
                              Icons.add_circle_outline,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // =========================================================
            // TOTAL NUTRITION
            // =========================================================
            Row(
              children: [
                Expanded(
                  child: _buildNutritionCard(
                    icon: Icons.grass,
                    title: "Carbs",
                    value: totalCarbs,
                    unit: "g",
                  ),
                ),

                const SizedBox(width: 7),

                Expanded(
                  child: _buildNutritionCard(
                    icon: Icons.egg_alt,
                    title: "Protein",
                    value: totalProtein,
                    unit: "g",
                  ),
                ),

                const SizedBox(width: 7),

                Expanded(
                  child: _buildNutritionCard(
                    icon: Icons.local_fire_department,
                    title: "Calories",
                    value: totalCalories,
                    unit: "kcal",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // =========================================================
            // INGREDIENT HEADERS
            // =========================================================
            Row(
              children: const [
                Expanded(
                  flex: 14,
                  child: Text(
                    "Item",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ),

                Expanded(
                  flex: 10,
                  child: Text(
                    "Quantity",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ),

                Expanded(
                  flex: 10,
                  child: Text(
                    "Calories",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ),

                Expanded(
                  flex: 10,
                  child: Text(
                    "Carbs",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ),

                Expanded(
                  flex: 11,
                  child: Text(
                    "Protein",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                  ),
                ),

                SizedBox(width: 28),
              ],
            ),

            const SizedBox(height: 3),

            // =========================================================
            // INGREDIENTS LIST
            // =========================================================
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.length,

                padding: EdgeInsets.zero,

                itemBuilder: (context, index) {
                  final ingredient = ingredients[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7),

                    child: Row(
                      children: [
                        Expanded(
                          flex: 14,

                          child: _buildItemField(ingredient.itemController),
                        ),

                        const SizedBox(width: 3),

                        Expanded(
                          flex: 10,

                          child: NumberField(
                            controller: ingredient.quantityController,

                            hintText: "g",
                          ),
                        ),

                        const SizedBox(width: 3),

                        Expanded(
                          flex: 10,

                          child: NumberField(
                            controller: ingredient.caloriesController,

                            hintText: "kcal",

                            onChanged: (_) {
                              _calculateTotals();
                            },
                          ),
                        ),

                        const SizedBox(width: 3),

                        Expanded(
                          flex: 10,

                          child: NumberField(
                            controller: ingredient.carbsController,

                            hintText: "grams",

                            onChanged: (_) {
                              _calculateTotals();
                            },
                          ),
                        ),

                        const SizedBox(width: 3),

                        Expanded(
                          flex: 11,

                          child: NumberField(
                            controller: ingredient.proteinController,

                            hintText: "grams",

                            onChanged: (_) {
                              _calculateTotals();
                            },
                          ),
                        ),

                        SizedBox(
                          width: 28,

                          child: IconButton(
                            padding: EdgeInsets.zero,

                            constraints: const BoxConstraints(),

                            icon: const Icon(Icons.delete_outline, size: 19),

                            onPressed: () {
                              removeIngredient(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // =========================================================
            // ADD INGREDIENT
            // =========================================================
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B6478),

                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  elevation: 0,
                ),

                onPressed: addIngredient,

                child: const Text(
                  "+ Add Ingredient",

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // =========================================================
            // CANCEL + SAVE
            // =========================================================
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF6C6C),

                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),

                        elevation: 0,
                      ),

                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        "Cancel",

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 50,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5DDD5),

                        foregroundColor: Colors.black,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),

                          side: const BorderSide(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),

                        elevation: 0,
                      ),

                      onPressed: () {
                        final Recipe updatedRecipe = Recipe(
                          title: recipeName,

                          mealType: selectedMealType,

                          imageFile: selectedImage,

                          assetImage: selectedImage != null
                              ? null
                              : selectedAssetImage,

                          totalCalories: totalCalories,

                          ingredients: List.from(ingredients),
                        );

                        Navigator.pop(context, updatedRecipe);
                      },

                      child: Text(
                        isEditing ? "Save" : "Done",

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // IMAGE WIDGET
  // =========================================================

  Widget _buildRecipeImage() {
    if (selectedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),

        child: Image.file(
          selectedImage!,

          width: double.infinity,
          height: double.infinity,

          fit: BoxFit.cover,
        ),
      );
    }

    if (selectedAssetImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),

        child: Image.asset(
          selectedAssetImage!,

          width: double.infinity,
          height: double.infinity,

          fit: BoxFit.cover,
        ),
      );
    }

    return const Icon(Icons.image_outlined, size: 90, color: Colors.white);
  }

  // =========================================================
  // NUTRITION CARD
  // =========================================================

  Widget _buildNutritionCard({
    required IconData icon,
    required String title,
    required double value,
    required String unit,
  }) {
    return Container(
      height: 82,

      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),

        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(
            title,

            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),

          const SizedBox(height: 3),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(icon, size: 20, color: Colors.orangeAccent),

              const SizedBox(width: 5),

              Text(
                _formatNumber(value),

                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 3),

              Text(
                unit,

                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ITEM TEXT FIELD
  // =========================================================

  Widget _buildItemField(TextEditingController controller) {
    return SizedBox(
      height: 48,

      child: TextField(
        controller: controller,

        textInputAction: TextInputAction.next,

        style: const TextStyle(fontSize: 13),

        decoration: InputDecoration(
          hintText: "Item",

          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 8,
          ),

          filled: true,

          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),

            borderSide: const BorderSide(color: Colors.black12),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),

            borderSide: const BorderSide(color: Colors.black12),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),

            borderSide: const BorderSide(color: Color(0xFF445E75)),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // ADD INGREDIENT
  // =========================================================

  void addIngredient() {
    setState(() {
      ingredients.add(
        RecipeIngredient(
          itemController: TextEditingController(),

          quantityController: TextEditingController(),

          caloriesController: TextEditingController(),

          carbsController: TextEditingController(),

          proteinController: TextEditingController(),
        ),
      );
    });
  }

  // =========================================================
  // REMOVE INGREDIENT
  // =========================================================

  void removeIngredient(int index) {
    if (index < 0 || index >= ingredients.length) {
      return;
    }

    ingredients[index].dispose();

    setState(() {
      ingredients.removeAt(index);
    });

    _calculateTotals();
  }

  // =========================================================
  // CALCULATE TOTALS
  // =========================================================

  void _calculateTotals({bool notify = true}) {
    double calories = 0;
    double carbs = 0;
    double protein = 0;

    for (final ingredient in ingredients) {
      calories += double.tryParse(ingredient.caloriesController.text) ?? 0;

      carbs += double.tryParse(ingredient.carbsController.text) ?? 0;

      protein += double.tryParse(ingredient.proteinController.text) ?? 0;
    }

    if (notify) {
      setState(() {
        totalCalories = calories;
        totalCarbs = carbs;
        totalProtein = protein;
      });
    } else {
      totalCalories = calories;
      totalCarbs = carbs;
      totalProtein = protein;
    }
  }

  // =========================================================
  // FORMAT NUMBER
  // =========================================================

  String _formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(1);
  }

  // =========================================================
  // PICK IMAGE
  // =========================================================

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await imagePicker.pickImage(source: source);

    if (!mounted) return;

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);

        selectedAssetImage = null;
      });
    }
  }

  // =========================================================
  // IMAGE BOTTOM SHEET
  // =========================================================

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                ImagePickerOptionItem(
                  icon: Icons.photo_library_outlined,

                  label: "Gallery",

                  onTap: () {
                    Navigator.pop(context);

                    _pickImage(ImageSource.gallery);
                  },
                ),

                ImagePickerOptionItem(
                  icon: Icons.camera_alt_outlined,

                  label: "Camera",

                  onTap: () {
                    Navigator.pop(context);

                    _pickImage(ImageSource.camera);
                  },
                ),

                ImagePickerOptionItem(
                  icon: Icons.delete_outline,

                  label: "Delete",

                  onTap: () {
                    Navigator.pop(context);

                    setState(() {
                      selectedImage = null;
                      selectedAssetImage = null;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // EDIT RECIPE NAME
  // =========================================================

  void _showEditRecipeNameDialog() {
    nameController.text = recipeName;

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Recipe Name"),

          content: TextField(
            controller: nameController,

            autofocus: true,

            decoration: const InputDecoration(
              hintText: "Type here your Recipe name",

              border: OutlineInputBorder(),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  recipeName = nameController.text;
                });

                Navigator.pop(context);
              },

              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    nameController.dispose();

    for (final ingredient in ingredients) {
      ingredient.dispose();
    }

    super.dispose();
  }
}
