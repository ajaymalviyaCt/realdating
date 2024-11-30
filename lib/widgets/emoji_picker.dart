import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:realdating/widgets/size_utils.dart';

class EmojiPickerWidget extends StatelessWidget {
  const EmojiPickerWidget({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  // final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (p0, isKeyboardVisible) {
        // if (isKeyboardVisible) {
        //   return Container();
        // }

        return Container(
          margin: EdgeInsets.only(top: 10.h),
          child: EmojiPicker(
            textEditingController: textEditingController,
            // scrollController: scrollController,
            config: const Config(
              height: 256,
              checkPlatformCompatibility: true,
              // emojiViewConfig: EmojiViewConfig(
              //   // Issue: https://github.com/flutter/flutter/issues/28894
              //   emojiSizeMax: 28 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.2 : 1.0),
              // ),

              // swapCategoryAndBottomBar: false,
              skinToneConfig: SkinToneConfig(dialogBackgroundColor: Colors.red),
              categoryViewConfig: CategoryViewConfig(),
              bottomActionBarConfig: BottomActionBarConfig(enabled: false),
              searchViewConfig: SearchViewConfig(),
            ),
          ),
        );
      },
    );
  }
}
