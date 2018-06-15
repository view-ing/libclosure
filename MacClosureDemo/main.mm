//
//  main.m
//  MacClosureDemo
//
//  Created by zuopengliu on 11/6/2018.
//

#import <Foundation/Foundation.h>
#import "BDBlockLayout.h"
#import "TestBlock.h"


void testBlock(void);
void testBlock(void)
{
    
}


typedef void (^void_block_t)(void);

void_block_t getBlock(void)
{
    __block int i = 10;
    void_block_t blk = ^{
        double d = 123.0;
        printf("i = %ld, d = %lf\n", (long)i, d);

        i = 200;
        printf("i = %ld, d = %lf\n", (long)i, d);
    };
    
    struct BDNSBlockLayout *blkLayout = get_Block_layout((__bridge void*)blk);
    struct BDNSBlockDescriptor_1 *desc1 = get_Block_descriptor_1(blkLayout);
    struct BDNSBlockDescriptor_2 *desc2 = get_Block_descriptor_2(blkLayout);
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(blkLayout);

    
    return blk;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool{
        for (int i = 0; i < argc; i++) {
            printf("argv[%i] = %s\n", i, argv[i]);
        }
        
        void_block_t simple_block = getBlock();
        simple_block();
        
        testAllBlocks();
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
