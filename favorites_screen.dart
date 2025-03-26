import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animate_do/animate_do.dart';
import '../image_picker_screen.dart';
import '../text_hider_screen.dart' as textHider;

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  void _navigateToService(String serviceName) {
    switch (serviceName) {
      case 'رفع الصور':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ImagePickerScreen()),
        );
        break;
      case 'إخفاء النصوص':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const textHider.TextHiderScreen()),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('قيد التطوير')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // خفض العنوان
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'المفضلة',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _favorites.isEmpty
                  ? FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        'لا توجد خدمات مفضلة حاليًا',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    )
                  : Column(
                      children: _favorites.map((favorite) {
                        return FadeInUp(
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: () => _navigateToService(favorite),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                                foregroundColor: isDarkMode ? Colors.white : Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.all(16),
                                elevation: 2,
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.favorite, color: Colors.red),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      favorite,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isDarkMode ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}