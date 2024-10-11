import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PickerConfig {
  /// 기존에 선택한 사진
  final List<AssetEntity>? selectedAssets;

  /// 최대 선택가능 갯수
  final int? maxAssets;

  /// 한페이지 갯수,
  /// 30이상
  final int pageSize;

  /// Picker Type
  final RequestType requestType;

  /// 그리드 한줄에 보여줄 갯수,
  /// 3이상
  final int gridCount;

  /// 메인 색상
  final Color mainColor;

  /// 테마 밝기
  final Brightness brightness;

  /// 카메라 사용가능 여부
  final bool useCamera;

  /// 이미지를 불러오는데 실패했습니다.
  final String labelParsingError;

  /// 더 이상 선택할 수 없습니다.
  final String labelMaxAssetsReached;

  /// 완료
  final String labelDone;

  /// 전체보기
  final String labelRecentFolder;

  /// 갤러리 접근 권한이 없습니다.
  final String labelPermissionsError;

  /// 갤러리에 사진이 없습니다.
  final String labelEmplyGallery;

  /// 촬영
  final String labelChoiceCameraType;

  /// 사진 촬영
  final String labelMakePhoto;

  /// 동영상 촬영
  final String labelMakeVideo;

  /// Loading
  final String labelLoading;

  const PickerConfig({
    this.selectedAssets,
    this.maxAssets,
    this.pageSize = 30,
    this.requestType = RequestType.common,
    this.gridCount = 3,
    this.mainColor = Colors.yellowAccent,
    this.brightness = Brightness.dark,
    this.useCamera = false,
    this.labelParsingError = '이미지를 불러오는데 실패했습니다.',
    this.labelMaxAssetsReached = '더 이상 선택할 수 없습니다.',
    this.labelDone = '완료',
    this.labelRecentFolder = '전체보기',
    this.labelPermissionsError = '갤러리 접근 권한이 없습니다.',
    this.labelEmplyGallery = '갤러리에 사진이 없습니다.',
    this.labelChoiceCameraType = '촬영',
    this.labelMakePhoto = '사진 촬영',
    this.labelMakeVideo = '동영상 촬영',
    this.labelLoading = 'Loading',
  })  : assert(gridCount >= 3 && gridCount <= 5),
        assert(pageSize >= 30);
}
