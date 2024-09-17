import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


double getExpandedHeight(BuildContext context) {
  // Get the physical size of the device
  Size screenSize = MediaQuery.of(context).size;

  // Adjust expanded height based on device type
  if (screenSize.width < 600 && screenSize.height < 600) {
    return 0.55; // Small screen devices
  } else if (screenSize.width < 800 && screenSize.height < 800) {
    return 0.50; // Medium screen devices
  } else if (screenSize.width < 900 && screenSize.height < 900) {
    return 0.45; // Medium screen devices
  } else {
    return 0.40; // Large screen devices
  }
}


double getExpandedHeightCoursePage(BuildContext context) {
  // Get the physical size of the device
  Size screenSize = MediaQuery.of(context).size;

  // Adjust expanded height based on device type
  if (screenSize.width < 600 && screenSize.height < 600) {
    return 0.35; // Small screen devices
  } else if (screenSize.width < 800 && screenSize.height < 800) {
    return 0.30; // Medium screen devices
  } else if (screenSize.width < 900 && screenSize.height < 900) {
    return 0.25; // Medium screen devices
  } else {
    return 0.2; // Large screen devices
  }
}



double getStackHeight(BuildContext context) {
  // Get the physical size of the device
  Size screenSize = MediaQuery.of(context).size;

  // Adjust expanded height based on device type
  if (screenSize.width < 600 && screenSize.height < 600) {
    return 0.45.sh; // Small screen devices
  } else if (screenSize.width < 800 && screenSize.height < 800) {
    return 0.30.sh; // Medium screen devices
  } else if (screenSize.width < 900 && screenSize.height < 900) {
    return 0.35.sh; // Medium screen devices
  } else {
    return 0.30.sh; // Large screen devices
  }
}
