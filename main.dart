import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'image_picker_screen.dart';
import 'text_hider_screen.dart' as textHider;
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'services_screen.dart';
import 'favorites_screen.dart' as favorites;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.purple,
        fontFamily: 'Cairo',
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.black,
          contentTextStyle: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
          actionTextColor: Colors.purple,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.purple,
        fontFamily: 'Cairo',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.white,
          contentTextStyle: TextStyle(color: Colors.black, fontFamily: 'Cairo'),
          actionTextColor: Colors.purple,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  bool _isServicesSelected = false;

  void _onItemTapped(int index) {
    setState(() {
      _isServicesSelected = (index == 3);
    });
    if (FeedbackType.values.isNotEmpty) {
      Vibrate.feedback(FeedbackType.light);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    final List<PersistentTabConfig> tabs = [
      PersistentTabConfig(
        screen: const ProfileScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.person),
          title: "الملف الشخصي",
          activeForegroundColor: primaryColor,
          inactiveForegroundColor: const Color(0xFFB0BEC5),
        ),
      ),
      PersistentTabConfig(
        screen: const NotificationsScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.notifications),
          title: "الإشعارات",
          activeForegroundColor: primaryColor,
          inactiveForegroundColor: const Color(0xFFB0BEC5),
        ),
      ),
      PersistentTabConfig(
        screen: const HomeScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.home),
          title: "الرئيسية",
          activeForegroundColor: Colors.white,
          inactiveForegroundColor: const Color(0xFFB0BEC5),
        ),
      ),
      PersistentTabConfig(
        screen: const ServicesScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.apps),
          title: "الخدمات",
          activeForegroundColor: primaryColor,
          inactiveForegroundColor: const Color(0xFFB0BEC5),
        ),
      ),
      PersistentTabConfig(
        screen: const favorites.FavoritesScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.favorite),
          title: "المفضلة",
          activeForegroundColor: primaryColor,
          inactiveForegroundColor: const Color(0xFFB0BEC5),
        ),
      ),
    ];

    return PersistentTabView(
      tabs: tabs,
      navBarBuilder: (navBarConfig) => Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(navBarConfig.items.length, (index) {
                  final item = navBarConfig.items[index];
                  final isSelected = navBarConfig.selectedIndex == index;
                  if (index == 2) {
                    return const SizedBox(width: 60);
                  }
                  return GestureDetector(
                    onTap: () => navBarConfig.onItemSelected(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            (item.icon as Icon).icon,
                            color: isDarkMode
                                ? (isSelected ? Colors.white : Colors.white70)
                                : (isSelected ? Colors.white : const Color(0xFFB0BEC5)),
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.title!,
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white
                                  : (isSelected ? Colors.white : const Color(0xFFB0BEC5)),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Transform.translate(
                offset: const Offset(0, -20),
                child: GestureDetector(
                  onTap: () => navBarConfig.onItemSelected(2),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: navBarConfig.selectedIndex == 2 ? Colors.purple : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (navBarConfig.items[2].icon as Icon).icon,
                          color: isDarkMode
                              ? (navBarConfig.selectedIndex == 2 ? Colors.white : Colors.white70)
                              : (navBarConfig.selectedIndex == 2 ? Colors.white : const Color(0xFFB0BEC5)),
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          navBarConfig.items[2].title!,
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white
                                : (navBarConfig.selectedIndex == 2 ? Colors.white : const Color(0xFFB0BEC5)),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      popAllScreensOnTapAnyTabs: true,
      popActionScreens: PopActionScreensType.all,
      onTabChanged: _onItemTapped,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onItemTapped(BuildContext context) {
    if (FeedbackType.values.isNotEmpty) {
      Vibrate.feedback(FeedbackType.light);
    }
  }

  Future<void> _addToFavorites(String serviceName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    if (!favorites.contains(serviceName)) {
      favorites.add(serviceName);
      await prefs.setStringList('favorites', favorites);
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
                  'مرحبًا بك!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'الخدمات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 2, // عرض الخدمات في عمودين
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2, // ضبط نسبة العرض إلى الارتفاع
                children: [
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
                    () => _addToFavorites('رفع الصور'),
                  ),
                  _buildServiceItem(
                    context,
                    'إخفاء النصوص',
                    'تشفير وفك تشفير النصوص',
                    Icons.lock,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const textHider.TextHiderScreen()),
                      );
                    },
                    () => _addToFavorites('إخفاء النصوص'),
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
                    () => _addToFavorites('تشفير الملفات'),
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
                    () => _addToFavorites('مشاركة الموقع'),
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
                    () => _addToFavorites('الدردشة المشفرة'),
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
                    () => _addToFavorites('إدارة المهام'),
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
                    () => _addToFavorites('تحويل العملات'),
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
                    () => _addToFavorites('مذكرات صوتية'),
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
                    () => _addToFavorites('مشاركة الملفات'),
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
                    () => _addToFavorites('الطقس'),
                  ),
                ],
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
    VoidCallback onAddToFavorites,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTap: () {
          _onItemTapped(context);
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.all(12),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2), // الجزء البنفسجي
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 24,
                      color: isDarkMode ? Colors.white : Colors.purple, // الأيقونة بيضاء في الوضع الداكن
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border, size: 20),
                    color: isDarkMode ? Colors.white : Colors.black54,
                    onPressed: () {
                      onAddToFavorites();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$title تمت إضافته إلى المفضلة')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // تقليل حجم النص
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12, // تقليل حجم النص
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}