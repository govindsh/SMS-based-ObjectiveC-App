//
//  main.m
//  SMS_tester
//
//  Created by Srikkanth Govindaraajan on 9/25/14.
//  Copyright (c) 2014 Srikkanth Govindaraajan. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //Create varaiable for phonenumber and message
        char phoneNumber[12];
        char textMessage[200];
        
        NSLog(@"Please enter the reciepients phone number (including country code): ");
        scanf("%[^\n]s",phoneNumber);
        
        NSLog(@"Please enter your text message (maximum 200 characters): ");
        scanf(" %[^\n]s",textMessage);
        
        NSString * phNumber;
        NSString * tMsg;
        
        phNumber = [NSString stringWithCString:phoneNumber];
        tMsg = [NSString stringWithCString:textMessage];
        
        if ([phNumber length] < 8) {
            NSLog(@"ERROR: Please enter phone number with atleast 8 digits!!\n");
        }
        else {
            NSLog(@"Sending text message...");
            
            // https://rest.nexmo.com/sms/json?api_key=98375f85&api_secret=9e50645f&from=12084375562&to=15135508322&text=Welcome+to+Nexmo
            
            //Swap user's input in the Nexmo API URL
            
            NSString * urlString = [NSString stringWithFormat:@"https://rest.nexmo.com/sms/json?api_key=98375f85&api_secret=9e50645f&from=12084375562&to=%@&text=%@", phNumber, tMsg];
            urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            //Create URL
            NSURL * url = [NSURL URLWithString:urlString];
            
            //Create Request
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            
            //Send request to Nexmo computer
            NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            
            NSString * dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", dataString);
            
        }
    }
    return 0;
}
