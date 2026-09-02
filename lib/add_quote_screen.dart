import 'package:flutter/material.dart';

// ============================================================
// ADD QUOTE SCREEN
// ============================================================

class AddQuoteScreen extends StatefulWidget {
  const AddQuoteScreen({super.key});

  @override
  State<AddQuoteScreen> createState() =>
      _AddQuoteScreenState();
}

class _AddQuoteScreenState
    extends State<AddQuoteScreen> {

  // ==========================================================
  // CONTROLLERS
  // ==========================================================

  final TextEditingController quoteController =
      TextEditingController();

  final TextEditingController movieController =
      TextEditingController();

  final TextEditingController characterController =
      TextEditingController();

  final TextEditingController yearController =
      TextEditingController();

  final TextEditingController contextController =
      TextEditingController();

  // ==========================================================
  // FAVORITE
  // ==========================================================

  bool isFavorite = false;

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    quoteController.dispose();
    movieController.dispose();
    characterController.dispose();
    yearController.dispose();
    contextController.dispose();

    super.dispose();
  }

  // ==========================================================
  // ADD QUOTE
  // ==========================================================

  void addQuote() {

    // Required fields validation
    if (quoteController.text.trim().isEmpty ||
        movieController.text.trim().isEmpty ||
        characterController.text.trim().isEmpty ||
        yearController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all required fields',
          ),
        ),
      );

      return;
    }

    // ========================================================
    // NEW QUOTE MAP
    // ========================================================

    final Map<String, dynamic> newQuote = {
      'quote': quoteController.text.trim(),

      'movie': movieController.text.trim(),

      'character':
          characterController.text.trim(),

      'year':
          yearController.text.trim(),

      'context':
          contextController.text.trim(),

      'isFavorite': isFavorite,
    };

    // ========================================================
    // RETURN TO HOME
    // ========================================================

    Navigator.pop(
      context,
      newQuote,
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        title: const Text(
          'Add New Quote',
        ),

        backgroundColor:
            const Color(0xFF4527A0),

        foregroundColor:
            Colors.white,
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ==================================================
            // QUOTE
            // ==================================================

            const FieldLabel(
              title: 'Movie Quote',
              requiredField: true,
            ),

            TextField(
              controller: quoteController,

              maxLines: 3,

              decoration: inputDecoration(
                'Enter the movie quote',
                Icons.format_quote,
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // MOVIE
            // ==================================================

            const FieldLabel(
              title: 'Movie Title',
              requiredField: true,
            ),

            TextField(
              controller: movieController,

              decoration: inputDecoration(
                'Enter movie name',
                Icons.movie_outlined,
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // CHARACTER
            // ==================================================

            const FieldLabel(
              title: 'Character Name',
              requiredField: true,
            ),

            TextField(
              controller: characterController,

              decoration: inputDecoration(
                'Enter character name',
                Icons.person_outline,
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // YEAR
            // ==================================================

            const FieldLabel(
              title: 'Release Year',
              requiredField: true,
            ),

            TextField(
              controller: yearController,

              keyboardType:
                  TextInputType.number,

              decoration: inputDecoration(
                'Enter release year',
                Icons.calendar_today_outlined,
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // CONTEXT NOTES
            // ==================================================

            const FieldLabel(
              title: 'Context Notes',
              requiredField: false,
            ),

            TextField(
              controller: contextController,

              maxLines: 4,

              decoration: inputDecoration(
                'Add some context about the quote',
                Icons.notes_outlined,
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // ADD TO FAVORITES
            // ==================================================

            Card(
              child: SwitchListTile(
                title: const Text(
                  'Add to Favorites',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  'Save this quote as a favorite',
                ),

                value: isFavorite,

                activeColor:
                    const Color(0xFF4527A0),

                onChanged: (value) {
                  setState(() {
                    isFavorite = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),

            // ==================================================
            // ADD BUTTON
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton.icon(
                onPressed: addQuote,

                icon: const Icon(
                  Icons.add,
                ),

                label: const Text(
                  'Add Quote',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF4527A0),

                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// FIELD LABEL
// ============================================================

class FieldLabel extends StatelessWidget {

  final String title;

  final bool requiredField;

  const FieldLabel({
    super.key,
    required this.title,
    required this.requiredField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 7),

      child: Row(
        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 14,
            ),
          ),

          if (requiredField)
            const Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================
// INPUT DECORATION
// ============================================================

InputDecoration inputDecoration(
  String hint,
  IconData icon,
) {
  return InputDecoration(
    hintText: hint,

    prefixIcon: Icon(
      icon,
    ),

    filled: true,

    fillColor: Colors.white,

    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(12),

      borderSide:
          BorderSide.none,
    ),

    enabledBorder:
        OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(12),

      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
    ),

    focusedBorder:
        OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(12),

      borderSide:
          const BorderSide(
        color: Color(0xFF4527A0),
        width: 2,
      ),
    ),
  );
}