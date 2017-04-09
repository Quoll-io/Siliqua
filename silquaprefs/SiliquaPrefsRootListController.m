#include "SiliquaPrefsRootListController.h"

@implementation SiliquaPrefsRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)respring {
	system("killall -9 SpringBoard");
}
@end


@protocol PreferencesTableCustomView
-(id)initWithSpecifier:(id)arg1;
@optional
-(CGFloat)preferredHeightForWidth:(CGFloat)arg1;
@end

@interface PSTableCell : UITableView
-(id)initWithStyle:(int)style reuseIdentifier:(id)arg2;
@end

@interface SiliquaBannerCell : PSTableCell <PreferencesTableCustomView> {

	UILabel *label;
	UILabel *underLabel;
	UILabel *otherLabel;
	UILabel *other1Label;
	UILabel *other2Label;
}
@end
@implementation SiliquaBannerCell
-(id)initWithSpecifier:(id)specifier {

	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	if (self) {

		CGRect frame = CGRectMake(0, -15, [[UIScreen mainScreen] bounds].size.width, 60);
		CGRect underFrame = CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 60);
		CGRect otherFrame = CGRectMake(0, 40, [[UIScreen mainScreen] bounds].size.width, 60);
		CGRect other1Frame = CGRectMake(0, 60, [[UIScreen mainScreen] bounds].size.width, 60);
		CGRect other2Frame = CGRectMake(0, -80, [[UIScreen mainScreen] bounds].size.width, 60);

		label = [[UILabel alloc] initWithFrame:frame];
		[label setNumberOfLines:1];
		label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:48];
		[label setText:@"Siliqua"];
		[label setBackgroundColor:[UIColor clearColor]];
		label.textColor = [UIColor blackColor];
		label.textAlignment = NSTextAlignmentCenter;

		underLabel = [[UILabel alloc] initWithFrame:underFrame];
		[underLabel setNumberOfLines:1];
		underLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
		[underLabel setText:@"Your AirPods are now useful!"];
		[underLabel setBackgroundColor:[UIColor clearColor]];
		underLabel.textColor = [UIColor grayColor];
		underLabel.textAlignment = NSTextAlignmentCenter;

		otherLabel = [[UILabel alloc] initWithFrame:otherFrame];
		[otherLabel setNumberOfLines:1];
		otherLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
		[otherLabel setText:@"Created by LaughingQuoll"];
		[otherLabel setBackgroundColor:[UIColor clearColor]];
		otherLabel.textColor = [UIColor grayColor];
		otherLabel.textAlignment = NSTextAlignmentCenter;

		other1Label = [[UILabel alloc] initWithFrame:other1Frame];
		[other1Label setNumberOfLines:1];
		other1Label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
        [other1Label setText:@""];
		[other1Label setBackgroundColor:[UIColor clearColor]];
		other1Label.textColor = [UIColor grayColor];
		other1Label.textAlignment = NSTextAlignmentCenter;

		other2Label = [[UILabel alloc] initWithFrame:other2Frame];
		[other2Label setNumberOfLines:1];
		other2Label.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:10];
		[other2Label setText:@""];
		[other2Label setBackgroundColor:[UIColor clearColor]];
		other2Label.textColor = [UIColor blackColor];
		other2Label.textAlignment = NSTextAlignmentCenter;

		[self addSubview:label];
		[self addSubview:underLabel];
		[self addSubview:otherLabel];
		[self addSubview:other1Label];
		[self addSubview:other2Label];
	}
	return self;
}

-(CGFloat)preferredHeightForWidth:(CGFloat)arg1 {

	CGFloat prefHeight = 90.0;
	return prefHeight;
}
@end
