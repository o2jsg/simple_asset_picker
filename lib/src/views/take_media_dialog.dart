import 'package:flutter/material.dart';
import 'package:simple_asset_picker/src/views/picker_asset_grid.dart';
import 'package:simple_asset_picker/src/views/picker.dart';

class TakeMediaDialog extends StatelessWidget {
  const TakeMediaDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pickerConfig = Picker.pickerConfig;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    pickerConfig.labelChoiceCameraType,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop(CameraType.image);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      pickerConfig.labelMakePhoto,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop(CameraType.video);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      pickerConfig.labelMakeVideo,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
