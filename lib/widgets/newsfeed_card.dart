import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'custom_text.dart';

class NewsFeedCard extends StatelessWidget {
  const NewsFeedCard({
    super.key,
    required this.authorName,
    required this.date,
    required this.text,
    required this.likes,
    required this.onLike,
    this.isLiked = false,
    this.avatarAsset,
    this.imageAsset,
  });

  final String authorName;
  final String date;
  final String text;
  final int likes;
  final bool isLiked;
  final String? avatarAsset;
  final String? imageAsset;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _Avatar(assetPath: avatarAsset),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: authorName, fontWeight: FontWeight.bold),
                    CustomText(text: date, fontSize: 13, color: AppColors.grey),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz, color: AppColors.grey),
              ],
            ),
            SizedBox(height: 10.h),
            CustomText(text: text),
            SizedBox(height: 10.h),
            if (imageAsset != null) ...[
              _PostImage(assetPath: imageAsset!),
              SizedBox(height: 10.h),
            ],
            Row(
              children: [
                Icon(Icons.thumb_up, color: AppColors.facebookBlue, size: 18.r),
                SizedBox(width: 4.w),
                CustomText(text: '$likes'),
                const Spacer(),
                const CustomText(
                  text: '42 Comments   5 Shares',
                  fontSize: 13,
                  color: AppColors.grey,
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    label: 'Like',
                    color: isLiked ? AppColors.facebookBlue : AppColors.grey,
                    onTap: onLike,
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.comment_outlined,
                    label: 'Comment',
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: const CustomText(
                text: 'Write a comment...',
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.assetPath});

  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    if (assetPath == null) {
      return CircleAvatar(
        radius: 20.r,
        backgroundColor: AppColors.lightGrey,
        child: const Icon(Icons.person, color: AppColors.grey),
      );
    }
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: AppColors.lightGrey,
      backgroundImage: AssetImage(assetPath!),
      onBackgroundImageError: (error, stackTrace) {},
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Image.asset(
        assetPath,
        width: double.infinity,
        height: 200.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 200.h,
            color: AppColors.lightGrey,
            alignment: Alignment.center,
            child: const CustomText(text: 'Post image', color: AppColors.grey),
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = AppColors.grey,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20.r),
            SizedBox(width: 6.w),
            CustomText(text: label, color: color, fontSize: 14),
          ],
        ),
      ),
    );
  }
}
