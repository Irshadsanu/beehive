// // import 'package:crop_image/crop_image.dart';
// import 'package:flutter/material.dart';
// import '../../constants/my_functions.dart';
// import '../../providers/donation_provider.dart';
// import 'package:provider/provider.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Crop Image Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const CropPage(title: 'Crop Image'),
//     );
//   }
// }
//
// class CropPage extends StatefulWidget {
//   final String title;
//
//   const CropPage({Key? key, required this.title}) : super(key: key);
//
//   @override
//   _CropPageState createState() => _CropPageState();
// }
//
// class _CropPageState extends State<CropPage> {
//   // final controller = CropController(
//   //   aspectRatio: 1,
//   //   defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
//   // );
//
//   // @override
//   // void dispose() {
//   //   DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
//   //   donationProvider.controller.dispose();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: Text(widget.title),
//     ),
//     body: Center(
//       child: Padding(
//         padding: const EdgeInsets.all(6.0),
//         child: Consumer<DonationProvider>(
//           builder: (context,value,child) {
//
//             print("Reached 2");
//
//             return CropImage(
//               controller: value.controller,
//               image: Image.memory(value.fileBytes!),
//             );
//           }
//         ),
//       ),
//     ),
//     bottomNavigationBar: _buildButtons(),
//   );
//
//   Widget _buildButtons() => Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Consumer<DonationProvider>(
//         builder: (context,value,child) {
//           print("Reached 3");
//
//           return IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               value.controller.aspectRatio = 1.0;
//               value.controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
//               print("tyyfty"+value.controller.crop.toString());
//             },
//           );
//         }
//       ),
//       IconButton(
//         icon: const Icon(Icons.aspect_ratio),
//         onPressed: _aspectRatios,
//       ),
//       TextButton(
//         onPressed: _finished,
//         child: const Text('Done'),
//       ),
//     ],
//   );
//
//   Future<void> _aspectRatios() async {
//     DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
//
//     final value = await showDialog<double>(
//       context: context,
//       builder: (context) {
//         return SimpleDialog(
//           title: const Text('Select aspect ratio'),
//           children: [
//             SimpleDialogOption(
//               onPressed: () => Navigator.pop(context, 1.0),
//               child: const Text('square'),
//             ),
//             SimpleDialogOption(
//               onPressed: () => Navigator.pop(context, 2.0),
//               child: const Text('2:1'),
//             ),
//             SimpleDialogOption(
//               onPressed: () => Navigator.pop(context, 4.0 / 3.0),
//               child: const Text('4:3'),
//             ),
//             SimpleDialogOption(
//               onPressed: () => Navigator.pop(context, 16.0 / 9.0),
//               child: const Text('16:9'),
//             ),
//           ],
//         );
//       },
//     );
//     if (value != null) {
//       donationProvider.controller.aspectRatio = value;
//       donationProvider.controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
//     }
//   }
//
//   Future<void> _finished() async {
//     DonationProvider donationProvider = Provider.of<DonationProvider>(context, listen: false);
//
//     Image image = await donationProvider.controller.croppedImage();
//
//     donationProvider.changeWhatsappImage(image);
//
//     finish(context);
//   }
// }