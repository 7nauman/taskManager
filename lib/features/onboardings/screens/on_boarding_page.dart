import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/onboardings/widgets/on_boarding_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onBoardingData = [
    {
      'image': 'assets/images/onboard1.png',
      'title': 'Welcome to Smart Task Manager',
      'description': 'Manage your tasks efficiently and effectively.'
    },
    {
      'image': 'assets/images/onboard2.png',
      'title': 'Stay Organized',
      'description': 'Keep track of your tasks and deadlines with ease.'
    },
    {
      'image': 'assets/images/onboard3.png',
      'title': 'Boost Your Productivity',
      'description': 'Get more done in less time with our smart features.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onBoardingData.length,
            itemBuilder: (context, index) {
              final item = _onBoardingData[index];
              return OnBoardingScreen(
                  imageAsset: item['image']!,
                  title: item['title']!,
                  description: item['description']!);
            },
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onBoardingData.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: _currentPage == index ? 20 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_currentPage == _onBoardingData.length - 1) {
                      //final prefs = await SharedPreferences.getInstance();
                      //await prefs.setBool('seenOnboarding', true);
                      Navigator.pushReplacementNamed(context, '/auth_options');
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    _currentPage == _onBoardingData.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
