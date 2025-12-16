import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gen_ai/providers/crypto_provider.dart';
import 'package:gen_ai/screens/news_screen.dart';
import 'home_screen.dart';
import 'chat_screen.dart';
import 'social_screen.dart';
import 'profile_screen.dart';
import '../models/crypto_coin.dart';
import '../providers/chat_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;

  void _handleAIAnalysis(CryptoCoin coin) {
    ref.read(cryptoProvider.notifier).updateSelectedCoin(coin);

    // Switch to chat screen (now at index 3)
    setState(() {
      _currentIndex = 3;
    });

    // Send the crypto analysis prompt to AI (hidden full prompt)
    Future.delayed(const Duration(milliseconds: 300), () {
      final displayMessage = 'Analyze ${coin.name} (${coin.symbol})';
      final fullPrompt = coin.toAIAnalysisPrompt();

      ref
          .read(chatProvider.notifier)
          .sendHiddenMessageWithStream(fullPrompt, displayMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(onAIAnalysis: _handleAIAnalysis),
          const NewsScreen(),
          const SocialScreen(),
          const ChatScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.currency_bitcoin),
            selectedIcon: Icon(Icons.currency_bitcoin),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper),
            selectedIcon: Icon(Icons.newspaper),
            label: 'News',
          ),
          NavigationDestination(
            icon: Icon(Icons.forum_outlined),
            selectedIcon: Icon(Icons.forum),
            label: 'Feed',
          ),

          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'AI Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
