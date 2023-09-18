// Package imports:
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Contact?> getDeviceContact() async {
  try {
    final permissionStatus = await Permission.contacts.request();
    if (permissionStatus == PermissionStatus.granted) {
      return await ContactsService.openDeviceContactPicker();
    } else if ([PermissionStatus.denied, PermissionStatus.permanentlyDenied]
        .contains(permissionStatus)) {
      openAppSettings();
    }
  } catch (e) {
    print('## ERROR: failed to get contact: $e');
  }

  return null;
}
