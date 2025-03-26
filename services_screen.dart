import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'image_picker_screen.dart';
import 'text_hider_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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

  Future<void> _toggleFavorite(String serviceTitle) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favorites.contains(serviceTitle)) {
        _favorites.remove(serviceTitle);
      } else {
        _favorites.add(serviceTitle);
      }
    });
    await prefs.setStringList('favorites', _favorites);
  }

  void _onItemTapped(BuildContext context) {
    if (FeedbackType.values.isNotEmpty) {
      Vibrate.feedback(FeedbackType.light);
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
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'الخدمات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildServiceItem(
                context,
                'رفع الصور',
                'رفع الصور بسهولة وسرعة',
                Icons.upload_rounded,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ImagePickerScreen()),
                  );
                },
              ),
              _buildServiceItem(
                context,
                'إخفاء النصوص',
                'تشفير وفك تشفير النصوص',
                Icons.lock,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TextHiderScreen()),
                  );
                },
              ),
              _buildServiceItem(
                context,
                'تشفير الملفات',
                'تشفير وفك تشفير الملفات بأمان',
                Icons.security,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('قيد التطوير')),
                  );
                },
              ),
              _buildServiceItem(
                context,
                'مشاركة الموقع',
                'مشاركة موقعك مع الأصدقاء',
                Icons.location_on,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('قيد التطوير')),
                  );
                },
              ),
              _buildServiceItem(
                context,
                'الدردشة المشفرة',
                'إرسال رسائل مشفرة',
                Icons.chat,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('قيد التطوير')),
                  );
                },
              ),
              _buildServiceItem(
                context,
                'إدارة المهام',
                'تنظيم المهام اليومية',
                Icons.task,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('قيد التطوير')),
                  );
                },
              ),
              _buildServiceItem(
                context,
                'تحويل العملات',
                'تحويل العملات بأسعار محدثة',
                Icons.currency_exchange,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('قيد التطوير')),
                  );
                },
              ),
              _buildServiceItem(
                context,
                'مذكرات صوتية',
                'تسجيل ومشاركة مذكرات صوتية',
                Icons.mic,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('قيد التطوير')),
                  );
                },
              ),
              _buildServiceItem(
                context,
                'مشاركة الملفات',
                'مشاركة الملفات بسرعة وأمان',
                Icons.share,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('قيد التطوير')),
                  );
                },
              ),
              _buildServiceItem(
                context,
                'الطقس',
                'معرفة حالة الطقس في منطقتك',
                Icons.wb_sunny,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('قيد التطوير')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isFavorite = _favorites.contains(title);

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () {
          _onItemTapped(context);
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 24,
                  color: isFavorite ? Colors.red : Theme.of(context).primaryColor,
                ),
                onPressed: () => _toggleFavorite(title),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}