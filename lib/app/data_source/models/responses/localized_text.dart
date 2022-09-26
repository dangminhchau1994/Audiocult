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
  late String t_token_expired_message;
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
  late String t_input_code;
  late String t_remove_from_playlist;
  late String t_from;
  late String t_to;
  late String t_code;
  late String t_ticket;
  late String t_tickets;
  late String t_no_ticket_yet;
  late String t_attend_first_event;
  late String t_go_to_popular_events;
  late String t_no_results_found;
  late String t_subscriber;
  late String t_subscribers;
  late String t_biography;
  late String t_audio_artist_category;
  late String t_favorite_genres_of_music;
  late String t_at;
  late String t_unknown;
  late String t_none;
  late String t_one;
  late String t_repeat;
  late String t_posts;
  late String t_event;
  late String t_others;
  late String t_and;
  late String t_invite_friend_success;
  late String t_submit_button;
  late String t_search_email;
  late String t_add_personal_message;
  late String t_invite_friend_mail;
  late String t_seperate_email;
  late String t_deselected_all;
  late String t_step;
  late String t_of;
  late String t_cancel_account;
  late String t_please_tell_us_why;
  late String t_enter_your_password;
  late String t_delete_my_account;
  late String t_invalid_password;
  late String t_last_login;
  late String t_member_since;
  late String t_membership;
  late String t_profile_views;
  late String t_relogin;
  late String t_close_app;

  LocalizedText.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    t_auth_page = iw['t_auth_page'].getString ?? 'Welcome back\nto our community';
    t_auth_member_join = iw['t_auth_member_join'].getString ?? '2k+ music lovers joined us, now it’s your turn';
    t_sign_up = iw['t_sign_up'].getString ?? 'Sign Up';
    t_sign_in = iw['t_sign_in'].getString ?? 'Sign In';
    t_email = iw['t_email'].getString ?? 'Email';
    t_password = iw['t_password'].getString ?? 'Password';
    t_forgot_password = iw['t_forgot_password'].getString ?? 'Forgot password?';
    t_remember_me = iw['t_remember_me'].getString ?? 'Remember me';
    t_full_name = iw['t_full_name'].getString ?? 'Full Name';
    t_mark_all_read = iw['t_mark_all_read'].getString ?? 'Mark All Read';
    t_feature_development = iw['t_feature_development'].getString ?? 'This feature is in development';
    t_sub_register_checkbox =
        iw['t_sub_register_checkbox'].getString ?? 'I’d like to recieve emails with content and notifications.';
    t_notifications = iw['t_notifications'].getString ?? 'Notifications';
    t_register_text =
        iw['t_register_text'].getString ?? 'By signing up, you confirm that you’ve read and accepted our ';
    t_term = iw['t_term'].getString ?? 'Accept Terms & Conditions';
    t_remove_file = iw['t_remove_file'].getString ?? 'Remove file';
    t_video_title = iw['t_video_title'].getString ?? 'Video Title';
    t_resent_password = iw['t_resent_password'].getString ?? 'Resent password';
    t_sub_resent_password = iw['t_sub_resent_password'].getString ??
        "Enter the email associated with your\naccount and we'll send an email with\ninstructions to reset your password.";
    t_submit = iw['t_submit'].getString ?? 'Submit';
    t_check_email = iw['t_check_email'].getString ?? 'Check your email';
    t_sub_check_email = iw['t_sub_check_email'].getString ??
        'Your password reset request has been sent.\nPlease check your email and follow the instruction.';
    t_bottom_check_email = iw['t_bottom_check_email'].getString ?? 'Did not receive the email? Check your spam filter,';
    t_bottom1_check_email = iw['t_bottom1_check_email'].getString ?? 'or try another email address';
    t_create_new_password = iw['t_create_new_password'].getString ?? 'Create new password';
    t_top_song = iw['t_top_song'].getString ?? '"Top Songs';
    t_top_playlist = iw['t_top_playlist'].getString ?? '"Top Playlists';
    t_sub_create =
        iw['t_sub_create'].getString ?? 'Some tips for creating a password, contains\na capital letter, a number, etc.';
    t_new_password = iw['t_new_password'].getString ?? 'New password';
    t_confirm_password = iw['t_confirm_password'].getString ?? 'Confirm new password';
    t_recommended_song = iw['t_recommended_song'].getString ?? 'Recommended songs';
    t_recommended_albums = iw['t_recommended_albums'].getString ?? 'Recommended albums';
    t_recommended_playlist = iw['t_recommended_playlist'].getString ?? 'Recommended playlist';
    t_featured_mixtapes = iw['t_featured_mixtapes'].getString ?? '"Featured Mixtapes';
    t_find_more = iw['t_find_more'].getString ?? 'Find more';
    t_reply = iw['t_reply'].getString ?? 'Reply';
    t_done = iw['t_done'].getString ?? 'Done';
    t_view_more_comment = iw['t_view_more_comment'].getString ?? 'View more comments';
    t_view_reply = iw['t_view_reply'].getString ?? 'View Replies';
    t_add_playlist = iw['t_add_playlist'].getString ?? '"Add to playlist';
    t_create_playlist = iw['t_create_playlist'].getString ?? '"Create Playlist';
    t_share = iw['t_share'].getString ?? '"Share';
    t_playlist_name = iw['t_playlist_name'].getString ?? '"Playlist Name';
    t_edit_post = iw['t_edit_post'].getString ?? 'Edit Post';
    t_optional_description = iw['t_optional_description'].getString ?? '"Add an optional description';
    t_song_detail = iw['t_song_detail'].getString ?? '"Song Details';
    t_camera_permission = iw['t_camera_permission'].getString ?? 'Camera Permission';
    t_need_photos =
        iw['t_need_photos'].getString ?? 'This app needs camera access to take pictures for upload user profile photo';
    t_save = iw['t_save'].getString ?? 'Save';
    t_delete = iw['t_delete'].getString ?? 'Delete';
    t_retry = iw['t_retry'].getString ?? 'Try again';
    t_edit = iw['t_edit'].getString ?? '"Edit';
    t_cancel = iw['t_cancel'].getString ?? '"Cancel';
    t_user_name = iw['t_user_name'].getString ?? 'Username (slug)';
    t_choose_country = iw['t_choose_country'].getString ?? 'Choose Country';
    t_location = iw['t_location'].getString ?? 'Location';
    t_success = iw['t_success'].getString ?? 'Success';
    t_error = iw['t_error'].getString ?? 'Error';
    t_home = iw['t_home'].getString ?? 'Home';
    t_atlas = iw['t_atlas'].getString ?? 'Atlas';
    t_music = iw['t_music'].getString ?? 'Music';
    t_events = iw['t_events'].getString ?? 'Events';
    t_Pending = iw['t_Pending'].getString ?? 'Pending';
    t_information = iw['t_information'].getString ?? 'Info Notification';
    t_featured_album = iw['t_featured_album'].getString ?? '"Featured Albums';
    t_logout = iw['t_logout'].getString ?? 'Log Out';
    t_search = iw['t_search'].getString ?? '"Search';
    t_no_data = iw['t_no_data'].getString ?? '"No data found';
    t_create_post = iw['t_create_post'].getString ?? 'Create Post';
    t_question_logout = iw['t_question_logout'].getString ?? 'Are you sure you want to log out? Confirm and logout';
    t_choose_your_role = iw['t_choose_your_role'].getString ?? 'Choose your role';
    t_choose_role = iw['t_choose_role'].getString ?? 'Choose Role';
    t_search_your_location = iw['t_search_your_location'].getString ?? 'Type to Search your Location';
    t_no_image_available = iw['t_no_image_available'].getString ?? '"No image available';
    t_filter = iw['t_filter'].getString ?? 'Filter';
    t_no_data_found = iw['t_no_data_found'].getString ?? "Can't find any data";
    t_no_data_found_content = iw['t_no_data_found_content'].getString ?? 'Please try again';
    t_description = iw['t_description'].getString ?? 'Description';
    t_clear_filter = iw['t_clear_filter'].getString ?? 'Clear filter';
    t_genres = iw['t_genres'].getString ?? 'Genres';
    t_tags = iw['t_tags'].getString ?? 'Tags(Sub-genre)';
    t_tags_event = iw['t_tags_event'].getString ?? 'Tags (separate by comma)';
    t_leave_comment = iw['t_leave_comment'].getString ?? '"Leave your comment';
    t_read_more = iw['t_read_more'].getString ?? 'Read more';
    t_read_less = iw['t_read_less'].getString ?? 'Read less';
    t_key = iw['t_key'].getString ?? 'Key';
    t_lower = iw['t_lower'].getString ?? 'Lower';
    t_access_photo = iw['t_access_photo'].getString ??
        'You have granted access to some photos. You can add photos or allow access to all photos';
    t_add_image = iw['t_add_image'].getString ?? 'Add Image';
    t_photos = iw['t_photos'].getString ?? 'Photos';
    t_empty_event_title = iw['t_empty_event_title'].getString ?? 'Please fill event title';
    t_empty_event_location = iw['t_empty_event_location'].getString ?? 'Please fill event location';
    t_higher = iw['t_higher'].getString ?? 'Higher';
    t_apply = iw['t_apply'].getString ?? 'Apply';
    t_my_album = iw['t_my_album'].getString ?? 'My Album';
    t_upload = iw['t_upload'].getString ?? 'Upload';
    t_upload_song = iw['t_upload_song'].getString ?? 'Upload Song';
    t_upload_album = iw['t_upload_album'].getString ?? 'Upload Album';
    t_upload_music = iw['t_upload_music'].getString ?? 'Upload Music';
    t_sub_upload_music =
        iw['t_sub_upload_music'].getString ?? 'The maximum number of songs you can upload each time is 10.';
    t_limit_upload = iw['t_limit_upload'].getString ?? 'MP3 or WAV. The file size limit is 1 Gb.';
    btn_next = iw['btn_next'].getString ?? 'Next';
    btn_back = iw['btn_back'].getString ?? 'Back';
    btn_completed = iw['btn_completed'].getString ?? 'Create';
    t_main_info = iw['t_main_info'].getString ?? 'Main info';
    t_empty_playlist = iw['t_empty_playlist'].getString ?? "You don't have playlists yet";
    t_create_first_playlist = iw['t_create_first_playlist'].getString ?? 'Create your first playlist';
    t_sub_main_info = iw['t_sub_main_info'].getString ?? 'Please fill in the basic information about your song.';
    t_track_title = iw['t_track_title'].getString ?? 'Track title';
    t_music_type = iw['t_music_type'].getString ?? 'Music type';
    t_label = iw['t_label'].getString ?? 'Label';
    t_collab_remix = iw['t_collab_remix'].getString ?? 'Collab/Remixers';
    t_tags_separate = iw['t_tags_separate'].getString ?? 'Tags (separate by comma)';
    t_upload_song_cover = iw['t_upload_song_cover'].getString ?? 'Upload Song Cover';
    t_sub_upload_song_cover = iw['t_sub_upload_song_cover'].getString ?? 'JPG, GIF or PNG file';
    t_privacy = iw['t_privacy'].getString ?? 'Privacy';
    t_sub_privacy = iw['t_sub_privacy'].getString ?? 'Control who can see this song.';
    t_comment_privacy = iw['t_comment_privacy'].getString ?? 'Comment Privacy';
    t_sub_comment_privacy = iw['t_sub_comment_privacy'].getString ?? 'Control who can comment on this album.';
    t_meta_data = iw['t_meta_data'].getString ?? 'Metadata';
    t_insert_photo = iw['t_insert_photo'].getString ?? 'Insert Photo';
    t_sell = iw['t_sell'].getString ?? 'Sell';
    t_keyword = iw['t_keyword'].getString ?? '"Keywords';
    t_when = iw['t_when'].getString ?? 'When:';
    t_distance = iw['t_distance'].getString ?? 'Distance:';
    t_in_calendar = iw['t_in_calendar'].getString ?? 'In calendar';
    t_status = iw['t_status'].getString ?? 'Status';
    t_calendar = iw['t_calendar'].getString ?? 'Calendar';
    t_start_time = iw['t_start_time'].getString ?? 'Start time';
    t_end_time = iw['t_end_time'].getString ?? 'End time';
    t_on_map = iw['t_on_map'].getString ?? 'On map';
    t_map = iw['t_map'].getString ?? 'Map';
    t_satellite = iw['t_satellite'].getString ?? 'Satellite';
    t_view_events = iw['t_view_events'].getString ?? 'Click to view events';
    t_show_events = iw['t_show_events'].getString ?? 'SHOW EVENTS';
    t_all_events = iw['t_all_events'].getString ?? 'All Events';
    t_popular_events = iw['t_popular_events'].getString ?? 'Popular Events';
    t_tracking_pricing = iw['t_tracking_pricing'].getString ?? 'Tracking pricing';
    t_usd = iw['t_usd'].getString ?? 'USD';
    t_invite_friend = iw['t_invite_friend'].getString ?? 'Invite friends';
    t_festival = iw['t_festival'].getString ?? 'FESTIVAL';
    t_attending = iw['t_attending'].getString ?? 'Attending';
    t_maybe_attending = iw['t_maybe_attending'].getString ?? 'Maybe Attending';
    t_my_diary = iw['t_my_diary'].getString ?? 'My Diary';
    t_my_tickets = iw['t_my_tickets'].getString ?? 'My Tickets';
    t_invitations = iw['t_invitations'].getString ?? 'Invitations';
    t_free_download = iw['t_free_download'].getString ?? 'Free Download';
    t_license = iw['t_license'].getString ?? 'License';
    t_creative_commons = iw['t_creative_commons'].getString ?? 'Creative Commons';
    t_create_album = iw['t_create_album'].getString ?? 'Create Album';
    t_take_picture = iw['t_take_picture'].getString ?? 'Camera';
    t_choose_gallery = iw['t_choose_gallery'].getString ?? 'Albums';
    t_create_event = iw['t_create_event'].getString ?? 'Create Event';
    t_please_fill = iw['t_please_fill'].getString ?? 'Please fill in the basic information about event.';
    t_buy = iw['t_buy'].getString ?? 'Buy';
    t_artist = iw['t_artist'].getString ?? 'Artist';
    t_upload_event_banner = iw['t_upload_event_banner'].getString ?? 'Upload event banner';
    t_upload_banner = iw['t_upload_banner'].getString ?? 'Upload Banner';
    t_please_check_preview = iw['t_please_check_preview'].getString ??
        'Please check the preview of how your banner /nwill be displayed on the site.';
    t_limit_upload_event = iw['t_limit_upload_event'].getString ?? 'JPG, GIF or PNG file. The file size limit is 2 Mb.';
    t_artist_lineup = iw['t_artist_lineup'].getString ?? 'ARTIST LINEUP';
    t_album_name = iw['t_album_name'].getString ?? 'Album name';
    t_artist_line_up_hint = iw['t_artist_line_up_hint'].getString ?? 'Enter the username or email';
    t_entertainment_line_up = iw['t_entertainment_line_up'].getString ?? 'Entertainment Line up';
    t_event_title = iw['t_event_title'].getString ?? 'Event Title';
    t_category = iw['t_category'].getString ?? 'Category';
    t_choose_date = iw['t_choose_date'].getString ?? 'Choose date';
    t_add_host_detail = iw['t_add_host_detail'].getString ?? 'Add host detail';
    t_help_text = iw['t_help_text'].getString ?? 'Help text';
    t_host_name = iw['t_host_name'].getString ?? 'Host name';
    t_host_website = iw['t_host_website'].getString ?? 'Host website';
    t_host_facebook = iw['t_host_facebook'].getString ?? 'Host facebook url';
    t_host_twitter = iw['t_host_twitter'].getString ?? 'Host twitter url';
    t_duration = iw['t_duration'].getString ?? 'Duration';
    t_location_venue = iw['t_location_venue'].getString ?? 'Location/Venue';
    t_add_another_event = iw['t_add_another_event'].getString ?? 'Add another day of the event';
    t_time_event = iw['t_time_event'].getString ?? 'Time of the event';
    t_year = iw['t_year'].getString ?? 'Year';
    t_result = iw['t_result'].getString ?? 'Results';
    t_song_mixtaps = iw['t_song_mixtaps'].getString ?? 'Song / Mixtape';
    t_feature_song = iw['t_feature_song'].getString ?? 'Features song';
    t_song_of_the_day = iw['t_song_of_the_day'].getString ?? 'Song of the day';
    t_music_genre = iw['t_music_genre'].getString ?? 'Music Genre';
    t_choose_category = iw['t_choose_category'].getString ?? 'Choose category';
    t_already_bought = iw['t_already_bought'].getString ?? 'Already bought';
    t_today = iw['t_today'].getString ?? 'Today';
    t_subscriptions = iw['t_subscriptions'].getString ?? 'Subscriptions';
    t_settings = iw['t_settings'].getString ?? 'Settings';
    t_subscribed = iw['t_subscribed'].getString ?? 'Subscribed';
    t_message = iw['t_message'].getString ?? 'Message';
    t_post = iw['t_post'].getString ?? 'Post';
    t_paste_url = iw['t_paste_url'].getString ?? 'or paste a URL';
    t_browse = iw['t_browse'].getString ?? 'Browse';
    t_about = iw['t_about'].getString ?? 'About';
    t_videos = iw['t_videos'].getString ?? 'Videos';
    t_edit_page = iw['t_edit_page'].getString ?? 'Edit Pages';
    t_account = iw['t_account'].getString ?? 'Account';
    t_say_something_photo = iw['t_say_something_photo'].getString ?? 'Say something about this photo...';
    t_say_something_video = iw['t_say_something_video'].getString ?? 'Say something about this video...';
    t_shared_video =
        iw['t_shared_video'].getString ?? 'Your video is being processed\nand will be available soon after shared.';
    t_what_new = iw['t_what_new'].getString ?? "What 's new?";
    t_add_video_title = iw['t_add_video_title'].getString ?? 'Drag and drop video file here';
    t_add_video_content = iw['t_add_video_content'].getString ??
        'Supported File types: 3GP, AAC, AC3, EC3, FLV, M4F\n, MOV, MJ2\n, MKV, MP4, MXF, OGG\n, TS, WEBM, WMV, AVI\nMaximum File size is 1 Gb.';
    t_upload_multi_photo = iw['t_upload_multi_photo'].getString ?? 'Drag & drop multi photos here to upload';
    t_recommended_upload = iw['t_recommended_upload'].getString ??
        'You can upload a JPG, GIF or PNG file.\nThe file size limit is 8 Mb.\nMaximum number of images is: 10';
    t_notification = iw['t_notification'].getString ?? 'Notification';
    t_basic_information = iw['t_basic_information'].getString ?? 'Basic information';
    t_page_template = iw['t_page_template'].getString ?? 'Page template';
    t_who_with_you = iw['t_who_with_you'].getString ?? 'Who is with you?';
    t_podtal_code = iw['t_podtal_code'].getString ?? 'Zip/Postal code';
    t_about_me = iw['t_about_me'].getString ?? 'About me';
    t_page_temlate_desc =
        iw['t_page_temlate_desc'].getString ?? 'Text description call to action to fills in the information.';
    t_update = iw['t_update'].getString ?? 'Update';
    t_add_pin_on_map = iw['t_add_pin_on_map'].getString ?? 'Add your pin on map';
    t_male = iw['t_male'].getString ?? 'Male';
    t_female = iw['t_female'].getString ?? 'Female';
    t_alian = iw['t_alian'].getString ?? 'Alian';
    t_panda = iw['t_panda'].getString ?? 'Panda';
    t_custom = iw['t_custom'].getString ?? 'Custom';
    t_birthday = iw['t_birthday'].getString ?? 'Birthday';
    t_city = iw['t_city'].getString ?? 'City';
    t_account_settings = iw['t_account_settings'].getString ?? 'Account Settings';
    t_change_password = iw['t_change_password'].getString ?? 'Change Password';
    t_payment_methods = iw['t_payment_methods'].getString ?? 'Payment Methods';
    t_primary_language = iw['t_primary_language'].getString ?? 'Primary Language';
    t_timezone = iw['t_timezone'].getString ?? 'Time Zone';
    t_change_password_note = iw['t_change_password_note'].getString ??
        'Some tips for creating a password, contains a capital letter, a number, etc.';
    t_current_password = iw['t_current_password'].getString ?? 'Curernt Password';
    t_confirm_new_password = iw['t_confirm_new_password'].getString ?? 'Confirm New Password';
    t_payment_methods_note =
        iw['t_payment_methods_note'].getString ?? 'Please, indicate the email that represents your PayPal account.';
    t_paypal_email = iw['t_paypal_email'].getString ?? 'Paypal Email';
    t_notification_settings = iw['t_notification_settings'].getString ?? 'Notification Settings';
    t_your_gender = iw['t_your_gender'].getString ?? 'Your gender';
    t_require_your_custom_gender =
        iw['t_require_your_custom_gender'].getString ?? 'Required manual input for custom gender';
    t_profile = iw['t_profile'].getString ?? 'Profile';
    t_profile_desc = iw['t_profile_desc'].getString ?? 'Customize how other users interact with your profile.';
    t_app_sharing_items = iw['t_app_sharing_items'].getString ?? 'App Sharing Items';
    t_app_sharing_items_desc = iw['t_app_sharing_items_desc'].getString ??
        'Customize your default settings for when sharing new items on the site. Note this only changes your default settings for future items and does not change any items you have already shared. To change the privacy settings on those items you can customize the items privacy by editing the item itself.';
    t_blocked = iw['t_blocked'].getString ?? 'Blocked';
    t_blocked_desc = iw['t_blocked_desc'].getString ??
        'Blocked users cannot view your profile, leave comments or send you private messages.';
    t_everyone = iw['t_everyone'].getString ?? 'Everyone';
    t_unblock = iw['t_unblock'].getString ?? 'Unblock';
    t_all = iw['t_all'].getString ?? 'All';
    t_people = iw['t_people'].getString ?? 'People';
    t_recent_search = iw['t_recent_search'].getString ?? 'Recent search';
    t_rssfeed = iw['t_rssfeed'].getString ?? 'RssFeeds';
    t_pages = iw['t_pages'].getString ?? 'Pages';
    t_songs = iw['t_songs'].getString ?? 'Songs';
    t_song = iw['t_song'].getString ?? 'Song';
    t_input_your_keyword = iw['t_input_your_keyword'].getString ?? 'Please provide search input';
    t_close = iw['t_close'].getString ?? 'Close';
    t_went_wrong = iw['t_went_wrong'].getString ?? 'Something went wrong';
    t_my_cart = iw['t_my_cart'].getString ?? 'My cart';
    t_clear_cart = iw['t_clear_cart'].getString ?? 'Clear cart';
    t_taxes = iw['t_taxes'].getString ?? 'Taxes';
    t_total = iw['t_total'].getString ?? 'Total';
    t_checkout = iw['t_checkout'].getString ?? 'Checkout';
    t_cart_empty = iw['t_cart_empty'].getString ?? 'Cart is empty';
    t_add_to_cart = iw['t_add_to_cart'].getString ?? 'Add to cart';
    t_added_to_cart = iw['t_added_to_cart'].getString ?? 'Added to cart';
    t_are_you_sure_continue = iw['t_are_you_sure_continue'].getString ?? 'Are you sure you want to continue?';
    t_yes = iw['t_yes'].getString ?? 'Yes';
    t_no = iw['t_no'].getString ?? 'No';
    t_enter_your_address = iw['t_enter_your_address'].getString ?? 'Enter your address';
    t_show = iw['t_show'].get() ?? 'Show';
    t_friends_of_friends = iw['t_friends_of_friends'].get() ?? 'Friends of Friends';
    t_only_me = iw['t_only_me'].get() ?? 'Only me';
    t_customize = iw['t_customize'].get() ?? 'Customize';
    t_preview = iw['t_customize'].get() ?? 'Preview';
    t_with = iw['t_with'].get() ?? 'with';
    t_added_to_playlist = iw['t_added_to_playlist'].get() ?? 'Added to playlist';
    t_latest = iw['t_latest'].get() ?? '';
    t_all_fields_required = iw['t_all_fields_required'].get() ?? 'Please fill all information';
    t_sure_to_delete_song = iw['t_sure_to_delete_song'].get() ?? 'Are you sure to delete this song?';
    t_pass_update_successfully = iw['t_pass_update_successfully'].get() ?? 'Password successfully updated';
    t_can_not_empty = iw['t_can_not_empty'].get() ?? '';
    t_pass_not_match = iw['t_pass_not_match'].get() ?? 'Password do not match';
    t_register_successfully = iw['t_register_successfully'].get() ?? 'Register successful!';
    t_no_result_found = iw['t_no_result_found'].get() ?? 'Sorry, no result was found';
    t_edit_success = iw['t_edit_success'].get() ?? 'Edit success';
    t_song_deleted_success = iw['t_song_deleted_success'].get() ?? 'Song deleted successfully';
    t_album_deleted_success = iw['t_album_deleted_success'].get() ?? 'Album deleted successfully';
    t_show_all = iw['t_show_all'].get() ?? 'Show all';
    t_featured_albums = iw['t_featured_albums'].get() ?? 'Featured Albums';
    t_top_of_playlist = iw['t_top_of_playlist'].get() ?? 'Top of Playlists';
    t_request_path_first = iw['t_request_path_first'].get() ?? 'Request paths first';
    t_alert = iw['t_alert'].get() ?? 'Alert';
    t_select = iw['t_select'].get() ?? 'Select';
    t_upload_from_gallery = iw['t_upload_from_gallery'].get() ?? 'Upload From Gallery';
    t_allow_notis = iw['t_allow_notis'].get() ?? 'Allow Notifications';
    t_app_want_send_noti = iw['t_app_want_send_noti'].get() ?? '';
    t_noti_request_message = iw['t_noti_request_message'].get() ?? 'Our app would like to send you notifications';
    t_no_recent_search = iw['t_no_recent_search'].get() ?? 'No recent search';
    t_token_expired_message =
        iw['t_token_expired_message'].get() ?? 'Your session has expired or invalid. Please login and retry';
    t_ask_delete_album = iw['t_ask_delete_album'].get() ?? 'Are you sure to delete this Album ?';
    t_not_attending = iw['t_not_attending'].get() ?? 'Not Attending';
    t_discover = iw['t_discover'].get() ?? 'Discover';
    t_my_library = iw['t_my_library'].get() ?? 'My Library';
    t_most_viewed = iw['t_most_viewed'].get() ?? 'Most Viewed';
    t_most_liked = iw['t_most_liked'].get() ?? 'Most Liked';
    t_most_discussed = iw['t_most_discussed'].get() ?? 'Most Discussed';
    t_all_time = iw['t_all_time'].get() ?? 'All time';
    t_this_month = iw['t_this_month'].get() ?? 'This month';
    t_this_week = iw['t_this_week'].get() ?? 'This week';
    t_upcoming = iw['t_upcoming'].get() ?? 'Upcoming';
    t_miles = iw['t_miles'].get() ?? 'Miles';
    t_album_has_no_comment = iw['t_album_has_no_comment'].get() ?? 'No comments for this albums';
    t_playlist_has_no_comment = iw['t_playlist_has_no_comment'].get() ?? 'No comments for this playlists';
    t_comment = iw['t_comment'].get() ?? '';
    t_block_user = iw['t_block_user'].get() ?? ' "Block this user';
    t_report = iw['t_report'].get() ?? 'Report';
    t_reason = iw['t_reason'].get() ?? 'Reason';
    t_report_success = iw['t_report_success'].get() ?? 'Report Success';
    t_choose_one = iw['t_choose_one'].get() ?? 'Choose one...';
    t_comment_optional = iw['t_comment_optional'].get() ?? 'A comment? (optional):';
    t_stricly_confidential = iw['t_stricly_confidential'].get() ?? 'All reports are strictly confidential';
    t_report_violation = iw['t_report_violation'].get() ?? 'You are about to report a violation of ou';
    t_tearm_of_use = iw['t_tearm_of_use'].get() ?? 'Terms of us';
    t_empty_data = iw['t_empty_data'].get() ?? '';
    t_back = iw['t_back'].get() ?? 'Back';
    t_clear = iw['t_clear'].get() ?? 'Clear';
    t_albums = iw['t_albums'].get() ?? 'Albums';
    t_current_playlist = iw['t_current_playlist'].get() ?? '';
    t_not_find_what_looking_for = iw['t_not_find_what_looking_for'].get() ?? "We couldn't find what you're looking for";
    t_my_playlist = iw['t_my_playlist'].get() ?? 'My Playlist';
    t_input_code = iw['t_input_code'].get() ?? 'Input code...';
    t_remove_from_playlist = iw['t_remove_from_playlist'].get() ?? 'Remove From Playlist';
    t_from = iw['t_from'].get() ?? '"From';
    t_to = iw['t_to'].get() ?? '"To';
    t_code = iw['t_code'].get() ?? '"Code';
    t_ticket = iw['t_ticket'].get() ?? '"Ticket';
    t_tickets = iw['t_tickets'].get() ?? '"Tickets';
    t_no_ticket_yet = iw['t_no_ticket_yet'].get() ?? "You don't have tickets yet";
    t_attend_first_event = iw['t_attend_first_event'].get() ?? 'Attend your first event with Audiocult';
    t_go_to_popular_events = iw['t_go_to_popular_events'].get() ?? 'Go to Popular Events';
    t_no_results_found = iw['t_no_results_found'].get() ?? 'Sorry, no result was found';
    t_subscriber = iw['t_subscriber'].get() ?? 'Subscriber';
    t_subscribers = iw['t_subscribers'].get() ?? 'Subscribers';
    t_biography = iw['t_biography'].get() ?? 'Biography';
    t_audio_artist_category = iw['t_audio_artist_category'].get() ?? 'Audio Artist Category';
    t_favorite_genres_of_music = iw['t_favorite_genres_of_music'].get() ?? 'Favorite Genres Of Music';
    t_at = iw['t_at'].get() ?? 'At';
    t_unknown = iw['t_unknown'].get() ?? 'unknown';
    t_none = iw['t_none'].get() ?? 'none';
    t_one = iw['t_one'].get() ?? 'one';
    t_repeat = iw['t_repeat'].get() ?? 'repeat';
    t_posts = iw['t_posts'].get() ?? 'posts';
    t_event = iw['t_event'].get() ?? 'event';
    t_others = iw['t_others;'].get() ?? 'others';
    t_and = iw['t_and;'].get() ?? 'and';
    t_invite_friend_success = iw['t_invite_friend_success'].get() ?? 'Invite Successful';
    t_submit_button = iw['t_submit_button'].get() ?? 'Send Invitations';
    t_search_email = iw['t_search_email'].get() ?? 'Search by';
    t_add_personal_message = iw['t_add_personal_message'].get() ?? 'Invite People';
    t_invite_friend_mail = iw['t_invite_friend_mail'].get() ?? 'Add a';
    t_seperate_email = iw['t_seperate_email'].get() ?? 'Separate multiple';
    t_deselected_all = iw['t_deselected_all'].get() ?? 'Deselect All';
    t_step = iw['t_step'].get() ?? 'Step';
    t_of = iw['t_of'].get() ?? 'Of';
    t_invalid_password = iw['t_invalid_password'].getString ?? 'Invalid Password';
    t_cancel_account = iw['t_cancel_account'].getString ?? 'Cancel Account';
    t_please_tell_us_why = iw['t_please_tell_us_why'].getString ?? 'Please Tell Us Why';
    t_enter_your_password = iw['t_enter_your_password'].getString ?? 'Enter your password';
    t_delete_my_account = iw['t_delete_my_account'].getString ?? 'Delete My Account';
    t_last_login = iw['t_last_login'].getString ?? 'Last login';
    t_member_since = iw['t_member_since'].getString ?? 'Member since';
    t_membership = iw['t_membership'].getString ?? 'Membership';
    t_profile_views = iw['t_profile_views'].getString ?? 'Profile views';
    t_relogin = iw['t_relogin'].getString ?? 'Re-login';
    t_close_app = iw['t_close_app'].getString ?? 'Close app';
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
