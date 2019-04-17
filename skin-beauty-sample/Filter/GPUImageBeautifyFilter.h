//
//  GPUImageBeautifyFilter.h
//  BeautifyFaceDemo
//
//  Created by guikz on 16/4/28.
//  Copyright © 2016年 guikz. All rights reserved.
//

#import "GPUImage.h"

@class GPUImageCombinationFilter;
@class GPUImageSobelEdgeDetectionFilter;

@interface GPUImageBeautifyFilter : GPUImageFilterGroup {
    GPUImageBilateralFilter *bilateralFilter;
    GPUImageSobelEdgeDetectionFilter *sobelEdgeFilter;
    GPUImageCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}

/// 美肌効果
@property (nonatomic, assign)CGFloat level;//デフォルト値 0.5

/// なめらかさ
@property (nonatomic, assign)CGFloat bilateralLevel;//デフォルト値 4.0

/// 彩度
@property (nonatomic, assign)CGFloat saturationLevel;//デフォルト値 1.1

/// 明るさ
@property (nonatomic, assign)CGFloat brightnessLevel;//デフォルト値 1.1
@end
