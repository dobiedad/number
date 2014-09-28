//
//  ViewController.m
//  NumberInPhone
//
//  Created by Leo Mdivani on 27/09/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize addressBook;
@synthesize cheesyArray;
@synthesize yesButton;
@synthesize refresh;
@synthesize cheesyTextView;
@synthesize putInNumber;
@synthesize noButton;
@synthesize btnCreateNewContact;
@synthesize callLabel;
@synthesize userImage;
@synthesize phoneImage;
@synthesize background;






- (void)viewDidLoad
{
    [super viewDidLoad];
    [self paralax];

    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    [self checkAddressBookAccess];
    [self reloadCheeseFunction];
    putInNumber.hidden = YES;
    btnCreateNewContact.hidden =YES;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gender.png"]];
}

- (void)paralax
{
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-50);
    verticalMotionEffect.maximumRelativeValue = @(50);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-50);
    horizontalMotionEffect.maximumRelativeValue = @(50);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [background addMotionEffect:group];
}
- (IBAction)btnCreateNewContactClicked:(id)sender {
    
    NSString *Name = self.Name.text;
    NSString *Number = self.Number.text;
    
    if (Name.length > 2 && Number.length > 6 ) {
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
        ABRecordRef new = ABPersonCreate();
        ABRecordSetValue(new, kABPersonFirstNameProperty, (__bridge CFStringRef)Name, nil);
        
        ABMutableMultiValueRef Numbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(Numbers, (__bridge CFStringRef)Number, kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(new, kABPersonPhoneProperty, Numbers, nil);
        
        ABAddressBookAddRecord(addressBookRef, new, nil);
        
        NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
        for (id record in allContacts){
            ABRecordRef thisContact = (__bridge ABRecordRef)record;
            if (CFStringCompare(ABRecordCopyCompositeName(thisContact),
                                ABRecordCopyCompositeName(new), 0) == kCFCompareEqualTo){
                //The contact already exists!
                UIAlertView *contactExistsAlert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"There can only be one %@", Name] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [contactExistsAlert show];
                return;
            }
        }
        ABAddressBookSave(addressBookRef, nil);
        UIAlertView *contactAddedAlert = [[UIAlertView alloc]initWithTitle:@"Saved! Ill be in touch soon " message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [contactAddedAlert show];
        self.Name.text=@"";
        self.Number.text=@"";
        [self hideSecondBit];
        [self showFirstBit];

    }
    else {
        UIAlertView *emptyAlert = [[UIAlertView alloc]initWithTitle:@"Thats a fake contact. Try again with the correct details" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [emptyAlert show];
    }
}


#pragma mark Address Book Access
// Check the authorization status of our application for Address Book
-(void)checkAddressBookAccess
{
    switch (ABAddressBookGetAuthorizationStatus())
    {
            // Update our UI if the user has granted access to their Contacts
        case  kABAuthorizationStatusAuthorized:
            break;
            // Prompt the user for access to Contacts if there is no definitive answer
        case  kABAuthorizationStatusNotDetermined :
            [self requestAddressBookAccess];
            break;
            // Display a message if the user has denied or restricted access to Contacts
        case  kABAuthorizationStatusDenied:
        case  kABAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning"
                                                            message:@"Permission was not granted for Contacts."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}

// Prompt the user for access to their Address Book data
-(void)requestAddressBookAccess
{
    ViewController * __weak weakSelf = self;
    
    ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error)
                                             {
                                                 if (granted)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         
                                                     });
                                                 }
                                             });
}



- (IBAction)yesButton:(id)sender {

    [self hideFirstBit];


}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)hideFirstBit
{
    refresh.hidden = YES;
    cheesyTextView.hidden = YES;
    yesButton.hidden = YES;
    noButton.hidden = YES;
    callLabel.hidden = YES;
    _Name.hidden = NO;
    btnCreateNewContact.hidden =NO;

    putInNumber.hidden = NO;

    _Number.hidden = NO;
    userImage.hidden = NO;
    phoneImage.hidden = NO;


}
- (void)showFirstBit
{
    refresh.hidden = NO;
    cheesyTextView.hidden = NO;
    yesButton.hidden = NO;
    noButton.hidden = NO;
    callLabel.hidden = NO;
    _Name.hidden = YES;
    btnCreateNewContact.hidden =YES;
    putInNumber.hidden = YES;
    _Number.hidden = YES;
    userImage.hidden = YES;
    phoneImage.hidden = YES;
    
}
- (void)hideSecondBit
{
    putInNumber.hidden = YES;
    _Number.hidden = YES;
    _Name.hidden = YES;
    btnCreateNewContact.hidden =YES;
}


- (void)reloadCheeseFunction
{
    NSArray *cheesyArray = @[@"Are you religious? Because you're the answer to all my prayers.", @"Do you have a Band-Aid? Because I just scraped my knee falling for you.", @"I'm not a photographer, but I can picture me and you together.",
                             @"I seem to have lost my phone number. Can I have yours?", @"You look cold. Want to use me as a blanket?"];
    uint32_t rnd = arc4random_uniform([cheesyArray count]);
    NSString *randomCheese = [cheesyArray objectAtIndex:rnd];
    
    
    cheesyTextView.text = randomCheese;
    [cheesyTextView setUserInteractionEnabled:NO];
    
    NSArray *callMeArray = @[@"Let me call you later?", @"Grab some coffee later?", @"Lets go out sometime?",
                             @"Its a date?", @"Me + You"];
    uint32_t callrnd = arc4random_uniform([callMeArray count]);
    NSString *callMe = [callMeArray objectAtIndex:callrnd];
    
    
    callLabel.text = callMe;
}

- (IBAction)refreshButton:(id)sender {
    [self reloadCheeseFunction];
    
}
- (IBAction)noButtonClicked:(id)sender {
    [self reloadCheeseFunction];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
