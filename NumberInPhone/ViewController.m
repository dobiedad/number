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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Manage Contacts";
    
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    [self checkAddressBookAccess];
}
- (IBAction)btnCreateNewContactClicked:(id)sender {
    NSString *Name;
    NSString *Number;
        Name = @"Cheesy";
        Number = @"2015552398";
    
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
