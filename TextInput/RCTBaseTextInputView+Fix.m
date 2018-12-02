//
//  RCTBaseTextInputView+Fix.m
//
//  Copyright © 2018年 Leu Duc Quy. All rights reserved.
//

#import "RCTBaseTextInputView+Fix.h"

@implementation RCTBaseTextInputView (Fix)
- (NSString *)text
{
    return [self attributedText].string;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  return [text canBeConvertedToEncoding:NSASCIIStringEncoding];
}
- (void)setText:(NSString *)text
{
    if (self.attributedText.length > 0) {
        //copy the attributes
        NSRange range = NSMakeRange(self.attributedText.length-1, self.attributedText.length);
        NSDictionary *attributes = [self.attributedText attributesAtIndex:0 effectiveRange:&range];
        NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
        NSMutableAttributedString *primaryStringMutable = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        //change the string
        [primaryStringMutable setAttributedString:newString];
        [self setAttributedText:[[NSAttributedString alloc] initWithAttributedString:primaryStringMutable]];
    } else {
        [self setAttributedText:[[NSAttributedString alloc] initWithString: text]];
    }
}
@end
