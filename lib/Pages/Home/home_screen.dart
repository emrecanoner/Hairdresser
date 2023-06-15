import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hairdresser/Constant/Style.dart';
import 'package:hairdresser/Constant/custom_sizedbox.dart';
import 'package:hairdresser/Constant/media_query_helper.dart';
import 'package:hairdresser/Controller/Home/home_controller.dart';
import 'package:hairdresser/Pages/Login/login_screen.dart';
import 'package:hairdresser/Pages/Profile/profile_screen.dart';
import 'package:hairdresser/Provider/Home/home_provider.dart';
import 'package:hairdresser/Provider/Profile/profile_provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeController = ref.watch(homeControllerProvider);
    homeController.init().then((_) {
      setState(() {});
    });
  }

  void _showReservationDialog(
      String salonName, String salonAddress, HomeController homeController) {
    final _dateController = TextEditingController();
    final _timeController = TextEditingController();
    // ignore: unused_local_variable
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: CustomColor.kBlackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal:
                    MediaQueryHelper.getPieceOfGridWidth(context, .4, .4, .4),
                vertical:
                    MediaQueryHelper.getPieceOfGridHeight(context, .4, .4, .4)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Make a Reservation', style: CustomStyle.reservationTitle),
                CustomtSizedBox(
                    phoneSize: .1, tabletSize: .1, webSize: .1, isHeight: true),
                Text(
                  'Hairdresser: $salonName',
                  style: CustomStyle.reservationHairdresser,
                  textAlign: TextAlign.center,
                ),
                CustomtSizedBox(
                    phoneSize: .1, tabletSize: .1, webSize: .1, isHeight: true),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                        _dateController.text =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                      });
                    }
                  },
                  child: Text(
                    'Choose a Date',
                    style: TextStyle(
                      color: CustomColor.kBlackColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.kWhiteColor,
                  ),
                ),
                CustomtSizedBox(
                    phoneSize: .1, tabletSize: .1, webSize: .1, isHeight: true),
                TextField(
                    controller: _dateController,
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: 'Date', labelStyle: CustomStyle.whiteColor),
                    style: CustomStyle.whiteColor),
                CustomtSizedBox(
                    phoneSize: .1, tabletSize: .1, webSize: .1, isHeight: true),
                ElevatedButton(
                  onPressed: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _timeController.text = pickedTime.format(context);
                      });
                    }
                  },
                  child: Text('Choose a Time', style: CustomStyle.blackColor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.kWhiteColor,
                  ),
                ),
                CustomtSizedBox(
                    phoneSize: .1, tabletSize: .1, webSize: .1, isHeight: true),
                TextField(
                    controller: _timeController,
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: 'Time', labelStyle: CustomStyle.whiteColor),
                    style: CustomStyle.whiteColor),
                CustomtSizedBox(
                    phoneSize: .1, tabletSize: .1, webSize: .1, isHeight: true),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      homeController.selectedSalon =
                          salonName + " -*- " + salonAddress;
                      homeController.selectedDate = _dateController.text;
                      homeController.selectedTime = _timeController.text;
                    });
                    homeController.addReservation().then((_) {
                      _reloadHomePage(homeController);
                      Navigator.pop(context);
                    });
                  },
                  child:
                      Text('Make a Reservation', style: CustomStyle.blackColor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.kWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _reloadHomePage(HomeController homeController) async {
    await homeController.init();
    setState(() {});
  }

  Widget _buildReservationsList(HomeController homeController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upcoming Reservations', style: CustomStyle.homeScreenTitle),
        Container(
          height: MediaQueryHelper.getPieceOfGridHeight(context, 2, 2, 2),
          child: ListView.builder(
            itemCount: homeController.reservations.length,
            itemBuilder: (BuildContext context, int index) {
              final reservation = homeController.reservations[index];
              final reservationName = reservation['name'];
              final date = reservation['date'];
              final time = reservation['time'];
              final address = reservation['address'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(
                        top: MediaQueryHelper.getPieceOfGridHeight(
                            context, .1, .1, .1)),
                    leading: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.red.shade500,
                      ),
                      iconSize: 20,
                      onPressed: () {
                        setState(() {
                          homeController.removeReservation(index).then((_) {
                            _reloadHomePage(homeController);
                          });
                        });
                      },
                    ),
                    title: Text(reservationName,
                        style: CustomStyle.homeScreenItemTitle),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address,
                            style: CustomStyle.homeScreenItemSubTitle),
                        Text(date, style: CustomStyle.homeScreenItemSubTitle),
                        Text(time, style: CustomStyle.homeScreenItemSubTitle),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    final homeController = ref.watch(homeControllerProvider);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            right: MediaQueryHelper.getPieceOfGridWidth(context, .7, .7, .7),
            left: MediaQueryHelper.getPieceOfGridWidth(context, .7, .7, .7),
            top: MediaQueryHelper.getPieceOfGridHeight(context, .7, .7, .7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: CustomColor.kBlackColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: CustomColor.kWhiteColor,
                      size: 15,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ),
                CustomtSizedBox(
                    phoneSize: .3,
                    tabletSize: .3,
                    webSize: .3,
                    isHeight: false),
                Text('Welcome', style: CustomStyle.homeScreenWelcome),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.output_rounded,
                    color: CustomColor.kBlackColor,
                    size: 25,
                  ),
                  onPressed: () {
                    profileController.firebaseService.signOut(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            CustomtSizedBox(
                phoneSize: .25, tabletSize: .25, webSize: .25, isHeight: true),
            Text('Choose a Hairdresser', style: CustomStyle.homeScreenTitle),
            _buildSalonList(homeController),
            CustomtSizedBox(
                phoneSize: .25, tabletSize: .25, webSize: .25, isHeight: true),
            if (homeController.reservations.isNotEmpty)
              _buildReservationsList(homeController),
          ],
        ),
      ),
    );
  }

  Widget _buildSalonList(HomeController homeController) {
    return SizedBox(
      height: MediaQueryHelper.getPieceOfGridHeight(context, 6.5, 6.5, 6.5),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: homeController.salons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio:
              MediaQueryHelper.getPieceOfGridHeight(context, .025, .025, .025),
          crossAxisCount: 2,
          crossAxisSpacing:
              MediaQueryHelper.getPieceOfGridWidth(context, .3, .3, .3),
          mainAxisSpacing:
              MediaQueryHelper.getPieceOfGridHeight(context, .2, .2, .2),
        ),
        itemBuilder: (BuildContext context, int index) {
          return _buildSalonItem(homeController.salons[index], homeController);
        },
      ),
    );
  }

  Widget _buildSalonItem(String salon, HomeController homeController) {
    List<String> salonInfo = salon.split(' -*- ');
    String salonName = salonInfo[0];
    String salonAddress = salonInfo[1];

    return Card(
      child: InkWell(
        onTap: () {
          _showReservationDialog(salonName, salonAddress, homeController);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical:
                  MediaQueryHelper.getPieceOfGridHeight(context, .2, .2, .2),
              horizontal:
                  MediaQueryHelper.getPieceOfGridWidth(context, .2, .2, .2)),
          child: Row(
            children: [
              Icon(Icons.spa),
              CustomtSizedBox(
                  phoneSize: .4, tabletSize: .4, webSize: .4, isHeight: false),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(salonName, style: CustomStyle.homeScreenItemTitle),
                    Text(
                      salonAddress,
                      style: CustomStyle.homeScreenItemSubTitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
