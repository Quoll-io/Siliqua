#import "libcolorpicker.h" // local since it's in or proj folder

#import "Preferences/PSListController.h"
#import "Preferences/PSSpecifier.h"
#import "Preferences/NSTask.h"

#import <notify.h>

@interface DoubleTapListController: PSListController
@end

@implementation DoubleTapListController
-(id)specifiers {

    if(_specifiers == nil) {

        _specifiers = [[self loadSpecifiersFromPlistName:@"DoubleTap" target:self] retain];
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
