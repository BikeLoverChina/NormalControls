//
//  UILabelViewController.m
//  NormalControlUse
//
//  Created by Apple on 16/8/6.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "UILabelViewController.h"
#import "Constants.h"
#import "AdapterTools.h"

@interface UILabelViewController ()

/*!
 @property
 @abstract 单行
 */
@property (nonatomic, strong) UILabel *singleLineLblLeft;
/*!
 @property
 @abstract 单行
 */
@property (nonatomic, strong) UILabel *singleLineLblRight;
/*!
 @property
 @abstract 两行
 */
@property (nonatomic, strong) UILabel *twoLinesLbl;
/*!
 @property
 @abstract 多行
 */
@property (nonatomic, strong) UILabel *moreLinesLbl;

@end

@implementation UILabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"UILabel";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpViews];
}

- (void)setUpViews
{
    [self.view addSubview:self.singleLineLblLeft];
    [self.view addSubview:self.singleLineLblRight];
    [self.view addSubview:self.twoLinesLbl];
}

- (CGFloat)calculateLabelHeight:(NSString *)str WithLineSpaceHeight:(CGFloat)lineSpace
{
    return 0;
}

- (UILabel *)singleLineLblLeft
{
    if (_singleLineLblLeft == nil) {
        _singleLineLblLeft = [[UILabel alloc] init];
        _singleLineLblLeft.text = @"单行高度Left";
        _singleLineLblLeft.font = [UIFont systemFontOfSize:UIFontSizeTen];
        CGSize size = [AdapterTools adapterLabelSizeForFont:_singleLineLblLeft.text font:_singleLineLblLeft.font];
        _singleLineLblLeft.frame = CGRectMake(UIMargin15, 64+20, size.width, size.height);
        _singleLineLblLeft.backgroundColor = [UIColor grayColor];
        
    }
    return _singleLineLblLeft;
}

- (UILabel *)singleLineLblRight
{
    if (_singleLineLblRight == nil) {
        _singleLineLblRight = [[UILabel alloc] init];
        _singleLineLblRight.text = @"单行高度Right";
        _singleLineLblRight.font = [UIFont systemFontOfSize:UIFontSizeTwenty];
        CGSize size = [AdapterTools adapterLabelSizeForFont:_singleLineLblRight.text font:_singleLineLblRight.font];
        _singleLineLblRight.frame = CGRectMake(ScreenSize.width-size.width - 15, 64+20, size.width, size.height);
        _singleLineLblRight.backgroundColor = [UIColor grayColor];
    }
    return _singleLineLblRight;
}

- (UILabel *)twoLinesLbl
{
    if (_twoLinesLbl == nil) {
        NSString *title = @"第31届夏季奥运会于北京时间今早7点在巴西里约热内卢开幕";
        _twoLinesLbl = [[UILabel alloc] init];
        _twoLinesLbl.text = title;
        _twoLinesLbl.font = [UIFont systemFontOfSize:UIFontSizeTwenty];
        _twoLinesLbl.numberOfLines = 0;
        _twoLinesLbl.backgroundColor = [UIColor grayColor];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = UILineSpaceTen;//调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_twoLinesLbl.text];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _twoLinesLbl.text.length)];
        _twoLinesLbl.attributedText = attributedString;
        
        CGSize size = CGSizeZero;
        
        // 1.injectDataForLabel: title: fontSize: lineSpacing: width:
//        size = [[AdapterTools getInstance] injectDataForLabel:_twoLinesLbl title:_twoLinesLbl.text fontSize:UIFontSizeTwenty lineSpacing:UILineSpaceTen width:ScreenSize.width - UIMargin15*2];
        
        // 2.injectDataForLabel: title: fontSize: lineSpacing: linesCount: width:
        /*
        size = [[AdapterTools getInstance] injectDataForLabel:_twoLinesLbl title:_twoLinesLbl.text fontSize:UIFontSizeTwenty lineSpacing:UILineSpaceTen linesCount:2 width:ScreenSize.width - UIMargin15*2];
         */
        // 3.injectDataForLabel: title: fontSize: lineSpacing: linesCount: width: lineBreakMode:lineBreakMode
//        _twoLinesLbl.lineBreakMode = NSLineBreakByTruncatingMiddle;
        size = [[AdapterTools getInstance] injectDataForLabel:_twoLinesLbl title:_twoLinesLbl.text fontSize:UIFontSizeTwenty lineSpacing:UILineSpaceTen linesCount:2 width:ScreenSize.width - UIMargin15*2 lineBreakMode:NSLineBreakByTruncatingMiddle];
        
        _twoLinesLbl.frame = CGRectMake(15, 64+20+50, size.width, size.height);
    }
    return _twoLinesLbl;
}

- (UILabel *)moreLinesLbl
{
    if (_moreLinesLbl == nil) {
        
    }
    return _moreLinesLbl;
}

@end
