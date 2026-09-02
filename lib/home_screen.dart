import 'package:flutter/material.dart';

import 'add_quote_screen.dart';
import 'favorites_screen.dart';
import 'quote_detail_screen.dart';

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // ==========================================================
  // BOTTOM NAVIGATION
  // ==========================================================

  // 0 = Home
  // 1 = Favorites
  int currentIndex = 0;

  // ==========================================================
  // MOVIE QUOTES
  // ==========================================================

  List<Map<String, dynamic>> quotes = [

    {
      'quote': 'Why so serious?',
      'movie': 'The Dark Knight',
      'character': 'Joker',
      'year': '2008',
      'context':
          'The Joker questions Batman and creates chaos in Gotham.',
      'isFavorite': true,
    },

    {
      'quote': "I'll be back.",
      'movie': 'The Terminator',
      'character': 'T-800',
      'year': '1984',
      'context':
          'The Terminator says this before leaving the police station.',
      'isFavorite': true,
    },

    {
      'quote': 'May the Force be with you.',
      'movie': 'Star Wars: A New Hope',
      'character': 'Han Solo',
      'year': '1977',
      'context':
          'A famous expression wishing someone luck and protection.',
      'isFavorite': false,
    },

    {
      'quote': 'Life is like a box of chocolates.',
      'movie': 'Forrest Gump',
      'character': 'Forrest Gump',
      'year': '1994',
      'context':
          'Forrest compares life to a box of chocolates.',
      'isFavorite': false,
    },
  ];

  // ==========================================================
  // ADD QUOTE
  // ==========================================================

  void openAddQuoteScreen() async {
    final newQuote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddQuoteScreen(),
      ),
    );

    if (newQuote != null) {
      setState(() {
        quotes.add(
          newQuote as Map<String, dynamic>,
        );
      });
    }
  }

  // ==========================================================
  // HEART / FAVORITE
  // ==========================================================

  void toggleFavorite(int index) {
    setState(() {
      quotes[index]['isFavorite'] =
          !quotes[index]['isFavorite'];
    });
  }

  // ==========================================================
  // OPEN DETAIL SCREEN
  // ==========================================================

  void openQuoteDetails(Map<String, dynamic> quote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuoteDetailScreen(
          quote: quote,
        ),
      ),
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
        elevation: 0,

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4527A0),
                Color(0xFF7E57C2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // MENU
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Menu clicked'),
              ),
            );
          },
        ),

        // TITLE
        title: const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'CineQuotes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Your personal movie quote collection',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),

        // APP BAR BUTTONS
        actions: [

          // SEARCH
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Search feature coming soon',
                  ),
                ),
              );
            },
          ),

          // ADD
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: openAddQuoteScreen,
          ),

          const SizedBox(width: 5),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: currentIndex == 0
          ? _buildHomeContent()
          : FavoritesScreen(
              quotes: quotes,
              onFavorite: toggleFavorite,
            ),

      // ========================================================
      // BOTTOM NAVIGATION
      // ========================================================

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor:
            const Color(0xFF4527A0),

        unselectedItemColor:
            Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [

          // HOME
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),

          // FAVORITES - HEART
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
            ),
            activeIcon: Icon(
              Icons.favorite,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // HOME CONTENT
  // ==========================================================

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // ====================================================
          // HEADER
          // ====================================================

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Expanded(
                child: Text(
                  'Your Movie Quotes (${quotes.length})',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF29252F),
                  ),
                ),
              ),

              // FILTER
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Filter feature coming soon',
                      ),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.filter_list,
                  size: 18,
                ),

                label: const Text(
                  'Filter',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ====================================================
          // QUOTE LIST
          // ====================================================

          Expanded(
            child: ListView.builder(
              itemCount: quotes.length,

              itemBuilder: (context, index) {
                final quote = quotes[index];

                return QuoteCard(
                  quoteData: quote,

                  // CARD CLICK
                  onTap: () {
                    openQuoteDetails(
                      quote,
                    );
                  },

                  // HEART CLICK
                  onFavorite: () {
                    toggleFavorite(
                      index,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// QUOTE CARD
// ============================================================

class QuoteCard extends StatelessWidget {

  final Map<String, dynamic> quoteData;

  final VoidCallback onTap;

  final VoidCallback onFavorite;

  const QuoteCard({
    super.key,
    required this.quoteData,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {

    final String quote =
        quoteData['quote'] ?? '';

    final String movie =
        quoteData['movie'] ?? '';

    final String character =
        quoteData['character'] ?? '';

    final String year =
        quoteData['year'] ?? '';

    final bool isFavorite =
        quoteData['isFavorite'] ?? false;

    return Card(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),

      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(16),

        // ======================================================
        // OPEN DETAILS
        // ======================================================

        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(16),

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

                  // QUOTE ICON
                  Container(
                    width: 42,
                    height: 42,

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(0xFFEDE7F6),
                      borderRadius:
                          BorderRadius.circular(12),
                    ),

                    child: const Icon(
                      Icons.format_quote,
                      color:
                          Color(0xFF4527A0),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // QUOTE
                  Expanded(
                    child: Text(
                      quote,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  // =================================================
                  // HEART
                  // =================================================

                  IconButton(
                    onPressed: onFavorite,

                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,

                      color: isFavorite
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // MOVIE
              InfoRow(
                icon: Icons.movie_outlined,
                text: movie,
              ),

              const SizedBox(height: 8),

              // CHARACTER
              InfoRow(
                icon: Icons.person_outline,
                text: character,
              ),

              const SizedBox(height: 8),

              // YEAR
              InfoRow(
                icon:
                    Icons.calendar_today_outlined,
                text: year,
              ),

              const SizedBox(height: 12),

              // VIEW DETAILS
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: const [
                  Text(
                    'View Details',
                    style: TextStyle(
                      color:
                          Color(0xFF4527A0),
                      fontWeight:
                          FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),

                  SizedBox(width: 4),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 13,
                    color:
                        Color(0xFF4527A0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// INFO ROW
// ============================================================

class InfoRow extends StatelessWidget {

  final IconData icon;

  final String text;

  const InfoRow({
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
          size: 18,
          color: Colors.grey[600],
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}