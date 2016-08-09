//
//  photoCell.h
//  photoKitAndCoreData
//
//  Created by Joe Chen on 2016/8/3.
//  Copyright © 2016年 Joe Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface photoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pics;
@property (weak, nonatomic) IBOutlet UILabel *createDate;
@property (weak, nonatomic) IBOutlet UILabel *photoName;
@property (weak, nonatomic) IBOutlet UILabel *lat;
@property (weak, nonatomic) IBOutlet UILabel *lon;

@end
