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










- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Number In Phone";
    
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    [self checkAddressBookAccess];
    [self reloadCheeseFunction];
    
    

   

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
        UIAlertView *contactAddedAlert = [[UIAlertView alloc]initWithTitle:@"Contact Added" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [contactAddedAlert show];

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
    CATransition *leftAnimation = [CATransition animation];
    leftAnimation.type = kCATransitionFromLeft;
    leftAnimation.duration = 0.3;
    [_Name.layer addAnimation:leftAnimation forKey:nil];
    
    _Name.hidden = NO;
    CATransition *rightAnimation = [CATransition animation];
    rightAnimation.type = kCATransitionFromRight;
    rightAnimation.duration = 0.3;
    [_Number.layer addAnimation:rightAnimation forKey:nil];
    
    _Number.hidden = NO;
}

- (void)reloadCheeseFunction
{
    NSArray *cheesyArray = @[@"Are you religious? Because you're the answer to all my prayers.", @"Do you have a Band-Aid? Because I just scraped my knee falling for you.", @"I'm not a photographer, but I can picture me and you together.",
                             @"I seem to have lost my phone number. Can I have yours?", @"You look cold. Want to use me as a blanket?"];
    uint32_t rnd = arc4random_uniform([cheesyArray count]);
    NSString *randomCheese = [cheesyArray objectAtIndex:rnd];
    
    
    cheesyTextView.text = randomCheese;
    [cheesyTextView setUserInteractionEnabled:NO];
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
