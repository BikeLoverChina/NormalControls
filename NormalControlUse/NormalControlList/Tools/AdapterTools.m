//
//  AdapterTools.m
//  NormalControlUse
//
//  Created by Apple on 16/8/6.
//  Copyright © 2016年 ywj. All rights reserved.
//

#import "AdapterTools.h"

@implementation AdapterTools

+ (instancetype)getInstance {
    static AdapterTools *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AdapterTools alloc] init];
    });
    return instance;
}

+ (CGSize)adapterLabelSizeForFont:(NSString *)title font:(UIFont *)font {
    CGSize size = [[self class] stringFontSizeWithString:title
                                                    font:font
                                       constrainedToSize:CGSizeMake(DBL_MAX, DBL_MAX)];
    
    return size;
}

+ (CGFloat)adapterLabelHeightForFontSize:(CGFloat)fontSize {
    
    CGSize size = [[self class] adapterLabelSizeForSizeKey:@"测试数据" fontSize:fontSize];
    return size.height;
}

- (CGSize)injectDataForLabel:(UILabel *)label title:(NSString *)title fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing width:(CGFloat)width {
    return [self injectDataForLabel:label title:title fontSize:fontSize lineSpacing:lineSpacing linesCount:0 width:width lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)injectDataForLabel:(UILabel *)label title:(NSString *)title fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing linesCount:(CGFloat)linesCount width:(CGFloat)width {
    return [self injectDataForLabel:label title:title fontSize:fontSize lineSpacing:lineSpacing linesCount:linesCount width:width lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)injectDataForLabel:(UILabel *)label title:(NSString *)title fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing linesCount:(CGFloat)linesCount width:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode{
    
    if (!title) {
        return CGSizeZero;
    }
    
    //先计算是否超过1行
    CGSize oneSize = [[self class] adapterLabelSizeForSizeKey:title fontSize:fontSize];
    if (width > oneSize.width) {
        lineSpacing = 0;
    }
    
    CGFloat textHeight = [self textSizeWithConstraintWidth:title width:width attributes:[self titleAttributes:lineBreakMode fontSize:fontSize lineSpacing:lineSpacing] linesCount:linesCount].height;
    if (linesCount == 0) {
        label.attributedText = [self titleAttributedString:title fontSize:fontSize lineSpacing:lineSpacing lineBreakMode:lineBreakMode];
    }
    else {
        label.attributedText = [self titleAttributedString:title fontSize:fontSize lineSpacing:lineSpacing lineBreakMode:NSLineBreakByTruncatingTail];
    }
    
    
    return CGSizeMake(width, textHeight);
}

#pragma mark- Private
+ (CGSize)stringFontSizeWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size
{
    if (string == nil || [string isEqualToString:@""] || font == nil){
        
        return CGSizeMake(0, 0);
    }
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string
                                                                         attributes:@{NSFontAttributeName: font}];
    CGRect rect = [attributedText boundingRectWithSize:size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    return rect.size;
}

+ (CGSize)adapterLabelSizeForSizeKey:(NSString *)title fontSize:(CGFloat)fontSize {
    
    UIFont *oneFont = [UIFont systemFontOfSize:fontSize];
    CGSize size = [[self class] adapterLabelSizeForFont:title font:oneFont];
    
    return size;
}

- (CGSize)textSizeWithConstraintWidth:(NSString *)title width:(CGFloat)width attributes:(NSDictionary *)attributes linesCount:(NSInteger)linesCount {
    return [self textSizeWithConstraintSize:title size:CGSizeMake(width, CGFLOAT_MAX) attributes:attributes linesCount:linesCount];
}

- (NSDictionary *)titleAttributes:(NSLineBreakMode)lineBreakMode fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing {
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return [self textFont:font lineSpacing:lineSpacing lineBreakMode:lineBreakMode];
}

- (NSDictionary *)textFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing lineBreakMode:(NSLineBreakMode)lineBreakMode {
    NSMutableDictionary *mdictAttri = [NSMutableDictionary dictionary];
    mdictAttri[NSFontAttributeName] = font;
    //    mdictAttri[NSForegroundColorAttributeName] = color;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpacing;
    paragraph.lineBreakMode = lineBreakMode;
    mdictAttri[NSParagraphStyleAttributeName] = paragraph;
    return [mdictAttri copy];
}

- (CGSize)textSizeWithConstraintSize:(NSString *)title size:(CGSize)size attributes:(NSDictionary *)attributes linesCount:(NSInteger)linesCount {
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:title attributes:attributes];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(size.width, size.height)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    
    unsigned numberOfLines, index = 0;
    unsigned numberOfGlyphs = [layoutManager numberOfGlyphs];
    NSRange lineRange;
    for (numberOfLines = 0, index = 0; index < numberOfGlyphs; numberOfLines++){
        (void) [layoutManager lineFragmentRectForGlyphAtIndex:index
                                               effectiveRange:&lineRange];
        index = NSMaxRange(lineRange);
    }
    
    CGFloat maxLinesCountHeight = (linesCount == 0 ? CGFLOAT_MAX : 0.0);
    CGFloat lineSpacingToMinus = 0.0;
    if (numberOfLines == 1) {
        NSMutableParagraphStyle *paragraph = attributes[NSParagraphStyleAttributeName];
        lineSpacingToMinus = paragraph.lineSpacing;
    }
    //    NSLog(@"@@@@@@@@@@");
    if (linesCount > 0) {
        NSString *singleLine = @"yL意,.";
        NSString *resultLine = [singleLine copy];
        for (NSInteger index = 0; index < linesCount - 1; index++) {
            resultLine = [resultLine stringByAppendingString:@"\n"];
            resultLine = [resultLine stringByAppendingString:singleLine];
        }
        maxLinesCountHeight = [resultLine boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:NULL].size.height;
    }
    CGFloat currentHeight = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:NULL].size.height;
    currentHeight = currentHeight - lineSpacingToMinus;
    return CGSizeMake(size.width, MIN(currentHeight, maxLinesCountHeight));
}

- (NSAttributedString *)titleAttributedString:(NSString *)title fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing lineBreakMode:(NSLineBreakMode)lineBreakMode{
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:title attributes:[self titleAttributes:lineBreakMode fontSize:fontSize lineSpacing:lineSpacing]];
    return att;
}

@end
