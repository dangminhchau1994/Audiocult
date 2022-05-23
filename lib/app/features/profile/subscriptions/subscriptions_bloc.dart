import 'package:audio_cult/app/features/atlas/atlas_bloc.dart';

import '../../../data_source/repositories/app_repository.dart';
import '../../atlas/subscribe_user_bloc.dart';

class SubscriptionsBloc extends AtlasBloc {
  final AppRepository _appRepository;
  final SubscribeUserBloc _subscribeUserBloc;


  SubscriptionsBloc(this._appRepository,this._subscribeUserBloc) : super(_appRepository,_subscribeUserBloc);
}
