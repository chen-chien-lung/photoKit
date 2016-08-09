//
//  videoCollection.m
//  photoKitAndCoreData
//
//  Created by Joe Chen on 2016/8/3.
//  Copyright © 2016年 Joe Chen. All rights reserved.
//

#import "videoCollection.h"
#import "videoCell.h"
#import "video.h"

@import Photos;
@interface videoCollection ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong) PHCachingImageManager *manager;
@property (strong) PHFetchResult *fetchResult;
@end

@implementation videoCollection

static NSString * const reuseIdentifier = @"Cell";

NSURL * fileUrl;
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    
    _manager = [PHCachingImageManager new];
    _fetchResult = [PHFetchResult new];
    PHFetchOptions * option= [PHFetchOptions new];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    _fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:option];
    
    fileUrl = [NSURL new];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   // NSLog(@"%lu",(unsigned long)_fetchResult.count);
    return [_fetchResult count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    videoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCell" forIndexPath:indexPath];
    
    NSArray * resource = [PHAssetResource assetResourcesForAsset:_fetchResult[indexPath.row]];
    NSURL * url = [resource.firstObject fileURL];
    
    //----thumbnail
    AVURLAsset * asset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVAssetImageGenerator * generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    generator.appliesPreferredTrackTransform = true;
    //support error
    NSError * error;
    CGImageRef cgImage = [generator copyCGImageAtTime:CMTimeMake(30, 10) actualTime:nil error:&error];
    
    if(error){
        NSLog(@"error");
    }
    UIImage * image = [UIImage imageWithCGImage:cgImage];
    cell.imageview.image = image;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * resource = [PHAssetResource assetResourcesForAsset:_fetchResult[indexPath.row]];
    NSURL * url = [resource.firstObject fileURL];

    
    video * vc = (video*)[self.storyboard instantiateViewControllerWithIdentifier:@"video"];
    vc.videoUrl = url;
    [self presentViewController:vc animated:YES completion:nil];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    NSArray * resource = [PHAssetResource assetResourcesForAsset:_fetchResult[2]];
//    NSURL * url = [resource.firstObject fileURL];
//    video *vc = (video *)segue.destinationViewController;
//    vc.videoUrl = url;
//    
//}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
