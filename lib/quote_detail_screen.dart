import 'package:flutter/material.dart';

// ============================================================
// QUOTE DETAIL SCREEN
// ============================================================

class QuoteDetailScreen extends StatelessWidget {
  final Map<String, dynamic> quote;

  const QuoteDetailScreen({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = quote['isFavorite'] == true;

    return Scaffold(

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        title: const Text(
          'Quote Details',
        ),
        backgroundColor: const Color(0xFF4527A0),
        foregroundColor: Colors.white,
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // ==================================================
            // QUOTE CONTAINER
            // ==================================================

            SizedBox(
              width: double.infinity,

              child: Card(
                elevation: 3,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(22),

                  child: Column(
                    children: [

                      // QUOTE ICON
                      Container(
                        width: 65,
                        height: 65,

                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE7F6),

                          borderRadius:
                              BorderRadius.circular(18),
                        ),

                        child: const Icon(
                          Icons.format_quote,
                          size: 38,
                          color: Color(0xFF4527A0),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // QUOTE TEXT
                      Text(
                        '"${quote['quote']}"',

                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // MOVIE INFORMATION
            // ==================================================

            const Text(
              'Movie Information',

              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // MOVIE
            DetailInfoCard(
              icon: Icons.movie_outlined,
              title: 'Movie',
              value: quote['movie'].toString(),
            ),

            const SizedBox(height: 10),

            // CHARACTER
            DetailInfoCard(
              icon: Icons.person_outline,
              title: 'Character',
              value: quote['character'].toString(),
            ),

            const SizedBox(height: 10),

            // YEAR
            DetailInfoCard(
              icon: Icons.calendar_today_outlined,
              title: 'Release Year',
              value: quote['year'].toString(),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // CONTEXT NOTES
            // ==================================================

            const Text(
              'Context Notes',

              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(15),

                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),

              child: Text(
                quote['context']?.toString().isNotEmpty == true
                    ? quote['context'].toString()
                    : 'No context notes added.',

                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.grey[700],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // FAVORITE STATUS
            // ==================================================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: isFavorite
                    ? Colors.red.withOpacity(0.08)
                    : Colors.grey.withOpacity(0.08),

                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: Row(
                children: [

                  // HEART ❤️
                  Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,

                    color: isFavorite
                        ? Colors.red
                        : Colors.grey,

                    size: 24,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      isFavorite
                          ? 'This quote is in your favorites'
                          : 'This quote is not in your favorites',

                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DETAIL INFO CARD
// ============================================================

class DetailInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const DetailInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Row(
        children: [

          // ==================================================
          // ICON
          // ==================================================

          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: const Color(0xFFEDE7F6),

              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: Icon(
              icon,

              color:
                  const Color(0xFF4527A0),
            ),
          ),

          const SizedBox(width: 14),

          // ==================================================
          // TEXT
          // ==================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}