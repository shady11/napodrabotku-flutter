import 'package:flutter/material.dart';
import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/utils/constants.dart';
import 'package:swipe_stack/swipe_stack.dart';

import 'cicle_button.dart';
import 'its_match_dialog.dart';

class SwipeButtons extends StatelessWidget {
  // Variables
  final GlobalKey<SwipeStackState> swipeKey;

  SwipeButtons({@required this.swipeKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Rewind profiles
        GestureDetector(
          child: CircleButton(
              bgColor: kColorPrimary,
              padding: 8,
              icon: Icon(Icons.restore, size: 22, color: Colors.grey)),
          onTap: () {
            swipeKey.currentState.rewind();
          },
        ),

        SizedBox(width: 20),

        /// Swipe left and reject user
        GestureDetector(
          child: CircleButton(
              bgColor: kColorPrimary,
              padding: 8,
              icon: Icon(Icons.close, size: 35, color: Colors.grey)),
          onTap: () {
            /// Swipe left
            swipeKey.currentState.swipeLeft();
          },
        ),

        SizedBox(width: 20),

        /// Swipe right and like user
        GestureDetector(
          child: CircleButton(
              bgColor: kColorPrimary,
              padding: 8,
              icon: Icon(Icons.favorite_border,
                  size: 35, color: Theme.of(context).primaryColor)),
          onTap: () {

            /// Get card current index
            final cardIndex = swipeKey.currentState.currentIndex;

            /// Get User object
            final User user = getDemoUsers()[cardIndex];

             /// *** DEMO ***
            /// Show it's match dialog if index == 5 (for first user only)
            if (cardIndex == 5) {
                // It`s match - show dialog to ask user to chat or continue playing
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return ItsMatchDialog(
                      swipeKey: swipeKey,
                      matchedUser: user,
                      //swipeKey: swipeKey,
                    );
                  }
                );
            } else {
              /// Swipe right
              swipeKey.currentState.swipeRight();
            }

          },
        ),

        SizedBox(width: 20),

        /// Go to user profile
        GestureDetector(
          child: CircleButton(
              bgColor: kColorPrimary,
              padding: 8,
              icon: Icon(Icons.remove_red_eye, size: 22, color: Colors.grey)),
          onTap: () {
            // Debug
            print(swipeKey.currentState.currentIndex);

            /// Get card current index
            final cardIndex = swipeKey.currentState.currentIndex;

            /// Get User object
            final User user = getDemoUsers()[cardIndex];

            /// Visit profile
            /// Go to profile screen
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileScreen()));
          },
        ),
      ],
    );
  }
}
