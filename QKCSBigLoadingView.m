//
//  QKLoadingHUDView.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBigLoadingView.h"
#import "AppDelegate.h"
@interface QKCSBigLoadingView ()

@property (strong, nonatomic) UIWindow *keyWindow;
@property (strong, nonatomic) UIImageView *indicatorImageView;
@property (strong,nonatomic) UIViewController *root;

@end

@implementation QKCSBigLoadingView

- (instancetype)initHUDView {
    _root = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
  while (_root.presentedViewController != nil) {
    _root = _root.presentedViewController;
  }

    self = [super initWithFrame:_root.view.frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30.0, 30.0)];
       self.indicatorImageView.center = self.center;
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        
        for (int i = 1; i < 33; i++) {
            NSString *imageName = [NSString stringWithFormat:@"common_loader_small_000%d", i];
            if (i > 9) {
                imageName = [NSString stringWithFormat:@"common_loader_small_00%d", i];
            }
            [imageArray addObject:[UIImage imageNamed:imageName]];
        }
        [self.indicatorImageView setContentMode:UIViewContentModeScaleAspectFit];
        self.indicatorImageView.animationImages = imageArray;
        self.indicatorImageView.animationDuration = 1.0;
        self.indicatorImageView.alpha = 1.0;
        [self.indicatorImageView startAnimating];
         self.indicatorImageView.tag = 100;
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)setIsAnimating:(BOOL)isAnimating{
  if (isAnimating) {
    [self showIndicator];
  }else{
    [self hideIndicator];
  }
}
- (void)showIndicator {
  if(![self.root.view isDescendantOfView:self.indicatorImageView])
  {   //myView is not subview of self.view, add it.
    [_root.view addSubview:self.indicatorImageView];
    
    [_root.view  bringSubviewToFront:self.indicatorImageView];
    

  }
 
 
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations: ^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)hideIndicator {
    [UIView animateWithDuration:.2 animations: ^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.alpha = 0.0;
    } completion: ^(BOOL finished) {
        if (finished) {
          for (UIView *view in self.root.view.subviews ) {
            if (view.tag == 100) {
               [view removeFromSuperview];
            }
          }
         
          
        }
    }];
}


@end
