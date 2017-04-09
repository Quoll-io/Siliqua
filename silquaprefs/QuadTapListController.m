#import "libcolorpicker.h" // local since it's in or proj folder

#import "Preferences/PSListController.h"
#import "Preferences/PSSpecifier.h"
#import "Preferences/NSTask.h"

#import <notify.h>

@interface QuadTapListController: PSListController
@end

@implementation QuadTapListController
-(id)specifiers {

    if(_specifiers == nil) {

        _specifiers = [[self loadSpecifiersFromPlistName:@"QuadTap" target:self] retain];
    }
    return _specifiers;
}
- (void)viewWillAppear:(BOOL)animated
{
	[self clearCache]; // old
	[self reload];// old
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{


	[super viewDidAppear:animated];
}

@end
