//
//  ZYPhotoManager.m
//  GXDZ
//
//  Created by ZYP OnTheRoad on 2020/6/22.
//  Copyright © 2020 ZYP OnTheRoad. All rights reserved.
//

#import "ZYPhotoManager.h"

@implementation ZYPhotoManager
#pragma mark- 保存相片到自己定义的相册
+ (void)savePhotoWithImage:(UIImage *)image albumTitel:(NSString *)albumTitel completed:(void(^)(BOOL success, NSError *error))completed {
    [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
        //1. 创建(修改)相册的请求
        PHAssetCollectionChangeRequest *createAlbumRequest = nil;
        //根据相册名称尝试获取相册
        PHAssetCollection *album = [self fetchAlbumWithAlbumTitel:albumTitel];
        if (album) {
            //根据指定的相册创建该相册的(修改)请求
            createAlbumRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
        }
        else {
            //根据指定的标题创建名为该标题的相册的修改)请求
            createAlbumRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitel];
        }
        //2.创建向照片库添加新相片的请求
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
     
        //3.将指定的相片添加到相册。
        PHObjectPlaceholder *placeholder = assetChangeRequest.placeholderForCreatedAsset;
        [createAlbumRequest addAssets:@[placeholder]];
        
    } completionHandler:completed];
}


#pragma mark- 获取相册
/// 获取指定标题的相册
/// @param albumTitel 指定的相册标题
+ (PHAssetCollection *)fetchAlbumWithAlbumTitel:(NSString *)albumTitel {
    //检索指定类型和子类型的相册
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //遍历所有检索到的相册
    for (PHAssetCollection *album in result) {
        //检索到的相册的本地化名称是否与指定的相册名称一致
        if ([album.localizedTitle isEqualToString:albumTitel]) return album;
    }
    return nil;
}


    // PHPhotoLibrary 相簿(所有相册的集合)
    // PHAssetCollection 相册(所有相片的集合)
    // PHAsset 相片

    //PHAssetCollectionChangeRequest
    //创建、删除或修改照片资源集合的请求，用于照片库更改块中 PHAssetCollectionChangeRequest
    //PHAssetChangeRequest
    //创建、删除、更改照片资源的元数据或编辑照片资源内容的请求，以便在照片库更改块中使用。

    
    //保存相片到自己定义的相册
    //1.创建自定义相册
    //2.添加相片到系统相册
    //3.拷贝系统相册相册到自定义相册

@end
