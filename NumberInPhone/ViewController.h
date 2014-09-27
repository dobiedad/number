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

@interface ViewController : UIViewController

@property (nonatomic, assign) ABAddressBookRef addressBook;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Number;
@property (weak, nonatomic) IBOutlet NSArray *cheesyArray;

@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *refresh;
@property (weak, nonatomic) IBOutlet UITextView *cheesyTextView;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (weak, nonatomic) IBOutlet UILabel *putInNumber;
@property (weak, nonatomic) IBOutlet UILabel *callLabel;

@end
