//
//  main.m
//  MacClosureDemo
//
//  Created by zuopengliu on 11/6/2018.
//

#import <Foundation/Foundation.h>



int main(int argc, const char * argv[])
{
    @autoreleasepool{
        for (int i = 0; i < argc; i++) {
            printf("argv[%i] = %s\n", i, argv[i]);
        }
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
