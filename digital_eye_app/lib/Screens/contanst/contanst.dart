import 'dart:ui';

import 'package:digital_eye_app/Screens/Notifications/store/AppState.dart';
import 'package:redux/src/store.dart';

class R {
  static final image = _Images();
  static final color = _Color();
}

class _Images {
  final ic_appoitment = 'assets/images/ic_appoitment.svg';
  final ic_doctor = 'assets/images/ic_doctor.svg';
  final ic_drugs = 'assets/images/ic_drugs.svg';
  final btn_back_intro = 'assets/images/btn_back_intro.svg';
  final btn_next_intro = 'assets/images/btn_next_intro.svg';
  final ic_password = 'assets/images/ic_password.svg';
  final ic_forgot_pass = 'assets/images/ic_forgot_pass.svg';
  final ic_user = 'Assets/images/ic_user.svg';
  final ic_back_grey = 'Assets/images/ic_back_grey.svg';
  final ic_email = 'assets/images/ic_email.svg';
  final ic_edit_white = 'assets/images/ic_edit_white.svg';
  final ic_mail = 'assets/images/ic_mail.svg';
  final ic_menu_white = 'assets/images/ic_menu_white.svg';
  final ic_notification = 'assets/images/ic_notification.svg';
  final ic_search = 'assets/images/ic_search.svg';
  final ic_setting = 'assets/images/ic_setting.svg';
  final logo_healer = 'assets/images/logo_healer.svg';
  final avatar = 'assets/images/avatar.png';
  final ic_appointment_white = 'assets/images/ic_appointment_white.svg';
  final ic_doctor_white = 'assets/images/ic_doctor_white.svg';
  final ic_hospital_white = 'assets/images/ic_hospital_white.svg';
  final ic_price_services = 'assets/images/ic_price_services.svg';
  final ic_tabbar_dashboard_blue = 'assets/images/ic_tabbar_dashboard_blue.svg';
  final ic_tabbar_doctors_blue = 'assets/images/ic_tabbar_doctors_blue.svg';
  final ic_tabbar_drugs_blue = 'assets/images/ic_tabbar_drugs_blue.svg';
  final ic_tabbar_profile_blue = 'assets/images/ic_tabbar_profile_blue.svg';
  final ic_tabbar_dashboard_grey = 'assets/images/ic_tabbar_dashboard_grey.svg';
  final ic_tabbar_doctors_grey = 'assets/images/ic_tabbar_doctors_grey.svg';
  final ic_tabbar_drugs_grey = 'assets/images/ic_tabbar_drugs_grey.svg';
  final ic_tabbar_profile_grey = 'assets/images/ic_tabbar_profile_grey.svg';
  final ic_tabbar_services_white = 'assets/images/ic_tabbar_services_white.svg';
  final ic_tabbar_services_grey = 'assets/images/ic_tabbar_services_grey.svg';
  final ic_back_white = 'assets/images/ic_back_white.svg';
  final ic_location = 'assets/images/ic_location.svg';
  final ic_star_blue = 'assets/images/ic_star_blue.svg';
  final ic_more = 'assets/images/ic_more.svg';
  final rectangle = 'assets/images/rectangle.png';
  final ic_calendar_black = 'assets/images/ic_calendar_black.svg';
  final ic_clock_black = 'assets/images/ic_clock_black.svg';
  final ic_notify_drugs = 'assets/images/ic_notify_drugs.svg';
  final ic_notify_list = 'assets/images/ic_notify_list.svg';
  final ic_send_mss = 'assets/images/ic_send_mss.svg';
  final ic_add_grey = 'assets/images/ic_add_grey.svg';
  final ic_chat_white = 'assets/images/ic_chat_white.svg';
  final ic_clipboard_grey = 'assets/images/ic_clipboard_grey.svg';
  final ic_exit_white = 'assets/images/ic_exit_white.svg';
  final ic_phone_call_grey = 'assets/images/ic_phone_call_grey.svg';
  final ic_call_doctor = 'assets/images/ic_call_doctor.svg';
  final ic_chat_doctor = 'assets/images/ic_chat_doctor.svg';
  final ic_doctors_info = 'assets/images/ic_doctors_info.svg';
  final ic_hospital_blue = 'assets/images/ic_hospital_blue.svg';
  final ic_arrow_right = 'assets/images/ic_arrow_right.svg';
  final ic_remove = 'assets/images/ic_remove.svg';
  final ic_search_fill = 'assets/images/ic_search_fill.svg';
  final ic_baget = 'assets/images/ic_baget.svg';
  final ic_message_blue = 'assets/images/ic_message_blue.svg';
  final ic_phone_white = 'assets/images/ic_phone_white.svg';
  final ic_mute = 'assets/images/ic_mute.svg';
  final ic_done_blue = 'assets/images/ic_done_blue.svg';
  final ic_apple_health = 'assets/images/ic_apple_health.png';
  final ic_cerner = 'assets/images/ic_cerner.png';
  final ic_checked = 'assets/images/ic_checked.svg';
  final ic_desinfectant = 'assets/images/ic_desinfectant.svg';
  final ic_edit = 'assets/images/ic_edit.svg';
  final ic_ihealth = 'assets/images/ic_ihealth.png';
  final ic_miband = 'assets/images/ic_miband.png';
  final ic_transfusion = 'assets/images/ic_transfusion.svg';
  final ic_uncheck = 'assets/images/ic_uncheck.svg';
  final ic_weight = 'assets/images/ic_weight.svg';
  final ic_withings = 'assets/images/ic_withings.png';
  final ic_detail = 'assets/images/ic_detail.svg';
  final ic_goal = 'assets/images/ic_goal.svg';
  final ic_edit_goal = 'assets/images/ic_edit_goal.svg';
  final ic_doctor_fav = 'assets/images/ic_doctor_fav.svg';
  final ic_goals = 'assets/images/ic_goals.svg';
  final ic_personal_info = 'assets/images/ic_personal_info.svg';
  final ic_logo_hospital = 'assets/images/ic_logo_hospital.svg';
  final ic_drugs_child = 'assets/images/ic_drugs_child.svg';
  final ic_add_image = 'assets/images/ic_add_image.svg';
  final ic_demo_product = 'assets/images/ic_demo_product.svg';
  final ic_expand = 'assets/images/ic_expand.svg';
  final ic_shopping_bag = 'assets/images/ic_shopping_bag.svg';
  final img_new1 = 'assets/images/img_new1.png';
  final ic_bookmark = 'assets/images/ic_bookmark.svg';
  final img = 'assets/images/img.png';
  final ic_bookmark_news = 'assets/images/ic_bookmark_news.svg';
  final ic_comment_news = 'assets/images/ic_comment_news.svg';
  final ic_level_news = 'assets/images/ic_level_news.svg';
  final ic_like_news = 'assets/images/ic_like_news.svg';
  final ic_share_news = 'assets/images/ic_share_news.svg';
  final ic_location_white = 'assets/images/ic_location_white.svg';
  final ic_ponit_value = 'assets/images/ic_ponit_value.png';
}

class _Color {
  final gray = Color(0xFF969696);
  final grey = Color(0xFF696969);
  final black = Color(0xFF131313);
  final white = Color(0xFFFFFFFF);
  final dark_black = Color(0xFF000000);
  final blue = Color(0xFF4B66EA);
  final light_blue = Color(0xFF82A0F6);
  final dark_blue = Color(0xFF4F6DE6);
  final dark_white = Color(0xFFE5E5E5);
}

class RouterName {
  static const SIGN_IN = 'sign_in';
  static const SIGN_UP = 'sign_up';
  static const FORGOT_PASSWORD = 'forgot_password';
  static const CREATE_ACCOUNT = 'create_account';
  static const MAIN = 'main';
  static const FIND_DOCTOR = 'find_doctor';
  static const FIND_HOSPITAL = 'find_hospital';
  static const CREATE_APPOINTMENT = 'create_appointment';
  static const APPOINTMENT_CALENDAR = "appointment_calendar";
  static const PRICE_SERVICE = 'price_service';
  static const APPOINTMENT_DETAIL = "appointment_detail";
  static const NOTIFICATION = "notification";
  static const CHAT_DOCTOR = "chat_doctor";
  static const DOCTORS_PROFILES = "doctors_profiles";
  static const CALLING_DOCTOR = "calling_doctor";
  static const MAP_DOCTORS = "map_doctors";
  static const INFORMATION_DOCTOR = "information_doctor";
  static const WORD_ADDRESS_DOCTOR = "word_address_doctor";
  static const REVIEW_DOCTOR = "review_doctor";
  static const BOOK_APPOINTMENT = "book_appointment";
  static const TEST_INDICATORS = "test_indicators";
  static const SETTING_TEST_INDICATORS = "setting_test_indicators";
  static const DETAIL_TEST_INDICATOR = "detail_test_indicator";
  static const SET_GOAL = "set_goal";
  static const GOAL_SETTING = "goal_setting";
  static const DOCTOR_FAVORITES = "doctor_favorites";
  static const INSURRANCE = "insurrance";
  static const ADD_DRUGS = "add_drugs";
  static const DRUGS_LIST = "drugs_list";
  static const DRUGS_DETAIL = "drugs_detail";
  static const DRUGS_SHOP = "drugs_shop";
  static const NEWS = "news";
  static const NEWS_BOOKMARK = "news_bookmark";
  static const NEWS_DETAIL = "news_detail";
  static const NEWS_COMMENT = "news_comment";
  static const RESULT_FIND_DOCTOR = "result_find_doctor";
  static const CREATE_ACCOUNT_BIRTHDAY = "create_account_birthday";
  static const CREATE_ACCOUNT_GENDER = "create_account_gender";
  static const CREATE_ACCOUNT_FULLNAME = "create_account_fullname";
  static const CREATE_ACCOUNT_HEIGHT = "create_account_height";
  static const CREATE_ACCOUNT_WEIGHT = "create_account_weight";
  static const DOCTOR_LIST = "doctor_list";
  static const HOSPITAL_LIST = "hospital_list";
  static const INPUT_TEST_INDICATORS = 'input_test_indicators';
  static var id;
  static var quizid;
  static var quizidlength;
  static var neck = 0;
  static var blurred = 0;
  static var dry = 0;
  static var irritation = 0;
  static var headaches = 0;
  static var doublev = 0;
  static double value1 = 0;
  static double value2 = 0;
  static double value3 = 0;
  static double value4 = 0;
  static double value5 = 0;
  static double value6 = 0;
  static double value7= 0;
  static var dateOfQuiz = " ";
  static var TimeOfQuiz = "";
  static var Time = "";

  static double blurredMe = 0;
  static double neckMe = 0;
  static double dryMe = 0;
  static double irritationMe = 0;
  static double headachesMe = 0;
  static double doublevMe = 0;
  static double blurredT = 0;
  static double neckT = 0;
  static double dryT = 0;
  static double irritationT = 0;
  static double headachesT = 0;
  static double doublevT = 0;
  static double blurredW = 0;
  static double neckW = 0;
  static double dryW = 0;
  static double irritationW = 0;
  static double headachesW = 0;
  static double doublevW = 0;
  static double blurredTH = 0;
  static double neckTH = 0;
  static double dryTH = 0;
  static double irritationTH = 0;
  static double headachesTH = 0;
  static double doublevTH = 0;
  static double blurredFR = 0;
  static double neckFR = 0;
  static double dryFR = 0;
  static double irritationFR = 0;
  static double headachesFR = 0;
  static double doublevFR = 0;
  static double blurredSA = 0;
  static double neckSA = 0;
  static double drySA = 0;
  static double headachesSA = 0;
  static double irritationSA = 0;
  static double doublevSA = 0;
  static double blurredSU = 0;
  static double neckSU = 0;
  static double drySU = 0;
  static double irritationSU = 0;
  static double headachesSU = 0;
  static double doublevSU = 0;
  static double MaxBlurr =0;
  static double Maxneck = 0;
  static  double Maxdry = 0;
  static  double MaxBirr = 0;
  static double Maxhead = 0;
  static double Maxdouble = 0;

  static double MinBlurr = 0;
  static double Minneck =0;
  static double Mindry = 0;
  static double MinBirr = 0;
  static double Minhead = 0;
  static double Mindouble =0;

  static double blurredToday = 0;
  static double neckToday =0;
  static double dryToday = 0;
  static double irritationToday = 0;
  static double headachesToday = 0;
  static double doublevToday =0;


  static String MinBlurrdate = "";
  static String Minneckdate = "";
  static  String Mindrydate = "";
  static   String MinBirrdate = "";
  static  String Minheaddate = "";
  static  String Mindoubledate = "";


  static  String MaxBlurrdate = "";
  static  String Maxneckdate = "";
  static  String Maxdrydate = "";
  static String MaxBirrdate = "";
  static  String Maxheaddate = "";
  static String Maxdoubledate = "";

  static DateTime DateOfQuiz;

  static String usern;
  static String gender;
  static String dob;

  static int dobY;
  static int dobM;
  static int dobD;

  static Store<AppState> store;



}
