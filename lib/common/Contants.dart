
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants{


  static Future<bool> deleteDialog(BuildContext context, String name) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            // insetPadding: EdgeInsets.only(
            //     left: MediaQuery.of(context).orientation == Orientation.portrait
            //         ? MediaQuery.of(context).size.width * 0.2
            //         : MediaQuery.of(context).size.height * 0.3,
            //     right:
            //     MediaQuery.of(context).orientation == Orientation.portrait
            //         ? MediaQuery.of(context).size.width * 0.2
            //         : MediaQuery.of(context).size.height * 0.3,
            //     top: MediaQuery.of(context).size.width * 0.05,
            //     bottom: MediaQuery.of(context).size.width * 0.05),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Are you sure to delete \n" + name + " ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                          child: Text("Delete",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }





  // static Future<bool> blockDialog(BuildContext context, String name) async {
  //   return await showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           // insetPadding: EdgeInsets.only(
  //           //     left: MediaQuery.of(context).orientation == Orientation.portrait
  //           //         ? MediaQuery.of(context).size.width * 0.2
  //           //         : MediaQuery.of(context).size.height * 0.3,
  //           //     right:
  //           //     MediaQuery.of(context).orientation == Orientation.portrait
  //           //         ? MediaQuery.of(context).size.width * 0.2
  //           //         : MediaQuery.of(context).size.height * 0.3,
  //           //     top: MediaQuery.of(context).size.width * 0.05,
  //           //     bottom: MediaQuery.of(context).size.width * 0.05),
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //           child: Wrap(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(20.0),
  //                 child: Align(
  //                   alignment: Alignment.topCenter,
  //                   child: Text(
  //                     "Are you sure to block \n" + name + " ?",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 20,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           primary: Colors.white,
  //                         ),
  //                         child: Text(
  //                           "Cancel",
  //                           style: TextStyle(color: Colors.grey),
  //                         ),
  //                         onPressed: () {
  //                           Navigator.of(context).pop(false);
  //                         }),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           primary: Colors.grey,
  //                         ),
  //                         child: Text("Block",
  //                             style: TextStyle(color: Colors.white)),
  //                         onPressed: () {
  //                           Navigator.of(context).pop(true);
  //                         }),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}