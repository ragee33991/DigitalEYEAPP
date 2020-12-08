List<String> cupertinoWidgetsList = [
  'CupertinoActionSheet',
  'CupertinoActivityIndicator',
  'CupertinoAlertDialog',
  'CuppertinoButton',
  'CupertinoDatePIcker',
  'CupertinoFullScreenDialogTransition',
  'CupertinoNavigationBar, Page Scaffold and PageTransition',
  'CupertinoPicker',
  'CupertinoPopupSurface',
  'CupertinoScrollbar',
  'CupertinoSegmentControl',
  'CupertinoSlider & Switch',
  'CupertinoTabBar, TabView & TabScaffold',
  'CupertinoTextField',
  'CupertinotimePicker',
];

List<String> animationWidgetsList = [
  'AnimatedBuilder',
  'AnimatedContainer',
  'AnimatedCrossFade',
  'AnimatedDefaultTextStyle',
  'AnimatedListState',
  'AnimatedModalBarrier',
  'AnimatedOpacity',
  'AnimatedPhysicalModel',
  'AnimatedPosition',
  'AnimatedSize',
  'AnimatedWidgetBaseState',
  'DecoratedBoxTransition',
  'FadeTransition',
  'Hero',
  'PositionTransition',
  'RotationTransition',
  'ScaleTransition',
  'Size Transition',
  'Slide Transition',
];

List<String> asynchronousWidgetsList = [
  'FutureBuilder',
  'StreamBuilder',
  'Bloc Pattern With Rxdart',
];

List<String> interactionWidgetsList = [
  'AbsorbPointer',
  'Dismissible',
  'Draggable & DragTarget',
  'GestureDetactor',
  'IgnorPoint',
  'LongPressDraggable',
  'Scrollable',
  'Routing',
];

List<String> paintingAndEffect = [
  'BackDropFilter',
  'ClipOval',
  'ClipPath',
  'ClipRect & ClipRRect',
  'CustomPaint',
  'DecoratedBox',
  'FractionalTransition',
  'RotatedBox',
];

List<String> scrollingWidget = [
  'CustomScrollView',
  'NestedScrollView',
  'NotificationListener',
  'PageView',
  'RefreshIndicator',
  'Scrollbar',
  'SingleChildScrollView',
];

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final String platformChannelDefinition =
    'Platform Channels provide a simple mechanism for communicating between your Dart code and the platform-specific code of your host app.';

final String platformChannelDescription =
    'Flutter allows us to call platform-specific APIs available in Java or Kotlin code on Android and in Objective C or Swift code on iOS.';

final String batteryExampleDescription =
    'Using Channel Method On press of below button returns battery level by calling platform specific API.';

final String helloExampleDescription =
    'Using Channel Method On press of below button returns Hello from NativeCode.';

final String toggleString =
    'Here is an implementation that requires mutually exclusive selection ';

final String multipleToggleString =
    'Here is an implementation that allows for multiple buttons to be simultaneously selected, ';

final String reallyLongString =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

final String limitedBoxContent =
    "This is useful when composing widgets that normally try to match their parents' size so that they behave reasonably in lists (which are unbounded).";

const url1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
const url2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
const url3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';

final String notScale =
    'Font size of this text is not change with the change of device font size.';

final String scaleText =
    "If you change the font size from the device's setting this will be also change.";

final String modelBarrier =
    'A widget that prevents the user from interacting with widgets behind itself, and can be configured with an animated color value.';

final String exampleModelBarrier =
    'The modal barrier is the scrim that is rendered behind each route, which generally prevents the user from interacting with the route below the current route, and normally partially obscures such routes. This widget is similar to ModalBarrier except that it takes an animated color instead of a single color.';

final String animatedOpacity =
    "Animated version of Opacity which automatically transitions the child's opacity over a given duration whenever the given opacity changes.";

final String hero =
    'To label a widget as such a feature, wrap it in a Hero widget. When navigation happens, the Hero widgets on each route are identified by the HeroController. For each pair of Hero widgets that have the same tag, a hero animation is triggered.';

final String positionTrans =
    "Animated version of Positioned which takes a specific Animation<RelativeRect> to transition the child's position from a start position to an end position over the lifetime of the animation. Only works if it's the child of a Stack.";

final String scaleTransition =
    "Animates the position of a widget relative to its normal position. The translation is expressed as an Offset scaled to the child's size. For example, an Offset with a dx of 0.25 will result in a horizontal translation of one quarter the width of the child.";

final String iconData =
    "A graphical icon widget drawn with a glyph from a font described in an IconData such as material's predefined IconDatas in Icons.";

final String imageData =
    "Image Class supported: JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, and WBMP image formats";

final String imageUrl =
    "https://images.unsplash.com/photo-1565898835704-3d6be4a2c98c?fit=crop&w=200&q=60";

final String networkImage1 =
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg';

final String networkImage2 =
    'https://dart.academy/content/images/2016/01/4.png';

final String networkImage3 =
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';

final String rawImages =
    'A widget that displays a dart:ui.Image directly. The image is painted using paintImage, which describes the meanings of the various fields on this class in more detail. This widget is rarely used directly. Instead, consider using Image.';

final String placeholder =
    'A widget that draws a box that represents where other widgets will one day be added. This widget is useful during development to indicate that the interface is not yet complete.';

final String inputWidget =
    "An optional container for grouping together multiple form field widgets. Each individual form field should be wrapped in a FormField widget, with the Form widget as a common ancestor of all of those. Call methods on FormState to save, reset, or validate each FormField that is a descendant of this Form. To obtain the FormState, you may use Form.of with a context whose ancestor is the Form, or pass a GlobalKey to the Form constructor and call GlobalKey.currentState.";

final String absorbPointerDef =
    "A widget that absorbs pointers during hit testing.";

final String absorbPointerDes =
    "When absorbing is true, this widget prevents its subtree from receiving pointer events by terminating hit testing at itself. It still consumes space during layout and paints its child as usual. It just prevents its children from being the target of located events, because it returns true from RenderBox.hitTest.";

final String gestureDet =
    "A widget that detects gestures. Attempts to recognize gestures that correspond to its non-null callbacks. If this widget has a child, it defers to that child for its sizing behavior. If it does not have a child, it grows to fit the parent instead.";

final String gestureDefault =
    "By default a GestureDetector with an invisible child ignores touches; this behavior can be controlled with behavior.";

final String difIgnorPoint =
    "If there is a widget beneath your main widget which is also capable of receiving click events, and you use IgnorePointer on the parent widget, the child widget would still receive the click events.";

final String difAbsorbPoint =
    "But using AbsorbPointer on main widget won't allow the other widget (beneath main widget) to receive their click events.";

final String navigateDef =
    "A widget that manages a set of child widgets with a stack discipline. Mobile apps typically reveal their contents via full-screen elements called 'screens' or 'pages'. In Flutter these elements are called routes and they're managed by a Navigator widget.";

final String alignDef =
    "A widget that aligns its child within itself and optionally sizes itself based on the child's size.";

final String baselineDef =
    "A widget that positions its child according to the child's baseline.";

final String constrainedBox =
    "The actual height and width of below container is 150pixel but with the constrainedbox maxHeight and width is 100";

final String containerDef =
    "A convenience widget that combines common painting, positioning, and sizing widgets.";

final String expandedDef =
    "A widget that expands a child of a Row, Column, or Flex so that the child fills the available space.";

final String fittedBoxDef =
    "Scales and positions its child within itself according to fit.";

final String fractionalFittedBox =
    "A widget that sizes its child to a fraction of the total available space";

final String intrinsicHeightWidth =
    "A widget that sizes its child to the child's intrinsic height & width. This class is useful, for example, when unlimited height is available and you would like a child that would otherwise attempt to expand infinitely to instead size itself to a more reasonable height.";

final String intrinsicDef =
    "IntrinsicHeight gives to widgets to be as tall/wide as the tallest/widest inside widgets of column/row";

final String offstageDef =
    "A widget that lays the child out as if it was in the tree, but without painting anything, without making the child available for hit testing, and without taking any room in the parent.";

final String offstageDes =
    "If we wrapped below container in Offstage widget then Offstage widget doesn't paint it's child, hit testing also doesn't taking any room in parent";

final String overflowBox =
    "A widget that imposes different constraints on its child than it gets from its parent, possibly allowing the child to overflow the parent.";

final String paddingDef =
    "A widget that insets its child by the given padding. It's effectively creating empty space around the child.";

final String paddingDes =
    "If we give padding to below card widget then it's create empty space around Text widget";

final String sizedOverflowBox =
    "A widget that is a specific size but passes its original constraints through to its child, which may then overflow.";

final String transform =
    "A widget that applies a transformation before painting its child.";

final String flow =
    "A widget that sizes and positions children efficiently, according to the logic in a FlowDelegate.";

final String layoutBuilder =
    "Builds a widget tree that can depend on the parent widget's size.";

final String listView =
    "ListView is the most commonly used scrolling widget. It displays its children one after another in the scroll direction. In the cross axis, the children are required to fill the ListView.";

final String listViewBuild =
    "Using ListView.builder. It's Build with on demand children are built lazily and can be infinite in number.";

final String listViewSeparate =
    "Creating a similar list using ListView.separated. Here, a Divider is used as a separator.";

final String longString =
    'Flutter\'s hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android.';

final String backdropFilter =
    "A widget that applies a filter to the existing painted content and then paints child.";

final String backdropFilterDef =
    "The filter will be applied to all the area within its parent or ancestor widget's clip. If there's no clip, the filter will be applied to the full screen. In below example flutter logo is blured using BackdropFilter.";

final String clipOval = "A widget that clips its child using an oval.";

final String clipPath = "A widget that clips its child using a path.";

final String clipRect = "A widget that clips its child using a rectangle.";

final String clipRRect =
    "A widget that clips its child using a rounded rectangle. You can round any corner of rectangle.";

final String customPaint =
    "A widget that provides a canvas on which to draw during the paint phase.";

final String decoratedBox =
    "A widget that paints a Decoration either before or after its child paints.";

final String fractionalTranslation =
    "Applies a translation transformation before painting its child.";

final String rotatedBox =
    "A widget that rotates its child by a integral number of quarter turns.";

final String notificationListener =
    "A widget that listens for Notifications bubbling up the tree. Notifications will trigger the onNotification callback only if their runtimeType is a subtype of T.";

final String notificationListDef =
    "On press of below raised button it's notify the Text Widget using NotificationListener";

final String pageView = "A scrollable list that works page by page.";

final String refreshIndicator =
    "A widget that supports the Material 'Swipe To Refresh' idiom.";

final String refreshIndicatorEx =
    "Below List View is with refreshIndicator You can perform this action by pull to refresh.";

final String scrollbar =
    "A material design scrollbar. It's indicates which portion of a Scrollable widget is actually visible.";

final String singleChildScrollView =
    "A box in which a single widget can be scrolled. This widget is useful when you have a single box that will normally be entirely visible.";

final String singleChildScrollDef =
    "In this screen all the content is wrapped in singlechildscrollview with the help of this widget you can scroll page to view entire screen content.";
