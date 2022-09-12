import 'dart:ui';

import 'package:audio_cult/app/utils/constants/app_colors.dart';

enum TicketStatus { pending, paid, cancelled, expired }

extension TicketStatusExtension on TicketStatus {
  static TicketStatus? init(String char) {
    switch (char) {
      case 'n':
        return TicketStatus.pending;
      case 'p':
        return TicketStatus.paid;
      case 'e':
        return TicketStatus.expired;
      case 'c':
        return TicketStatus.cancelled;
    }
    return null;
  }

  Color get color {
    switch (this) {
      case TicketStatus.pending:
        return AppColors.pirateGold;
      case TicketStatus.paid:
        return AppColors.persianGreen;
      case TicketStatus.expired:
        return AppColors.badgeColor;
      case TicketStatus.cancelled:
        return AppColors.inputFillColor;
    }
  }
}
