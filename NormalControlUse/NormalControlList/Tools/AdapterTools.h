//
//  AdapterTools.h
//  NormalControlUse
//
//  Created by Apple on 16/8/6.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdapterTools : NSObject

+ (instancetype)getInstance;
/*!
 @method
 @abstract   根据输入，返回一行label的高度
 @discussion
 @param      title
 @param      font
 @return     CGSize
 */
+ (CGSize)adapterLabelSizeForFont:(NSString *)title font:(UIFont *)font;
/*!
 @method
 @abstract   根据输入，返回一行label的高度
 @discussion
 @param      size
 @return     高度
 */
+ (CGFloat)adapterLabelHeightForFontSize:(CGFloat)fontSize;
/*!
 @method
 @abstract   根据提供的行间距 设置label
 @discussion
 @param      size
 @param      linesCount 
             (eg. 1.实际2行，linesCount传3,计算还是两行 
                  2.实际2行，linesCount传1,按1行算)
 @return     高度
 */
- (CGSize)injectDataForLabel:(UILabel *)label title:(NSString *)title fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width;
- (CGSize)injectDataForLabel:(UILabel *)label title:(NSString *)title fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing linesCount:(CGFloat)linesCount width:(CGFloat)width;
/*
// !!! 此方法暂时有问题 后期修复 !!!!
- (CGSize)injectDataForLabel:(UILabel *)label title:(NSString *)title fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing linesCount:(CGFloat)linesCount width:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
 */

@end
