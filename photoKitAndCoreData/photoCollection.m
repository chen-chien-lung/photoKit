//
//  photoCollection.m
//  photoKitAndCoreData
//
//  Created by Joe Chen on 2016/8/3.
//  Copyright © 2016年 Joe Chen. All rights reserved.
//

#import "photoCollection.h"
#import "photoCell.h"


@import Photos;
@interface photoCollection ()

@property (strong) PHCachingImageManager *manager;
@property (strong) PHFetchResult *fetchResult;
@end

@implementation photoCollection


static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    
    _manager = [PHCachingImageManager new];
    _fetchResult = [PHFetchResult new];
    PHFetchOptions * option= [PHFetchOptions new];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];

    _fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];

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

    return [_fetchResult count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    photoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    // Configure the cell
    
    [self.manager requestImageForAsset:_fetchResult[indexPath.row] targetSize:cell.pics.frame.size contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        cell.pics.image = result;
    }];
    
    PHAsset * img = _fetchResult[indexPath.row];
    
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:img.creationDate];
    
    NSArray * resource = [PHAssetResource assetResourcesForAsset:img];
    NSString * imageName =[resource.firstObject originalFilename];
    
    CLLocation * location = img.location;
    
    cell.createDate.text = [NSString stringWithFormat:@"Create Date :%@",date];
    cell.photoName.text =  [NSString stringWithFormat:@"Photo Name :%@",imageName];
    cell.lat.text = [NSString stringWithFormat:@"latitude:%f", location.coordinate.latitude];
    cell.lon.text = [NSString stringWithFormat:@"longitude:%f", location.coordinate.longitude];
    
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor blueColor].CGColor;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
