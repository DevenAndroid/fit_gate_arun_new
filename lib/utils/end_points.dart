class EndPoints {
  ///baseUrl
  static String baseUrl = "https://admin.fitgate.live/api/";
  static String imgBaseUrl = "https://admin.fitgate.live";

  /// auth
  static String login = "${baseUrl}login";
  static String checkPhoneNo = "${baseUrl}check_phone_number";
  static String registration = "${baseUrl}registration";
  static String getUserById = "${baseUrl}get_user_by_id";
  static String deleteUser = "${baseUrl}deleteUser";

  ///checkUser
  ///
  static String checkUser = "${baseUrl}check_user_ban_unban";

  /// profile
  static String profile = "${baseUrl}profile";

  /// base64
  static String base64 = "${baseUrl}base64";

  /// search gym by package
  static String classTypeFilterGym = "${baseUrl}class_type_filter_gym";

  ///get_gym
  static String getGym = "${baseUrl}get_gym";

  ///search_map_gym
  static String searchGym = "${baseUrl}gym_search";

  /// emailVerify
  static String sendVerificationEmail = "${baseUrl}sendVerificationEmail";
  static String checkEmailVerification = "${baseUrl}check_email_verification";
  static String resendEmailVerification = "${baseUrl}resend_email_verification";

  ///Check in
  static String checkIn = "${baseUrl}check_in";
  static String checkInLog = "${baseUrl}check_ins_log";

  /// get company
  static String getCompany = "${baseUrl}get_company";

  /// get lat lan
  static String getLatLan = "${baseUrl}get_lat_lon";

  ///subscription List
  static String subscriptionList = "${baseUrl}subscription_list";
  static String activeSubscription = "${baseUrl}active_subscription";
  static String updateSubscription = "${baseUrl}update_subscription";
  static String deleteSubscription = "${baseUrl}delete_subscription";

  ///payment
  static String paymentSystem = "${baseUrl}payment_api";
  static String paymentPage = "${baseUrl}payment_page";

  ///notification
  static String get_notification = "${baseUrl}get_notification";
  static String update_notification = "${baseUrl}update_notification";
  static String count_notification = "${baseUrl}count_notification";

  static String getBanner = "${baseUrl}get_sliders";
}
