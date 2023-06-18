// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PickImage extends StatelessWidget {
  final Widget? child;
  final void Function()? onCamera;
  final void Function()? onGallery;
  final double radius;
  final String? imgUrl;
  final bool isEdit;
  const PickImage({
    Key? key,
    this.child,
    this.onCamera,
    this.onGallery,
    required this.radius,
    this.imgUrl,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: (radius + 1),
          backgroundColor: Colors.grey,
          backgroundImage:
              NetworkImage(imgUrl ?? "https://tinyurl.com/default-fic"),
          child: isEdit
              ? const SizedBox()
              : ClipOval(
                  child: SizedBox(
                    width: (radius * 2),
                    height: (radius * 2),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: child,
                    ),
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iconButton(
              onTap: onCamera,
              icon: Icons.camera_alt,
            ),
            _iconButton(
              onTap: onGallery,
              icon: Icons.photo_library,
            ),
          ],
        ),
      ],
    );
  }

  _iconButton({
    required final void Function()? onTap,
    required final IconData icon,
  }) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 20,
      ),
    );
  }
}
