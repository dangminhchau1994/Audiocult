import 'dart:typed_data';

import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/map/map_bloc.dart';
import 'package:audio_cult/app/features/events/map/widgets/events_popup.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/utils/file/file_utils.dart';
import 'package:audio_cult/di/bloc_locator.dart';

import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../data_source/models/requests/event_request.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/debouncer.dart';
import '../../../utils/route/app_route.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  late Uint8List iconMarker;
  final _text = ValueNotifier<String>('');
  final Set<Marker> markers = {};
  late FocusNode focusNode;
  late Debouncer debouncer;
  late TextEditingController editingController;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    debouncer = Debouncer(milliseconds: 500);
    editingController = TextEditingController(text: '');
    getIt<MapBloc>().getEvents(EventRequest(query: '', page: 1, limit: 5));
    FileUtils.getBytesFromAsset(AppAssets.markerIcon, 80).then((value) {
      setState(() {
        iconMarker = value;
      });
    });
  }

  Widget _buildFilter() {
    return WButtonInkwell(
      onPressed: () {
        Navigator.pushNamed(context, AppRoute.routeFilterEvent);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.inputFillColor,
        ),
        child: SvgPicture.asset(
          AppAssets.filterIcon,
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  Widget _buildSearchInput() {
    return Flexible(
      child: ValueListenableBuilder<String>(
        valueListenable: _text,
        builder: (context, query, child) {
          return TextField(
            controller: editingController,
            cursorColor: Colors.white,
            onChanged: (value) {
              _text.value = value;
              getIt<MapBloc>().getEvents(EventRequest(query: value, page: 1, limit: 5));
            },
            decoration: InputDecoration(
              filled: true,
              focusColor: AppColors.outlineBorderColor,
              fillColor: AppColors.inputFillColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.outlineBorderColor,
                  width: 2,
                ),
              ),
              hintText: context.localize.t_search,
              prefixIcon: GestureDetector(
                onTap: () {
                  if (query.isNotEmpty) {}
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              contentPadding: const EdgeInsets.only(
                top: 20,
                left: 10,
              ),
              suffixIcon: query.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        focusNode.unfocus();
                        editingController.text = '';
                        _text.value = '';
                        getIt<MapBloc>().getEvents(EventRequest(query: '', page: 1, limit: 5));
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 18,
                      ),
                    )
                  : const SizedBox(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.secondaryButtonColor,
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(
          title: context.localize.t_map,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      _buildSearchInput(),
                      const SizedBox(width: 10),
                      _buildFilter(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                StreamBuilder<BlocState<List<EventResponse>>>(
                  initialData: const BlocState.loading(),
                  stream: getIt<MapBloc>().getListEventStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data!;

                    return state.when(
                      success: (success) {
                        final events = success as List<EventResponse>;
                        for (final event in events) {
                          markers.add(
                            Marker(
                              markerId: const MarkerId(''),
                              position: LatLng(
                                double.parse(event.lat ?? '0.0'),
                                double.parse(event.lng ?? '0.0'),
                              ),
                              icon: BitmapDescriptor.fromBytes(iconMarker),
                            ),
                          );
                        }

                        return Expanded(
                          child: GoogleMap(
                            onTap: (lng) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                double.parse(events.isEmpty ? '0.0' : events[0].lat ?? ''),
                                double.parse(events.isEmpty ? '0.0' : events[0].lng ?? ''),
                              ),
                              zoom: 10,
                            ),
                            markers: markers,
                            onMapCreated: (controller) {
                              _controller = controller;
                              FileUtils.getJsonFile(AppAssets.nightMapJson).then((value) {
                                _controller.setMapStyle(value);
                              });
                            },
                          ),
                        );
                      },
                      loading: () {
                        return const Center(child: LoadingWidget());
                      },
                      error: (error) {
                        return ErrorSectionWidget(
                          errorMessage: error,
                          onRetryTap: () {},
                        );
                      },
                    );
                  },
                )
              ],
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return EventPopUp(
                        query: _text.value,
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.arrowUp,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.localize.t_view_events,
                        style: context.bodyTextStyle()?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
