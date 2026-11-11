import 'package:flutter/material.dart';

void main() => runApp(const FacebookTaskApp());

class FacebookTaskApp extends StatelessWidget {
  const FacebookTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1877F2)),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  final List<bool> liked = [false, false, false];

  final posts = const [
    PostData(
      name: 'Ahmed Samir',
      time: '2 hrs',
      initials: 'AS',
      color: Color(0xFF5B8DEF),
      text: 'A beautiful day starts with a positive mindset. Keep moving forward! ✨',
      likes: '248',
      comments: '32 comments',
      imageColor: Color(0xFFDCEBFF),
      imageIcon: Icons.landscape_rounded,
      imageLabel: 'Explore • Dream • Discover',
    ),
    PostData(
      name: 'Mariam Hassan',
      time: '4 hrs',
      initials: 'MH',
      color: Color(0xFFE58B9B),
      text: 'Coffee, good music, and a little time for myself ☕',
      likes: '96',
      comments: '14 comments',
      imageColor: Color(0xFFF7E5DC),
      imageIcon: Icons.coffee_rounded,
      imageLabel: 'SLOW DOWN & ENJOY',
    ),
    PostData(
      name: 'Omar Khaled',
      time: 'Yesterday',
      initials: 'OK',
      color: Color(0xFF45A58B),
      text: 'Weekend memories with the best people ❤️',
      likes: '512',
      comments: '67 comments',
      imageColor: Color(0xFFDDF2E9),
      imageIcon: Icons.groups_rounded,
      imageLabel: 'GOOD TIMES',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'facebook',
          style: TextStyle(
            color: Color(0xFF1877F2),
            fontSize: 29,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.2,
          ),
        ),
        actions: [
          _roundAction(Icons.add, () => _message('Create a post')),
          _roundAction(Icons.search, () => _message('Search')),
          _roundAction(Icons.chat_bubble, () => _message('Messenger')),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: selectedTab,
        children: [
          _feed(),
          _placeholderTab(
            Icons.people_alt_rounded,
            'Friends',
            'Connect with people you know.',
          ),
          _placeholderTab(
            Icons.ondemand_video_rounded,
            'Watch',
            'Videos picked for you.',
          ),
          _placeholderTab(
            Icons.notifications_rounded,
            'Notifications',
            'You’re all caught up!',
          ),
          _placeholderTab(
            Icons.menu_rounded,
            'Menu',
            'Your shortcuts and settings.',
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 66,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE7F0FF),
        selectedIndex: selectedTab,
        onDestinationSelected: (value) => setState(() => selectedTab = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Friends',
          ),
          NavigationDestination(
            icon: Icon(Icons.ondemand_video_outlined),
            selectedIcon: Icon(Icons.ondemand_video),
            label: 'Watch',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu),
            selectedIcon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
    );
  }

  Widget _feed() {
    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 21,
                    backgroundColor: Color(0xFF1877F2),
                    child: Text(
                      'Y',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => _message('What’s on your mind?'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFDADDE1)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          "What's on your mind?",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.photo_library_outlined,
                    color: Color(0xFF45BD62),
                    size: 27,
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _QuickAction(Icons.video_call, 'Live', Color(0xFFF3425F)),
                  _QuickAction(Icons.photo_library, 'Photo', Color(0xFF45BD62)),
                  _QuickAction(
                    Icons.video_camera_front,
                    'Room',
                    Color(0xFF9360D5),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 9),
        _stories(),
        const SizedBox(height: 9),
        ...List.generate(posts.length, (index) => _post(posts[index], index)),
      ],
    );
  }

  Widget _stories() {
    final stories = [
      ('Your story', 'Y', const Color(0xFF1877F2)),
      ('Nour', 'N', const Color(0xFFE58B9B)),
      ('Karim', 'K', const Color(0xFF45A58B)),
      ('Salma', 'S', const Color(0xFF9A7AD7)),
      ('Mostafa', 'M', const Color(0xFFE3A34D)),
    ];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: SizedBox(
        height: 154,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 9),
          itemBuilder: (context, index) {
            final item = stories[index];
            return Container(
              width: 102,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [item.$3.withOpacity(.75), item.$3.withOpacity(.28)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: item.$3,
                        child: Text(
                          item.$2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (index == 0)
                    const Positioned(
                      top: 65,
                      left: 35,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xFF1877F2),
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  Positioned(
                    left: 9,
                    bottom: 9,
                    right: 6,
                    child: Text(
                      item.$1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _post(PostData post, int index) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.only(top: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: post.color,
                  child: Text(
                    post.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${post.time} · 🌐',
                        style: const TextStyle(
                          color: Color(0xFF65676B),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _message('More post options'),
                  icon: const Icon(Icons.more_horiz, color: Color(0xFF65676B)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 7, 14, 12),
            child: Text(
              post.text,
              style: const TextStyle(fontSize: 14.5, height: 1.35),
            ),
          ),
          Container(
            height: 190,
            width: double.infinity,
            color: post.imageColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(post.imageIcon, size: 65, color: const Color(0xFF54799F)),
                const SizedBox(height: 10),
                Text(
                  post.imageLabel,
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF54799F),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
            child: Row(
              children: [
                const Icon(Icons.thumb_up, size: 17, color: Color(0xFF1877F2)),
                const SizedBox(width: 5),
                Text(
                  liked[index] ? '${post.likes} + 1' : post.likes,
                  style: const TextStyle(
                    color: Color(0xFF65676B),
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Text(
                  post.comments,
                  style: const TextStyle(
                    color: Color(0xFF65676B),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, indent: 14, endIndent: 14),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: _PostButton(
                    icon: liked[index]
                        ? Icons.thumb_up
                        : Icons.thumb_up_outlined,
                    label: 'Like',
                    active: liked[index],
                    onTap: () => setState(() => liked[index] = !liked[index]),
                  ),
                ),
                Expanded(
                  child: _PostButton(
                    icon: Icons.mode_comment_outlined,
                    label: 'Comment',
                    onTap: () => _message('Write a comment'),
                  ),
                ),
                Expanded(
                  child: _PostButton(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: () => _message('Share post'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderTab(IconData icon, String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 58, color: const Color(0xFF1877F2)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Color(0xFF65676B))),
        ],
      ),
    );
  }

  Widget _roundAction(IconData icon, VoidCallback action) => Padding(
    padding: const EdgeInsets.only(left: 5),
    child: CircleAvatar(
      backgroundColor: const Color(0xFFF0F2F5),
      radius: 19,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: action,
        icon: Icon(icon, size: 21, color: Colors.black87),
      ),
    ),
  );

  void _message(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(value), duration: const Duration(seconds: 1)),
    );
  }
}

class PostData {
  final String name, time, initials, text, likes, comments, imageLabel;
  final Color color, imageColor;
  final IconData imageIcon;
  const PostData({
    required this.name,
    required this.time,
    required this.initials,
    required this.color,
    required this.text,
    required this.likes,
    required this.comments,
    required this.imageColor,
    required this.imageIcon,
    required this.imageLabel,
  });
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _QuickAction(this.icon, this.label, this.color);
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: color, size: 22),
      const SizedBox(width: 5),
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF65676B),
        ),
      ),
    ],
  );
}

class _PostButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _PostButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });
  @override
  Widget build(BuildContext context) => TextButton.icon(
    onPressed: onTap,
    icon: Icon(
      icon,
      size: 19,
      color: active ? const Color(0xFF1877F2) : const Color(0xFF65676B),
    ),
    label: Text(
      label,
      style: TextStyle(
        color: active ? const Color(0xFF1877F2) : const Color(0xFF65676B),
        fontWeight: FontWeight.w600,
      ),
    ),
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 10),
    ),
  );
}
