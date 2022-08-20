import 'package:audio_cult/app/base/index_walker.dart';

class LocalizedText {
  final _undefined = 'xxxx';
  late String t_auth_page;
  late String t_auth_member_join;
  late String t_sign_up;
  late String t_sign_in;
  late String t_email;
  late String t_password;
  late String t_forgot_password;
  late String t_remember_me;
  late String t_full_name;
  late String t_mark_all_read;
  late String t_feature_development;
  late String t_sub_register_checkbox;
  late String t_notifications;
  late String t_register_text;
  late String t_term;
  late String t_remove_file;
  late String t_video_title;
  late String t_resent_password;
  late String t_sub_resent_password;
  late String t_submit;
  late String t_check_email;
  late String t_sub_check_email;
  late String t_bottom_check_email;
  late String t_bottom1_check_email;
  late String t_create_new_password;
  late String t_top_song;
  late String t_top_playlist;
  late String t_sub_create;
  late String t_new_password;
  late String t_confirm_password;
  late String t_recommended_song;
  late String t_recommended_albums;
  late String t_recommended_playlist;
  late String t_featured_mixtapes;
  late String t_find_more;
  late String t_reply;
  late String t_done;
  late String t_view_more_comment;
  late String t_view_reply;
  late String t_add_playlist;
  late String t_create_playlist;
  late String t_share;
  late String t_playlist_name;
  late String t_edit_post;
  late String t_optional_description;
  late String t_song_detail;
  late String t_camera_permission;
  late String t_need_photos;
  late String t_save;
  late String t_delete;
  late String t_retry;
  late String t_edit;
  late String t_cancel;
  late String t_user_name;
  late String t_choose_country;
  late String t_location;
  late String t_success;
  late String t_error;
  late String t_home;
  late String t_atlas;
  late String t_music;
  late String t_events;
  late String t_Pending;
  late String t_information;
  late String t_featured_album;
  late String t_logout;
  late String t_search;
  late String t_no_data;
  late String t_create_post;
  late String t_question_logout;
  late String t_choose_your_role;
  late String t_choose_role;
  late String t_search_your_location;
  late String t_no_image_available;
  late String t_filter;
  late String t_no_data_found;
  late String t_no_data_found_content;
  late String t_description;
  late String t_clear_filter;
  late String t_genres;
  late String t_tags;
  late String t_tags_event;
  late String t_leave_comment;
  late String t_read_more;
  late String t_read_less;
  late String t_key;
  late String t_lower;
  late String t_access_photo;
  late String t_add_image;
  late String t_photos;
  late String t_empty_event_title;
  late String t_empty_event_location;
  late String t_higher;
  late String t_apply;
  late String t_my_album;
  late String t_upload;
  late String t_upload_song;
  late String t_upload_album;
  late String t_upload_music;
  late String t_sub_upload_music;
  late String t_limit_upload;
  late String btn_next;
  late String btn_back;
  late String btn_completed;
  late String t_main_info;
  late String t_empty_playlist;
  late String t_create_first_playlist;
  late String t_sub_main_info;
  late String t_track_title;
  late String t_music_type;
  late String t_label;
  late String t_collab_remix;
  late String t_tags_separate;
  late String t_upload_song_cover;
  late String t_sub_upload_song_cover;
  late String t_privacy;
  late String t_sub_privacy;
  late String t_comment_privacy;
  late String t_sub_comment_privacy;
  late String t_meta_data;
  late String t_insert_photo;
  late String t_sell;
  late String t_keyword;
  late String t_when;
  late String t_distance;
  late String t_in_calendar;
  late String t_status;
  late String t_calendar;
  late String t_start_time;
  late String t_end_time;
  late String t_on_map;
  late String t_map;
  late String t_satellite;
  late String t_view_events;
  late String t_show_events;
  late String t_all_events;
  late String t_popular_events;
  late String t_tracking_pricing;
  late String t_usd;
  late String t_invite_friend;
  late String t_festival;
  late String t_attending;
  late String t_maybe_attending;
  late String t_my_diary;
  late String t_my_tickets;
  late String t_invitations;
  late String t_free_download;
  late String t_license;
  late String t_creative_commons;
  late String t_create_album;
  late String t_take_picture;
  late String t_choose_gallery;
  late String t_create_event;
  late String t_please_fill;
  late String t_buy;
  late String t_artist;
  late String t_upload_event_banner;
  late String t_upload_banner;
  late String t_please_check_preview;
  late String t_limit_upload_event;
  late String t_artist_lineup;
  late String t_album_name;
  late String t_artist_line_up_hint;
  late String t_entertainment_line_up;
  late String t_event_title;
  late String t_category;
  late String t_choose_date;
  late String t_add_host_detail;
  late String t_help_text;
  late String t_host_name;
  late String t_host_website;
  late String t_host_facebook;
  late String t_host_twitter;
  late String t_duration;
  late String t_location_venue;
  late String t_add_another_event;
  late String t_time_event;
  late String t_year;
  late String t_result;
  late String t_song_mixtaps;
  late String t_feature_song;
  late String t_song_of_the_day;
  late String t_music_genre;
  late String t_choose_category;
  late String t_already_bought;
  late String t_today;
  late String t_subscriptions;
  late String t_settings;
  late String t_subscribed;
  late String t_message;
  late String t_post;
  late String t_paste_url;
  late String t_browse;
  late String t_about;
  late String t_videos;
  late String t_edit_page;
  late String t_account;
  late String t_say_something_photo;
  late String t_say_something_video;
  late String t_shared_video;
  late String t_what_new;
  late String t_add_video_title;
  late String t_add_video_content;
  late String t_upload_multi_photo;
  late String t_recommended_upload;
  late String t_notification;
  late String t_basic_information;
  late String t_page_template;
  late String t_who_with_you;
  late String t_podtal_code;
  late String t_about_me;
  late String t_page_temlate_desc;
  late String t_update;
  late String t_add_pin_on_map;
  late String t_male;
  late String t_female;
  late String t_alian;
  late String t_panda;
  late String t_custom;
  late String t_birthday;
  late String t_city;
  late String t_account_settings;
  late String t_change_password;
  late String t_payment_methods;
  late String t_primary_language;
  late String t_timezone;
  late String t_change_password_note;
  late String t_current_password;
  late String t_confirm_new_password;
  late String t_payment_methods_note;
  late String t_paypal_email;
  late String t_notification_settings;
  late String t_your_gender;
  late String t_require_your_custom_gender;
  late String t_profile;
  late String t_profile_desc;
  late String t_app_sharing_items;
  late String t_app_sharing_items_desc;
  late String t_blocked;
  late String t_blocked_desc;
  late String t_everyone;
  late String t_unblock;
  late String t_all;
  late String t_people;
  late String t_recent_search;
  late String t_rssfeed;
  late String t_pages;
  late String t_songs;
  late String t_song;
  late String t_input_your_keyword;
  late String t_close;
  late String t_went_wrong;
  late String t_my_cart;
  late String t_clear_cart;
  late String t_taxes;
  late String t_total;
  late String t_checkout;
  late String t_cart_empty;
  late String t_add_to_cart;
  late String t_added_to_cart;
  late String t_are_you_sure_continue;
  late String t_yes;
  late String t_no;
  late String t_select_gender;
  late String t_enter_your_address;
  late String t_show;
  late String t_friends_of_friends;
  late String t_only_me;
  late String t_customize;
  late String t_preview;
  late String t_with;
  late String t_added_to_playlist;
  late String t_latest;
  late String t_all_fields_required;
  late String t_sure_to_delete_song;
  late String t_pass_update_successfully;
  late String t_can_not_empty;
  late String t_pass_not_match;
  late String t_register_successfully;
  late String t_no_result_found;
  late String t_edit_success;
  late String t_song_deleted_success;
  late String t_album_deleted_success;
  late String t_show_all;
  late String t_featured_albums;
  late String t_top_of_playlist;
  late String t_request_path_first;
  late String t_alert;
  late String t_select;
  late String t_upload_from_gallery;
  late String t_allow_notis;
  late String t_app_want_send_noti;
  late String t_noti_request_message;
  late String t_no_recent_search;
  late String t_token_expired;
  late String t_ask_delete_album;
  late String t_not_attending;
  late String t_block_user;
  late String t_report;
  late String t_reason;
  late String t_report_success;
  late String t_choose_one;
  late String t_comment_optional;
  late String t_stricly_confidential;
  late String t_report_violation;
  late String t_tearm_of_use;
  late String t_discover;
  late String t_my_library;
  late String t_most_viewed;
  late String t_most_liked;
  late String t_most_discussed;
  late String t_all_time;
  late String t_this_month;
  late String t_this_week;
  late String t_upcoming;
  late String t_miles;
  late String t_album_has_no_comment;
  late String t_playlist_has_no_comment;
  late String t_comment;
  late String t_empty_data;
  late String t_back;
  late String t_clear;
  late String t_albums;
  late String t_current_playlist;
  late String t_not_find_what_looking_for;
  late String t_my_playlist;

  LocalizedText.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    t_auth_page = iw['t_auth_page'].getString ?? _undefined;
    t_auth_member_join = iw['t_auth_member_join'].getString ?? _undefined;
    t_sign_up = iw['t_sign_up'].getString ?? _undefined;
    t_sign_in = iw['t_sign_in'].getString ?? _undefined;
    t_email = iw['t_email'].getString ?? _undefined;
    t_password = iw['t_password'].getString ?? _undefined;
    t_forgot_password = iw['t_forgot_password'].getString ?? _undefined;
    t_remember_me = iw['t_remember_me'].getString ?? _undefined;
    t_full_name = iw['t_full_name'].getString ?? _undefined;
    t_mark_all_read = iw['t_mark_all_read'].getString ?? _undefined;
    t_feature_development = iw['t_feature_development'].getString ?? _undefined;
    t_sub_register_checkbox = iw['t_sub_register_checkbox'].getString ?? _undefined;
    t_notifications = iw['t_notifications'].getString ?? _undefined;
    t_register_text = iw['t_register_text'].getString ?? _undefined;
    t_term = iw['t_term'].getString ?? _undefined;
    t_remove_file = iw['t_remove_file'].getString ?? _undefined;
    t_video_title = iw['t_video_title'].getString ?? _undefined;
    t_resent_password = iw['t_resent_password'].getString ?? _undefined;
    t_sub_resent_password = iw['t_sub_resent_password'].getString ?? _undefined;
    t_submit = iw['t_submit'].getString ?? _undefined;
    t_check_email = iw['t_check_email'].getString ?? _undefined;
    t_sub_check_email = iw['t_sub_check_email'].getString ?? _undefined;
    t_bottom_check_email = iw['t_bottom_check_email'].getString ?? _undefined;
    t_bottom1_check_email = iw['t_bottom1_check_email'].getString ?? _undefined;
    t_create_new_password = iw['t_create_new_password'].getString ?? _undefined;
    t_top_song = iw['t_top_song'].getString ?? _undefined;
    t_top_playlist = iw['t_top_playlist'].getString ?? _undefined;
    t_sub_create = iw['t_sub_create'].getString ?? _undefined;
    t_new_password = iw['t_new_password'].getString ?? _undefined;
    t_confirm_password = iw['t_confirm_password'].getString ?? _undefined;
    t_recommended_song = iw['t_recommended_song'].getString ?? _undefined;
    t_recommended_albums = iw['t_recommended_albums'].getString ?? _undefined;
    t_recommended_playlist = iw['t_recommended_playlist'].getString ?? _undefined;
    t_featured_mixtapes = iw['t_featured_mixtapes'].getString ?? _undefined;
    t_find_more = iw['t_find_more'].getString ?? _undefined;
    t_reply = iw['t_reply'].getString ?? _undefined;
    t_done = iw['t_done'].getString ?? _undefined;
    t_view_more_comment = iw['t_view_more_comment'].getString ?? _undefined;
    t_view_reply = iw['t_view_reply'].getString ?? _undefined;
    t_add_playlist = iw['t_add_playlist'].getString ?? _undefined;
    t_create_playlist = iw['t_create_playlist'].getString ?? _undefined;
    t_share = iw['t_share'].getString ?? _undefined;
    t_playlist_name = iw['t_playlist_name'].getString ?? _undefined;
    t_edit_post = iw['t_edit_post'].getString ?? _undefined;
    t_optional_description = iw['t_optional_description'].getString ?? _undefined;
    t_song_detail = iw['t_song_detail'].getString ?? _undefined;
    t_camera_permission = iw['t_camera_permission'].getString ?? _undefined;
    t_need_photos = iw['t_need_photos'].getString ?? _undefined;
    t_save = iw['t_save'].getString ?? _undefined;
    t_delete = iw['t_delete'].getString ?? _undefined;
    t_retry = iw['t_retry'].getString ?? _undefined;
    t_edit = iw['t_edit'].getString ?? _undefined;
    t_cancel = iw['t_cancel'].getString ?? _undefined;
    t_user_name = iw['t_user_name'].getString ?? _undefined;
    t_choose_country = iw['t_choose_country'].getString ?? _undefined;
    t_location = iw['t_location'].getString ?? _undefined;
    t_success = iw['t_success'].getString ?? _undefined;
    t_error = iw['t_error'].getString ?? _undefined;
    t_home = iw['t_home'].getString ?? _undefined;
    t_atlas = iw['t_atlas'].getString ?? _undefined;
    t_music = iw['t_music'].getString ?? _undefined;
    t_events = iw['t_events'].getString ?? _undefined;
    t_Pending = iw['t_Pending'].getString ?? _undefined;
    t_information = iw['t_information'].getString ?? _undefined;
    t_featured_album = iw['t_featured_album'].getString ?? _undefined;
    t_logout = iw['t_logout'].getString ?? _undefined;
    t_search = iw['t_search'].getString ?? _undefined;
    t_no_data = iw['t_no_data'].getString ?? _undefined;
    t_create_post = iw['t_create_post'].getString ?? _undefined;
    t_question_logout = iw['t_question_logout'].getString ?? _undefined;
    t_choose_your_role = iw['t_choose_your_role'].getString ?? _undefined;
    t_choose_role = iw['t_choose_role'].getString ?? _undefined;
    t_search_your_location = iw['t_search_your_location'].getString ?? _undefined;
    t_no_image_available = iw['t_no_image_available'].getString ?? _undefined;
    t_filter = iw['t_filter'].getString ?? _undefined;
    t_no_data_found = iw['t_no_data_found'].getString ?? _undefined;
    t_no_data_found_content = iw['t_no_data_found_content'].getString ?? _undefined;
    t_description = iw['t_description'].getString ?? _undefined;
    t_clear_filter = iw['t_clear_filter'].getString ?? _undefined;
    t_genres = iw['t_genres'].getString ?? _undefined;
    t_tags = iw['t_tags'].getString ?? _undefined;
    t_tags_event = iw['t_tags_event'].getString ?? _undefined;
    t_leave_comment = iw['t_leave_comment'].getString ?? _undefined;
    t_read_more = iw['t_read_more'].getString ?? _undefined;
    t_read_less = iw['t_read_less'].getString ?? _undefined;
    t_key = iw['t_key'].getString ?? _undefined;
    t_lower = iw['t_lower'].getString ?? _undefined;
    t_access_photo = iw['t_access_photo'].getString ?? _undefined;
    t_add_image = iw['t_add_image'].getString ?? _undefined;
    t_photos = iw['t_photos'].getString ?? _undefined;
    t_empty_event_title = iw['t_empty_event_title'].getString ?? _undefined;
    t_empty_event_location = iw['t_empty_event_location'].getString ?? _undefined;
    t_higher = iw['t_higher'].getString ?? _undefined;
    t_apply = iw['t_apply'].getString ?? _undefined;
    t_my_album = iw['t_my_album'].getString ?? _undefined;
    t_upload = iw['t_upload'].getString ?? _undefined;
    t_upload_song = iw['t_upload_song'].getString ?? _undefined;
    t_upload_album = iw['t_upload_album'].getString ?? _undefined;
    t_upload_music = iw['t_upload_music'].getString ?? _undefined;
    t_sub_upload_music = iw['t_sub_upload_music'].getString ?? _undefined;
    t_limit_upload = iw['t_limit_upload'].getString ?? _undefined;
    btn_next = iw['btn_next'].getString ?? _undefined;
    btn_back = iw['btn_back'].getString ?? _undefined;
    btn_completed = iw['btn_completed'].getString ?? _undefined;
    t_main_info = iw['t_main_info'].getString ?? _undefined;
    t_empty_playlist = iw['t_empty_playlist'].getString ?? _undefined;
    t_create_first_playlist = iw['t_create_first_playlist'].getString ?? _undefined;
    t_sub_main_info = iw['t_sub_main_info'].getString ?? _undefined;
    t_track_title = iw['t_track_title'].getString ?? _undefined;
    t_music_type = iw['t_music_type'].getString ?? _undefined;
    t_label = iw['t_label'].getString ?? _undefined;
    t_collab_remix = iw['t_collab_remix'].getString ?? _undefined;
    t_tags_separate = iw['t_tags_separate'].getString ?? _undefined;
    t_upload_song_cover = iw['t_upload_song_cover'].getString ?? _undefined;
    t_sub_upload_song_cover = iw['t_sub_upload_song_cover'].getString ?? _undefined;
    t_privacy = iw['t_privacy'].getString ?? _undefined;
    t_sub_privacy = iw['t_sub_privacy'].getString ?? _undefined;
    t_comment_privacy = iw['t_comment_privacy'].getString ?? _undefined;
    t_sub_comment_privacy = iw['t_sub_comment_privacy'].getString ?? _undefined;
    t_meta_data = iw['t_meta_data'].getString ?? _undefined;
    t_insert_photo = iw['t_insert_photo'].getString ?? _undefined;
    t_sell = iw['t_sell'].getString ?? _undefined;
    t_keyword = iw['t_keyword'].getString ?? _undefined;
    t_when = iw['t_when'].getString ?? _undefined;
    t_distance = iw['t_distance'].getString ?? _undefined;
    t_in_calendar = iw['t_in_calendar'].getString ?? _undefined;
    t_status = iw['t_status'].getString ?? _undefined;
    t_calendar = iw['t_calendar'].getString ?? _undefined;
    t_start_time = iw['t_start_time'].getString ?? _undefined;
    t_end_time = iw['t_end_time'].getString ?? _undefined;
    t_on_map = iw['t_on_map'].getString ?? _undefined;
    t_map = iw['t_map'].getString ?? _undefined;
    t_satellite = iw['t_satellite'].getString ?? _undefined;
    t_view_events = iw['t_view_events'].getString ?? _undefined;
    t_show_events = iw['t_show_events'].getString ?? _undefined;
    t_all_events = iw['t_all_events'].getString ?? _undefined;
    t_popular_events = iw['t_popular_events'].getString ?? _undefined;
    t_tracking_pricing = iw['t_tracking_pricing'].getString ?? _undefined;
    t_usd = iw['t_usd'].getString ?? _undefined;
    t_invite_friend = iw['t_invite_friend'].getString ?? _undefined;
    t_festival = iw['t_festival'].getString ?? _undefined;
    t_attending = iw['t_attending'].getString ?? _undefined;
    t_maybe_attending = iw['t_maybe_attending'].getString ?? _undefined;
    t_my_diary = iw['t_my_diary'].getString ?? _undefined;
    t_my_tickets = iw['t_my_tickets'].getString ?? _undefined;
    t_invitations = iw['t_invitations'].getString ?? _undefined;
    t_free_download = iw['t_free_download'].getString ?? _undefined;
    t_license = iw['t_license'].getString ?? _undefined;
    t_creative_commons = iw['t_creative_commons'].getString ?? _undefined;
    t_create_album = iw['t_create_album'].getString ?? _undefined;
    t_take_picture = iw['t_take_picture'].getString ?? _undefined;
    t_choose_gallery = iw['t_choose_gallery'].getString ?? _undefined;
    t_create_event = iw['t_create_event'].getString ?? _undefined;
    t_please_fill = iw['t_please_fill'].getString ?? _undefined;
    t_buy = iw['t_buy'].getString ?? _undefined;
    t_artist = iw['t_artist'].getString ?? _undefined;
    t_upload_event_banner = iw['t_upload_event_banner'].getString ?? _undefined;
    t_upload_banner = iw['t_upload_banner'].getString ?? _undefined;
    t_please_check_preview = iw['t_please_check_preview'].getString ?? _undefined;
    t_limit_upload_event = iw['t_limit_upload_event'].getString ?? _undefined;
    t_artist_lineup = iw['t_artist_lineup'].getString ?? _undefined;
    t_album_name = iw['t_album_name'].getString ?? _undefined;
    t_artist_line_up_hint = iw['t_artist_line_up_hint'].getString ?? _undefined;
    t_entertainment_line_up = iw['t_entertainment_line_up'].getString ?? _undefined;
    t_event_title = iw['t_event_title'].getString ?? _undefined;
    t_category = iw['t_category'].getString ?? _undefined;
    t_choose_date = iw['t_choose_date'].getString ?? _undefined;
    t_add_host_detail = iw['t_add_host_detail'].getString ?? _undefined;
    t_help_text = iw['t_help_text'].getString ?? _undefined;
    t_host_name = iw['t_host_name'].getString ?? _undefined;
    t_host_website = iw['t_host_website'].getString ?? _undefined;
    t_host_facebook = iw['t_host_facebook'].getString ?? _undefined;
    t_host_twitter = iw['t_host_twitter'].getString ?? _undefined;
    t_duration = iw['t_duration'].getString ?? _undefined;
    t_location_venue = iw['t_location_venue'].getString ?? _undefined;
    t_add_another_event = iw['t_add_another_event'].getString ?? _undefined;
    t_time_event = iw['t_time_event'].getString ?? _undefined;
    t_year = iw['t_year'].getString ?? _undefined;
    t_result = iw['t_result'].getString ?? _undefined;
    t_song_mixtaps = iw['t_song_mixtaps'].getString ?? _undefined;
    t_feature_song = iw['t_feature_song'].getString ?? _undefined;
    t_song_of_the_day = iw['t_song_of_the_day'].getString ?? _undefined;
    t_music_genre = iw['t_music_genre'].getString ?? _undefined;
    t_choose_category = iw['t_choose_category'].getString ?? _undefined;
    t_already_bought = iw['t_already_bought'].getString ?? _undefined;
    t_today = iw['t_today'].getString ?? _undefined;
    t_subscriptions = iw['t_subscriptions'].getString ?? _undefined;
    t_settings = iw['t_settings'].getString ?? _undefined;
    t_subscribed = iw['t_subscribed'].getString ?? _undefined;
    t_message = iw['t_message'].getString ?? _undefined;
    t_post = iw['t_post'].getString ?? _undefined;
    t_paste_url = iw['t_paste_url'].getString ?? _undefined;
    t_browse = iw['t_browse'].getString ?? _undefined;
    t_about = iw['t_about'].getString ?? _undefined;
    t_videos = iw['t_videos'].getString ?? _undefined;
    t_edit_page = iw['t_edit_page'].getString ?? _undefined;
    t_account = iw['t_account'].getString ?? _undefined;
    t_say_something_photo = iw['t_say_something_photo'].getString ?? _undefined;
    t_say_something_video = iw['t_say_something_video'].getString ?? _undefined;
    t_shared_video = iw['t_shared_video'].getString ?? _undefined;
    t_what_new = iw['t_what_new'].getString ?? _undefined;
    t_add_video_title = iw['t_add_video_title'].getString ?? _undefined;
    t_add_video_content = iw['t_add_video_content'].getString ?? _undefined;
    t_upload_multi_photo = iw['t_upload_multi_photo'].getString ?? _undefined;
    t_recommended_upload = iw['t_recommended_upload'].getString ?? _undefined;
    t_notification = iw['t_notification'].getString ?? _undefined;
    t_basic_information = iw['t_basic_information'].getString ?? _undefined;
    t_page_template = iw['t_page_template'].getString ?? _undefined;
    t_who_with_you = iw['t_who_with_you'].getString ?? _undefined;
    t_podtal_code = iw['t_podtal_code'].getString ?? _undefined;
    t_about_me = iw['t_about_me'].getString ?? _undefined;
    t_page_temlate_desc = iw['t_page_temlate_desc'].getString ?? _undefined;
    t_update = iw['t_update'].getString ?? _undefined;
    t_add_pin_on_map = iw['t_add_pin_on_map'].getString ?? _undefined;
    t_male = iw['t_male'].getString ?? _undefined;
    t_female = iw['t_female'].getString ?? _undefined;
    t_alian = iw['t_alian'].getString ?? _undefined;
    t_panda = iw['t_panda'].getString ?? _undefined;
    t_custom = iw['t_custom'].getString ?? _undefined;
    t_birthday = iw['t_birthday'].getString ?? _undefined;
    t_city = iw['t_city'].getString ?? _undefined;
    t_account_settings = iw['t_account_settings'].getString ?? _undefined;
    t_change_password = iw['t_change_password'].getString ?? _undefined;
    t_payment_methods = iw['t_payment_methods'].getString ?? _undefined;
    t_primary_language = iw['t_primary_language'].getString ?? _undefined;
    t_timezone = iw['t_timezone'].getString ?? _undefined;
    t_change_password_note = iw['t_change_password_note'].getString ?? _undefined;
    t_current_password = iw['t_current_password'].getString ?? _undefined;
    t_confirm_new_password = iw['t_confirm_new_password'].getString ?? _undefined;
    t_payment_methods_note = iw['t_payment_methods_note'].getString ?? _undefined;
    t_paypal_email = iw['t_paypal_email'].getString ?? _undefined;
    t_notification_settings = iw['t_notification_settings'].getString ?? _undefined;
    t_your_gender = iw['t_your_gender'].getString ?? _undefined;
    t_require_your_custom_gender = iw['t_require_your_custom_gender'].getString ?? _undefined;
    t_profile = iw['t_profile'].getString ?? _undefined;
    t_profile_desc = iw['t_profile_desc'].getString ?? _undefined;
    t_app_sharing_items = iw['t_app_sharing_items'].getString ?? _undefined;
    t_app_sharing_items_desc = iw['t_app_sharing_items_desc'].getString ?? _undefined;
    t_blocked = iw['t_blocked'].getString ?? _undefined;
    t_blocked_desc = iw['t_blocked_desc'].getString ?? _undefined;
    t_everyone = iw['t_everyone'].getString ?? _undefined;
    t_unblock = iw['t_unblock'].getString ?? _undefined;
    t_all = iw['t_all'].getString ?? _undefined;
    t_people = iw['t_people'].getString ?? _undefined;
    t_recent_search = iw['t_recent_search'].getString ?? _undefined;
    t_rssfeed = iw['t_rssfeed'].getString ?? _undefined;
    t_pages = iw['t_pages'].getString ?? _undefined;
    t_songs = iw['t_songs'].getString ?? _undefined;
    t_song = iw['t_song'].getString ?? _undefined;
    t_input_your_keyword = iw['t_input_your_keyword'].getString ?? _undefined;
    t_close = iw['t_close'].getString ?? _undefined;
    t_went_wrong = iw['t_went_wrong'].getString ?? _undefined;
    t_my_cart = iw['t_my_cart'].getString ?? _undefined;
    t_clear_cart = iw['t_clear_cart'].getString ?? _undefined;
    t_taxes = iw['t_taxes'].getString ?? _undefined;
    t_total = iw['t_total'].getString ?? _undefined;
    t_checkout = iw['t_checkout'].getString ?? _undefined;
    t_cart_empty = iw['t_cart_empty'].getString ?? _undefined;
    t_add_to_cart = iw['t_add_to_cart'].getString ?? _undefined;
    t_added_to_cart = iw['t_added_to_cart'].getString ?? _undefined;
    t_are_you_sure_continue = iw['t_are_you_sure_continue'].getString ?? _undefined;
    t_yes = iw['t_yes'].getString ?? _undefined;
    t_no = iw['t_no'].getString ?? _undefined;
    t_select_gender = iw['t_select_gender'].getString ?? _undefined;
    t_enter_your_address = iw['t_enter_your_address'].getString ?? _undefined;
    t_show = iw['t_show'].get() ?? _undefined;
    t_friends_of_friends = iw['t_friends_of_friends'].get() ?? _undefined;
    t_only_me = iw['t_only_me'].get() ?? _undefined;
    t_customize = iw['t_customize'].get() ?? _undefined;
    t_preview = iw['t_customize'].get() ?? _undefined;
    t_with = iw['t_with'].get() ?? _undefined;
    t_added_to_playlist = iw['t_added_to_playlist'].get() ?? _undefined;
    t_latest = iw['t_latest'].get() ?? _undefined;
    t_all_fields_required = iw['t_all_fields_required'].get() ?? _undefined;
    t_sure_to_delete_song = iw['t_sure_to_delete_song'].get() ?? _undefined;
    t_pass_update_successfully = iw['t_pass_update_successfully'].get() ?? _undefined;
    t_can_not_empty = iw['t_can_not_empty'].get() ?? _undefined;
    t_pass_not_match = iw['t_pass_not_match'].get() ?? _undefined;
    t_register_successfully = iw['t_register_successfully'].get() ?? _undefined;
    t_no_result_found = iw['t_no_result_found'].get(defaultValue: _undefined) ?? _undefined;
    t_edit_success = iw['t_edit_success'].get() ?? _undefined;
    t_song_deleted_success = iw['t_song_deleted_success'].get() ?? _undefined;
    t_album_deleted_success = iw['t_album_deleted_success'].get() ?? _undefined;
    t_show_all = iw['t_show_all'].get() ?? _undefined;
    t_featured_albums = iw['t_featured_albums'].get() ?? _undefined;
    t_top_of_playlist = iw['t_top_of_playlist'].get() ?? _undefined;
    t_request_path_first = iw['t_request_path_first'].get() ?? _undefined;
    t_alert = iw['t_alert'].get() ?? _undefined;
    t_select = iw['t_select'].get() ?? _undefined;
    t_upload_from_gallery = iw['t_upload_from_gallery'].get() ?? _undefined;
    t_allow_notis = iw['t_allow_notis'].get() ?? _undefined;
    t_app_want_send_noti = iw['t_app_want_send_noti'].get() ?? _undefined;
    t_noti_request_message = iw['t_noti_request_message'].get() ?? _undefined;
    t_no_recent_search = iw['t_no_recent_search'].get() ?? _undefined;
    t_token_expired = iw['t_token_expired'].get() ?? _undefined;
    t_ask_delete_album = iw['t_ask_delete_album'].get() ?? _undefined;
    t_not_attending = iw['t_not_attending'].get() ?? _undefined;
    t_discover = iw['t_discover'].get() ?? _undefined;
    t_my_library = iw['t_my_library'].get() ?? _undefined;
    t_most_viewed = iw['t_most_viewed'].get() ?? _undefined;
    t_most_liked = iw['t_most_liked'].get() ?? _undefined;
    t_most_discussed = iw['t_most_discussed'].get() ?? _undefined;
    t_all_time = iw['t_all_time'].get() ?? _undefined;
    t_this_month = iw['t_this_month'].get() ?? _undefined;
    t_this_week = iw['t_this_week'].get() ?? _undefined;
    t_upcoming = iw['t_upcoming'].get() ?? _undefined;
    t_miles = iw['t_miles'].get() ?? _undefined;
    t_album_has_no_comment = iw['t_album_has_no_comment'].get() ?? _undefined;
    t_playlist_has_no_comment = iw['t_playlist_has_no_comment'].get() ?? _undefined;
    t_comment = iw['t_comment'].get() ?? _undefined;
    t_block_user = iw['t_block_user'].get() ?? _undefined;
    t_report = iw['t_report'].get() ?? _undefined;
    t_reason = iw['t_reason'].get() ?? _undefined;
    t_report_success = iw['t_report_success'].get() ?? _undefined;
    t_choose_one = iw['t_choose_one'].get() ?? _undefined;
    t_comment_optional = iw['t_comment_optional'].get() ?? _undefined;
    t_stricly_confidential = iw['t_stricly_confidential'].get() ?? _undefined;
    t_report_violation = iw['t_report_violation'].get() ?? _undefined;
    t_tearm_of_use = iw['t_tearm_of_use'].get() ?? _undefined;
    t_empty_data = iw['t_empty_data'].get() ?? _undefined;
    t_back = iw['t_back'].get() ?? _undefined;
    t_clear = iw['t_clear'].get() ?? _undefined;
    t_albums = iw['t_albums'].get() ?? _undefined;
    t_current_playlist = iw['t_current_playlist'].get() ?? _undefined;
    t_not_find_what_looking_for = iw['t_not_find_what_looking_for'].get() ?? _undefined;
    t_my_playlist = iw['t_my_playlist'].get() ?? _undefined;
  }
}

class TranslatedText {
  late String phraseId;
  late String varName;
  late String text;

  TranslatedText.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    phraseId = iw['phrase_id'].get() ?? '';
    varName = iw['var_name'].get() ?? '';
    text = iw['text'].get() ?? '';
  }

  Map<String, dynamic> toDictionary() {
    return <String, String>{varName: text};
  }
}
