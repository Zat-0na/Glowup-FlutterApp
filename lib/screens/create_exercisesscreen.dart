import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/exercise_set.dart';
import 'package:flutter_application_1/widgets/bottom_sheet_option_ui.dart';
import 'package:flutter_application_1/widgets/custom_dropdown.dart';
import 'package:flutter_application_1/widgets/number_field.dart';
import 'package:image_picker/image_picker.dart';

class CreateExercisesScreen extends StatefulWidget {
  final Exercise? initialExercise;

  const CreateExercisesScreen({super.key, this.initialExercise});

  @override
  State<CreateExercisesScreen> createState() => _CreateExercisesScreenState();
}

class _CreateExercisesScreenState extends State<CreateExercisesScreen> {
  String? selectedDifficulty;
  String? selectedMuscleGroup;

  final List<String> muscleGroups = [
    "Chest",
    "Back",
    "Legs",
    "Shoulders",
    "Biceps",
    "Triceps",
  ];

  final TextEditingController nameController = TextEditingController();

  String exerciseName = "";

  File? selectedImage;
  String? selectedAssetImage;

  final ImagePicker imagePicker = ImagePicker();

  // =========================================================
  // SETS
  // =========================================================

  final List<ExerciseSet> sets = [];

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    final exercise = widget.initialExercise;

    if (exercise != null) {
      exerciseName = exercise.title;

      selectedDifficulty = exercise.difficulty;

      selectedMuscleGroup = exercise.muscleGroup;

      selectedImage = exercise.imageFile;

      selectedAssetImage = exercise.assetImage;

      // -------------------------------------------------------
      // Clone existing sets
      // -------------------------------------------------------

      for (final oldSet in exercise.sets) {
        sets.add(
          ExerciseSet(
            weightController: TextEditingController(
              text: oldSet.weightController.text,
            ),
            repsController: TextEditingController(
              text: oldSet.repsController.text,
            ),
          ),
        );
      }
    }

    // ---------------------------------------------------------
    // At least one set is always required
    // ---------------------------------------------------------

    if (sets.isEmpty) {
      addSet();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.initialExercise != null;

    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =========================================================
            // EXERCISE NAME + EDIT
            // =========================================================

            Row(
              children: [
                Expanded(
                  child: Text(
                    exerciseName.isEmpty ? "Type Exercise Name" : exerciseName,

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: exerciseName.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditExerciseNameDialog();
                  },
                ),
              ],
            ),

            const SizedBox(height: 15),

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
                    Center(child: _buildExerciseImage()),

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

            const SizedBox(height: 20),

            // =========================================================
            // DIFFICULTY + MUSCLE GROUP
            // =========================================================
            Row(
              children: [
                Expanded(
                  child: CustomAddableDropdown(
                    width: double.infinity,
                    label: "Difficulty",
                    allowAddNew: false,

                    items: const ["Beginner", "Intermediate", "Expert"],

                    initialValue: selectedDifficulty,

                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedDifficulty = value;
                        });
                      }
                    },
                  ),
                ),

                const SizedBox(width: 5),

                Expanded(
                  child: CustomAddableDropdown(
                    width: double.infinity,
                    label: "Muscle group",
                    allowAddNew: true,

                    items: muscleGroups,

                    initialValue: selectedMuscleGroup,

                    onItemAdded: (newItem) {
                      setState(() {
                        muscleGroups.add(newItem);
                      });
                    },

                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedMuscleGroup = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // =========================================================
            // SETS TITLE
            // =========================================================
            Row(
              children: const [
                Text(
                  "Sets",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),

                SizedBox(width: 25),

                Text(
                  "Weight (kg)",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),

                SizedBox(width: 40),

                Text(
                  "Reps",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),
              ],
            ),

            // =========================================================
            // SETS LIST
            // =========================================================
            Expanded(
              child: ListView.builder(
                itemCount: sets.length,

                itemBuilder: (context, index) {
                  final ExerciseSet currentSet = sets[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),

                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,

                          child: Text(
                            "Set ${index + 1}",

                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),

                        const SizedBox(width: 5),

                        Expanded(
                          child: NumberField(
                            controller: currentSet.weightController,

                            hintText: "Kg",
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: NumberField(
                            controller: currentSet.repsController,

                            hintText: "Reps",
                          ),
                        ),

                        const SizedBox(width: 5),

                        IconButton(
                          onPressed: sets.length == 1
                              ? null
                              : () {
                                  removeSet(index);
                                },

                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // =========================================================
            // ADD SET
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

                onPressed: addSet,

                child: const Text(
                  "+ Add Set",

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
                        final Exercise updatedExercise = Exercise(
                          title: exerciseName,

                          muscleGroup: selectedMuscleGroup,

                          difficulty: selectedDifficulty,

                          imageFile: selectedImage,

                          assetImage: selectedImage != null
                              ? null
                              : selectedAssetImage,

                          sets: List.from(sets),
                        );

                        Navigator.pop(context, updatedExercise);
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

  Widget _buildExerciseImage() {
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
  // ADD SET
  // =========================================================

  void addSet() {
    setState(() {
      sets.add(
        ExerciseSet(
          weightController: TextEditingController(),

          repsController: TextEditingController(),
        ),
      );
    });
  }

  // =========================================================
  // REMOVE SET
  // =========================================================

  void removeSet(int index) {
    if (sets.length == 1) {
      return;
    }

    if (index < 0 || index >= sets.length) {
      return;
    }

    setState(() {
      sets[index].dispose();
      sets.removeAt(index);
    });
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

        // New local image replaces old asset image.
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
  // EDIT EXERCISE NAME
  // =========================================================

  void _showEditExerciseNameDialog() {
    nameController.text = exerciseName;

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Exercise Name"),

          content: TextField(
            controller: nameController,
            autofocus: true,

            decoration: const InputDecoration(
              hintText: "Type here your Exercise name",

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
                  exerciseName = nameController.text;
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

    for (final set in sets) {
      set.dispose();
    }

    super.dispose();
  }
}
