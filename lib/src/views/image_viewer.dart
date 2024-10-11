import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:simple_asset_picker/src/provider/asset_path_provider.dart';
import 'package:simple_asset_picker/src/provider/asset_provider.dart';
import 'package:simple_asset_picker/src/views/picker.dart';
import 'package:simple_asset_picker/src/views/video_viewer.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class ImageViewer extends ConsumerWidget {
  const ImageViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final pickerConfig = Picker.pickerConfig;
    final previewAsset = ref.watch(previewAssetProvider)!;
    final selectedAssets = ref.watch(selectedAssetProvider);
    final isSelected = selectedAssets.contains(previewAsset);
    final count = selectedAssets.indexOf(previewAsset) + 1;
    final selectedPath = ref.watch(selectedPathProvider);

    if (selectedPath == null) {
      return const SizedBox();
    }

    final list = ref.watch(assetProvider(selectedPath.assetPathEntity.id));

    PageController controller = PageController(
      initialPage: list.indexOf(previewAsset),
    );

    controller.addListener(() => listener(controller, ref));

    return Expanded(
      child: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (value) {
              ref.watch(previewAssetProvider.notifier).update(
                    (state) => state = list[value],
                  );
            },
            children: list.map((asset) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: asset.type != AssetType.video
                    ? Hero(
                        tag: asset.id,
                        child: AssetEntityImage(
                          asset,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Material(
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  pickerConfig.labelParsingError,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : VideoViewer(asset: asset),
              );
            }).toList(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  final isAdded = ref
                      .watch(selectedAssetProvider.notifier)
                      .selectAsset(previewAsset);
                  if (!isAdded) {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          shape: const StadiumBorder(),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(milliseconds: 1500),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 24,
                          ),
                          margin: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            bottom: 15,
                          ),
                          content: Text(
                            pickerConfig.labelMaxAssetsReached,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: isSelected
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: pickerConfig.mainColor,
                        )
                      : const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(115, 155, 155, 155),
                        ),
                  alignment: Alignment.center,
                  child: isSelected
                      ? Text(
                          count.toString(),
                          style: TextStyle(
                            color: pickerConfig.brightness == Brightness.light
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textScaler: TextScaler.noScaling,
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(185, 255, 255, 255),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void listener(PageController controller, WidgetRef ref) {
    final selectedPath = ref.watch(selectedPathProvider);
    final list = ref.watch(assetProvider(selectedPath!.assetPathEntity.id));
    if (list.length < selectedPath.count &&
        controller.page! >= list.length - 3) {
      ref
          .watch(assetProvider(selectedPath.assetPathEntity.id).notifier)
          .getAssetList(getMore: true);
    }
  }
}
