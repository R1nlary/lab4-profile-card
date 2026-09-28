// LAB4 — Interactive Like & Follower Profile Card
//
// A single-screen Flutter app that shows a profile card with:
//   * a Follow / Following toggle button
//   * a Like button with a counter (+1 / -1)
//   * a Reset button that restores the default state
// All state changes go through setState().

import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  // ---- Default values, used by the Reset button ----------------------
  static const bool _defaultIsFollowing = false;
  static const bool _defaultIsLiked = false;
  static const bool _defaultIsDisliked = false;
  static const int _defaultLikeCount = 128;
  static const int _defaultDislikeCount = 3;

  // ---- Current state ---------------------------------------------------
  bool isFollowing = _defaultIsFollowing;
  bool isLiked = _defaultIsLiked;
  bool isDisliked = _defaultIsDisliked;
  int likeCount = _defaultLikeCount;
  int dislikeCount = _defaultDislikeCount;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  void toggleLike() {
    setState(() {
      // Liking cancels an existing dislike first, like on YouTube.
      if (!isLiked && isDisliked) {
        isDisliked = false;
        dislikeCount--;
      }

      isLiked = !isLiked;
      // Liking adds +1, unliking removes it again (-1).
      likeCount = isLiked ? likeCount + 1 : likeCount - 1;
    });
  }

  void toggleDislike() {
    setState(() {
      // Disliking cancels an existing like first.
      if (!isDisliked && isLiked) {
        isLiked = false;
        likeCount--;
      }

      isDisliked = !isDisliked;
      dislikeCount = isDisliked ? dislikeCount + 1 : dislikeCount - 1;
    });
  }

  void resetProfile() {
    setState(() {
      isFollowing = _defaultIsFollowing;
      isLiked = _defaultIsLiked;
      isDisliked = _defaultIsDisliked;
      likeCount = _defaultLikeCount;
      dislikeCount = _defaultDislikeCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Card')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.person, size: 56, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bekzat Nurlanov',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Flutter developer • Almaty',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  // ---- Follow / Following toggle ------------------------
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: toggleFollow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFollowing
                            ? Colors.grey.shade300
                            : Colors.deepPurple,
                        foregroundColor: isFollowing
                            ? Colors.black87
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(isFollowing ? 'Following' : 'Follow'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ---- Like / Dislike buttons + counters ----------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: toggleLike,
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                      ),
                      Text('$likeCount', style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: toggleDislike,
                        icon: Icon(
                          isDisliked
                              ? Icons.thumb_down
                              : Icons.thumb_down_outlined,
                          color: isDisliked ? Colors.blueGrey : Colors.grey,
                        ),
                      ),
                      Text(
                        '$dislikeCount',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // ---- Reset ---------------------------------------------
                  TextButton.icon(
                    onPressed: resetProfile,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
