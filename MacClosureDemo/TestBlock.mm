//
//  TestBlock.m
//  MacClosureDemo
//
//  Created by zuopengl on 2018/6/15.
//

#import "TestBlock.h"
#include "BDBlockLayout.h"



typedef void (^void_block_t)(void);
typedef void (^int_block_t)(int);
typedef void (^id_block_t)(id);

@implementation TestBlock

+ (void)passVoidBlock:(void_block_t)blk
{
    if (!blk) return;
    
    struct BDNSBlockLayout *blkLayout = get_Block_layout((__bridge void*)blk);
    struct BDNSBlockDescriptor_1 *desc1 = get_Block_descriptor_1(blkLayout);
    struct BDNSBlockDescriptor_2 *desc2 = get_Block_descriptor_2(blkLayout);
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(blkLayout);
    
    if (blk) blk();
}

+ (void)passIntBlock:(int_block_t)blk
{
    if (!blk) return;
    
    struct BDNSBlockLayout *blkLayout = get_Block_layout((__bridge void*)blk);
    struct BDNSBlockDescriptor_1 *desc1 = get_Block_descriptor_1(blkLayout);
    struct BDNSBlockDescriptor_2 *desc2 = get_Block_descriptor_2(blkLayout);
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(blkLayout);
    
    if (blk) blk(100);
}

+ (void)passIdBlock:(id_block_t)blk
{
    if (!blk) return;
    
    struct BDNSBlockLayout *blkLayout = get_Block_layout((__bridge void*)blk);
    struct BDNSBlockDescriptor_1 *desc1 = get_Block_descriptor_1(blkLayout);
    struct BDNSBlockDescriptor_2 *desc2 = get_Block_descriptor_2(blkLayout);
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(blkLayout);
    
    if (blk) blk(@"String");
}

+ (void_block_t)getVoidBlock
{
    void_block_t blk = ^{
        
    };
    
    struct BDNSBlockLayout *blkLayout = get_Block_layout((__bridge void*)blk);
    struct BDNSBlockDescriptor_1 *desc1 = get_Block_descriptor_1(blkLayout);
    struct BDNSBlockDescriptor_2 *desc2 = get_Block_descriptor_2(blkLayout);
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(blkLayout);
    
    return blk;
}

+ (int_block_t)getIntBlock
{
    double d = 24.5;
    NSString *str = [NSString stringWithFormat:@"haha"];
    NSObject *obj = [NSObject new];
    
    __weak typeof(obj) weakObj = obj;
    int_block_t blk = ^(int i) {
        __strong typeof(weakObj) strongObj = weakObj;
        NSLog(@"d = %lf, str = %@, obj = %@", (double)d, str, strongObj);
    };
    
    struct BDNSBlockLayout *blkLayout = get_Block_layout((__bridge void*)blk);
    struct BDNSBlockDescriptor_1 *desc1 = get_Block_descriptor_1(blkLayout);
    struct BDNSBlockDescriptor_2 *desc2 = get_Block_descriptor_2(blkLayout);
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(blkLayout);
    
    return blk;
}

+ (id_block_t)getIdBlock
{
    __block int blk_i = 10;
    __block NSString *blk_str = [NSString stringWithFormat:@"haha"];
    id_block_t blk = ^(id obj) {
       NSLog(@"blk_i = %ld, blk_str = %@, obj = %@", (long)blk_i, blk_str, obj);
        
        blk_i = 100;
        blk_str = @"xixixi";
        
        NSLog(@"blk_i = %ld, blk_str = %@, obj = %@", (long)blk_i, blk_str, obj);
    };
    
    struct BDNSBlockLayout *blkLayout = get_Block_layout((__bridge void*)blk);
    struct BDNSBlockDescriptor_1 *desc1 = get_Block_descriptor_1(blkLayout);
    struct BDNSBlockDescriptor_2 *desc2 = get_Block_descriptor_2(blkLayout);
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(blkLayout);
    
    return blk;
}

+ (void)declInnerBlock
{
    void_block_t blk = ^{
        
    };
    
    
    struct BDNSBlockLayout *blkLayout = get_Block_layout((__bridge void*)blk);
    struct BDNSBlockDescriptor_1 *desc1 = get_Block_descriptor_1(blkLayout);
    struct BDNSBlockDescriptor_2 *desc2 = get_Block_descriptor_2(blkLayout);
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(blkLayout);
    
    // blk();
}


+ (void)callInnerBlock
{
    void_block_t blk = ^{
        
    };
    
    struct BDNSBlockLayout *blkLayout = get_Block_layout((__bridge void*)blk);
    struct BDNSBlockDescriptor_1 *desc1 = get_Block_descriptor_1(blkLayout);
    struct BDNSBlockDescriptor_2 *desc2 = get_Block_descriptor_2(blkLayout);
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(blkLayout);
    
     blk();
}


@end


void testAllBlocks()
{
    [TestBlock passVoidBlock:^{
        
    }];
    
    [TestBlock passIntBlock:^(int i) {
        
    }];
    
    [TestBlock passIdBlock:^(id obj) {
        
    }];
    
    void_block_t v_blk = [TestBlock getVoidBlock];
    if (v_blk) v_blk();
    
    int_block_t i_blk = [TestBlock getIntBlock];
    if (i_blk) i_blk(500);
    
    id_block_t id_blk = [TestBlock getIdBlock];
    if (id_blk) id_blk(@"string arg");
    
    [TestBlock declInnerBlock];
    
    [TestBlock callInnerBlock];
}
