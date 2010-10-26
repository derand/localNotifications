    //
//  mainViewController.m
//  backgroundMusic
//
//  Created by maliy on 7/15/10.
//  Copyright 2010 interMobile. All rights reserved.
//

#import "mainViewController.h"


@implementation mainViewController

#pragma mark lifeCycle

- (id) init
{
	if (self = [super init])
	{
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

#pragma mark -

- (void) setNotificationByDate:(NSDate *) dt
					   message:(NSString *) msg
						 sound:(BOOL) useSound
{
	UIApplication *app = [UIApplication sharedApplication];
	NSArray *oldNotifications = [app scheduledLocalNotifications];
	
 	if ([oldNotifications count] > 0)
	{
		[app cancelAllLocalNotifications];
	}
	
	UILocalNotification* alarm = [[[UILocalNotification alloc] init] autorelease];
	if (alarm)
	{
		alarm.fireDate = dt;
		alarm.timeZone = [NSTimeZone defaultTimeZone];
		alarm.repeatInterval = 0;
		if (useSound)
		{
			alarm.soundName = @"none.caf";
		}
		alarm.alertBody = msg;
//		alarm.applicationIconBadgeNumber = 0;
//		alarm.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"test", nil];
		[app scheduleLocalNotification:alarm];
    }
}

- (void) sendBtnPress:(id) sender
{
	NSString *errStr = nil;
	if (tf.text && ![@"" isEqualToString:tf.text])
	{
		if ([[NSDate date] compare:dp.date]==NSOrderedAscending)
		{
			[self setNotificationByDate:dp.date
								message:tf.text
								  sound:YES];
		}
		else
		{
			errStr = NSLocalizedString(@"Selected date in past", @"");
		}
	}
	else
	{
		errStr = NSLocalizedString(@"You should enter text", @"");
	}

	if (errStr)
	{
		UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
													 message:errStr
													delegate:nil
										   cancelButtonTitle:NSLocalizedString(@"I will fix it", @"")
										   otherButtonTitles:nil];
		[av show];
		[av release];
	}
}

#pragma mark -
#pragma mark UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *) textField
{
	[textField resignFirstResponder];
	return YES;
}


#pragma mark -

- (void) viewWillAppear:(BOOL)animated
{
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	[super loadView];
	
	self.navigationItem.title = NSLocalizedString(@"local Notification", @"");
	
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	
	UIView *contentView = [[UIView alloc] initWithFrame:screenRect];
	contentView.autoresizesSubviews = YES;
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	contentView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
	
	self.view = contentView;
	[contentView release];

	CGRect rct = self.navigationController.navigationBar.bounds;
	UITextField *_tf = [[UITextField alloc] initWithFrame:
						CGRectMake(rct.origin.x+5.0, rct.origin.y+7.0,
								   rct.size.width-10.0, rct.size.height-14.0)];
	_tf.backgroundColor = [UIColor clearColor];
	_tf.borderStyle = UITextBorderStyleBezel;
	_tf.textColor = [UIColor blackColor];
	_tf.font = [UIFont systemFontOfSize:17.0];
	_tf.placeholder = NSLocalizedString(@"Enter local notification mesasge there",@"");
	_tf.backgroundColor = [UIColor whiteColor];
	_tf.autocorrectionType = UITextAutocorrectionTypeNo;
	_tf.keyboardType = UIKeyboardTypeDefault;
	_tf.returnKeyType = UIReturnKeyDone;
	_tf.delegate = self;
	_tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf = [_tf retain];
	[self.view addSubview:tf];
	[_tf release];
	
	rct.origin.y += rct.size.height;
	
	UIDatePicker *_dt = [[UIDatePicker alloc] initWithFrame:rct];
	[_dt setDatePickerMode:UIDatePickerModeDateAndTime];
	_dt.date = [[NSDate date] dateByAddingTimeInterval:60.0];
	dp = [_dt retain];
	[self.view addSubview:dp];
	[_dt release];
	
	rct = self.navigationController.navigationBar.bounds;
	rct.origin.y = dp.frame.origin.y+dp.frame.size.height+3.0;
	UIButton *_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	_btn.frame = rct;
	[_btn setTitle:NSLocalizedString(@"Send", @"") forState:UIControlStateNormal];
	[_btn addTarget:self action:@selector(sendBtnPress:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_btn];

	
//	[self setNotificationByDate:[[NSDate date] dateByAddingTimeInterval:10.0]
//						message:@"knock, knock, Neo"
//					   sound:YES];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	[tf release];
	[dp release];
}



@end
