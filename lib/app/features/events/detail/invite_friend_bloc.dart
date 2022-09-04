import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/requests/get_invitation_request.dart';
import 'package:audio_cult/app/data_source/models/requests/invite_friend_request.dart';
import 'package:audio_cult/app/data_source/models/responses/event_invitation/event_invitation_response.dart';
import 'package:audio_cult/app/data_source/models/responses/event_invitation/invite_friend_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/subjects.dart';

class InviteFriendBloc extends BaseBloc {
  final AppRepository _appRepository;

  InviteFriendBloc(this._appRepository);

  final _getInviteSubject = PublishSubject<List<EventInvitationResponse>>();
  final _inviteFriendSubject = PublishSubject<BlocState<InviteFriendResponse>>();

  Stream<List<EventInvitationResponse>> get getInviteStream => _getInviteSubject.stream;
  Stream<BlocState<InviteFriendResponse>> get inviteFriendStream => _inviteFriendSubject.stream;

  void getInvitation(GetInvitationRequest request) async {
    final result = await _appRepository.getInvitation(request);

    result.fold((l) {
      _getInviteSubject.sink.add(l);
    }, (r) {
      _getInviteSubject.sink.addError(r.toString());
    });
  }

  void inviteFriends(InviteFriendRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.inviteFriends(request);
    hideOverlayLoading();

    result.fold((l) {
      _inviteFriendSubject.sink.add(BlocState.success(l));
    }, (r) {
      _inviteFriendSubject.sink.add(BlocState.error(r.toString()));
    });
  }
}
