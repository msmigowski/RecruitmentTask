//
//  DetailViewController.h
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 09.09.2016.
//
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "DetailView.h"

@interface DetailViewController : UIViewController

- (instancetype)initWithCharacter: (Character *)character;

@end
