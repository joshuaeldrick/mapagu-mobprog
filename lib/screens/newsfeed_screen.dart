import 'package:material_ui/material_ui.dart';
import '../widgets/newsfeed_card.dart';

class Post {
  Post({
    required this.authorName,
    required this.date,
    required this.text,
    required this.likes,
    required this.comments,
    this.avatarAsset,
    this.imageAsset,
    this.isLiked = false,
  });

  final String authorName;
  final String date;
  final String text;
  int likes;
  int comments;
  bool isLiked;
  final String? avatarAsset;
  final String? imageAsset;
}

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  final List<Post> _posts = [
    Post(
      authorName: 'Joshua Mapagu',
      date: 'November 22',
      text: 'Kamusta mga idol!',
      likes: 100,
      comments: 42,
      avatarAsset: 'assets/images/avatar_me.png',
      imageAsset: null,
    ),
    Post(
      authorName: 'Clefford M. Canoy',
      date: 'December 2',
      text: 'Kicking off the holiday season! Bagong baby',
      likes: 200,
      comments: 42,
      avatarAsset: 'assets/images/avatar_classmate.png',
      imageAsset: 'assets/images/post_image.jpg',
    ),
  ];

  void _toggleLike(int index) {
    setState(() {
      final post = _posts[index];
      post.isLiked = !post.isLiked;
      post.likes += post.isLiked ? 1 : -1;
    });
  }

  void _addComment(int index) {
    setState(() {
      _posts[index].comments++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return NewsFeedCard(
          authorName: post.authorName,
          date: post.date,
          text: post.text,
          likes: post.likes,
          comments: post.comments,
          isLiked: post.isLiked,
          avatarAsset: post.avatarAsset,
          imageAsset: post.imageAsset,
          onLike: () => _toggleLike(index),
          onComment: () => _addComment(index),
        );
      },
    );
  }
}
