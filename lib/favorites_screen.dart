import 'package:flutter/material.dart';

// ============================================================
// FAVORITES SCREEN
// ============================================================

class FavoritesScreen extends StatelessWidget {

  final List<Map<String, dynamic>> quotes;

  final Function(int) onFavorite;

  const FavoritesScreen({
    super.key,
    required this.quotes,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {

    // ========================================================
    // FILTER FAVORITES
    // ========================================================

    final favoriteQuotes = quotes
        .where(
          (quote) =>
              quote['isFavorite'] == true,
        )
        .toList();

    // ========================================================
    // EMPTY STATE
    // ========================================================

    if (favoriteQuotes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // HEART
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey[400],
            ),

            const SizedBox(height: 16),

            const Text(
              'No Favorite Quotes',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your favorite movie quotes will appear here.',
              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    // ========================================================
    // FAVORITE LIST
    // ========================================================

    return ListView.builder(
      padding: const EdgeInsets.all(16),

      itemCount:
          favoriteQuotes.length,

      itemBuilder: (context, index) {

        final quote =
            favoriteQuotes[index];

        final originalIndex =
            quotes.indexOf(quote);

        return FavoriteQuoteCard(
          quote: quote['quote'].toString(),

          movie: quote['movie'].toString(),

          character:
              quote['character'].toString(),

          year:
              quote['year'].toString(),

          onFavorite: () {
            onFavorite(
              originalIndex,
            );
          },
        );
      },
    );
  }
}

// ============================================================
// FAVORITE QUOTE CARD
// ============================================================

class FavoriteQuoteCard extends StatelessWidget {

  final String quote;
  final String movie;
  final String character;
  final String year;

  final VoidCallback onFavorite;

  const FavoriteQuoteCard({
    super.key,
    required this.quote,
    required this.movie,
    required this.character,
    required this.year,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),

      elevation: 2,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ==================================================
            // QUOTE + HEART
            // ==================================================

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const Icon(
                  Icons.format_quote,

                  color:
                      Color(0xFF4527A0),

                  size: 32,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    quote,

                    style:
                        const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                // HEART
                IconButton(
                  onPressed:
                      onFavorite,

                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const Divider(),

            const SizedBox(height: 8),

            // MOVIE
            SmallInfoRow(
              icon:
                  Icons.movie_outlined,
              text: movie,
            ),

            const SizedBox(height: 7),

            // CHARACTER
            SmallInfoRow(
              icon:
                  Icons.person_outline,
              text: character,
            ),

            const SizedBox(height: 7),

            // YEAR
            SmallInfoRow(
              icon:
                  Icons.calendar_today_outlined,
              text: year,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SMALL INFO ROW
// ============================================================

class SmallInfoRow extends StatelessWidget {

  final IconData icon;

  final String text;

  const SmallInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Icon(
          icon,
          size: 17,
          color: Colors.grey[600],
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}