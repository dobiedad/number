//
//  ViewController.h
//  NumberInPhone
//
//  Created by Leo Mdivani on 27/09/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "FXBlurView.h"
#import <APAddressBook/APAddressBook.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>







@interface ViewController : UIViewController<UITableViewDelegate ,UITableViewDataSource,MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contactsTableView;
@property (weak, nonatomic) IBOutlet UIView *cheesyInsideView;
@property (weak, nonatomic) IBOutlet FXBlurView *tableViewContainer;
@property (weak, nonatomic) IBOutlet FXBlurView *tableViewInsideContainer;
@property (nonatomic) IBOutlet UIWebView *youtubeWebView;
@property (weak, nonatomic) IBOutlet UIButton *clickMeButton;
@property (weak, nonatomic) IBOutlet UIImageView *tapImageView;


@property (weak, nonatomic) IBOutlet UIButton *contactButton;
@property (nonatomic, assign) ABAddressBookRef addressBook;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Number;
@property (weak, nonatomic) IBOutlet UIView *youtubeWebViewContainer;
@property (weak, nonatomic) IBOutlet FXBlurView *footerButtonViewInside;
@property (weak, nonatomic) IBOutlet UIButton *contactUsButton;

@property (strong, nonatomic) IBOutlet UIView *superView;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UILabel *putInNumber;
@property (weak, nonatomic) IBOutlet UILabel *callLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateNewContact;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;
@property (weak, nonatomic) IBOutlet FXBlurView *cheesyContainer;
@property (weak, nonatomic) IBOutlet UITextView *cheesyLine;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (nonatomic) IBOutlet FXBlurView *footerButtonView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet FXBlurView *Navbar;

@property (nonatomic) IBOutlet FXBlurView *contactView;
@property (nonatomic) IBOutlet NSMutableArray *cheesyArray;
@property (nonatomic) IBOutlet APContact *currentContact;

@property (nonatomic) IBOutlet NSMutableArray *imageArray;
@property (nonatomic) IBOutlet NSArray *contactArray;
@property (nonatomic) IBOutlet NSArray *tapAnimationArray;

@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (nonatomic, strong, retain) MFMessageComposeViewController *messageComposer;






@end

