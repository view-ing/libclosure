//
//  BDBlockLayout.m
//  MacClosureDemo
//
//  Created by zuopengl on 2018/6/15.
//

#import "BDBlockLayout.h"



// Values for BDNSBlockLayout->flags to describe block objects
enum {
    BLOCK_DEALLOCATING =      (0x0001),  // runtime
    BLOCK_REFCOUNT_MASK =     (0xfffe),  // runtime
    BLOCK_NEEDS_FREE =        (1 << 24), // runtime
    BLOCK_HAS_COPY_DISPOSE =  (1 << 25), // compiler
    BLOCK_HAS_CTOR =          (1 << 26), // compiler: helpers have C++ code
    BLOCK_IS_GC =             (1 << 27), // runtime
    BLOCK_IS_GLOBAL =         (1 << 28), // compiler
    BLOCK_USE_STRET =         (1 << 29), // compiler: undefined if !BLOCK_HAS_SIGNATURE
    BLOCK_HAS_SIGNATURE  =    (1 << 30), // compiler
    BLOCK_HAS_EXTENDED_LAYOUT=(1 << 31)  // compiler
};


struct BDNSBlockLayout * get_Block_layout(void *aBlock)
{
    return (struct BDNSBlockLayout *)aBlock;
}

struct BDNSBlockDescriptor_1 * get_Block_descriptor_1(struct BDNSBlockLayout *aBlock)
{
    if (!aBlock) return NULL;
    return aBlock->descriptor;
}

struct BDNSBlockDescriptor_2 * get_Block_descriptor_2(struct BDNSBlockLayout *aBlock)
{
    if (!aBlock) return NULL;
    if (! (aBlock->flags & BLOCK_HAS_COPY_DISPOSE)) return NULL;
    uint8_t *desc = (uint8_t *)aBlock->descriptor;
    desc += sizeof(struct BDNSBlockDescriptor_1);
    return (struct BDNSBlockDescriptor_2 *)desc;
}

struct BDNSBlockDescriptor_3 * get_Block_descriptor_3(struct BDNSBlockLayout *aBlock)
{
    if (!aBlock) return NULL;
    if (! (aBlock->flags & BLOCK_HAS_SIGNATURE)) return NULL;
    uint8_t *desc = (uint8_t *)aBlock->descriptor;
    desc += sizeof(struct BDNSBlockDescriptor_1);
    if (aBlock->flags & BLOCK_HAS_COPY_DISPOSE) {
        desc += sizeof(struct BDNSBlockDescriptor_2);
    }
    return (struct BDNSBlockDescriptor_3 *)desc;
}

size_t get_Block_size(void *aBlock)
{
    return ((struct BDNSBlockLayout *)aBlock)->descriptor->size;
}

// Checks for a valid signature, not merely the BLOCK_HAS_SIGNATURE bit.
bool if_Block_has_signature(void *aBlock)
{
    return get_Block_signature(aBlock) ? true : false;
}

const char * get_Block_signature(void *aBlock)
{
    struct BDNSBlockDescriptor_3 *desc3 = get_Block_descriptor_3(get_Block_layout(aBlock));
    if (!desc3) return NULL;
    
    return desc3->signature;
}


// Values for Block_byref->flags to describe __block variables
enum {
    // Byref refcount must use the same bits as BDNSBlockLayout's refcount.
    // BLOCK_DEALLOCATING =      (0x0001),  // runtime
    // BLOCK_REFCOUNT_MASK =     (0xfffe),  // runtime
    
    BLOCK_BYREF_LAYOUT_MASK =       (0xf << 28), // compiler
    BLOCK_BYREF_LAYOUT_EXTENDED =   (  1 << 28), // compiler
    BLOCK_BYREF_LAYOUT_NON_OBJECT = (  2 << 28), // compiler
    BLOCK_BYREF_LAYOUT_STRONG =     (  3 << 28), // compiler
    BLOCK_BYREF_LAYOUT_WEAK =       (  4 << 28), // compiler
    BLOCK_BYREF_LAYOUT_UNRETAINED = (  5 << 28), // compiler
    
    BLOCK_BYREF_IS_GC =             (  1 << 27), // runtime
    
    BLOCK_BYREF_HAS_COPY_DISPOSE =  (  1 << 25), // compiler
    BLOCK_BYREF_NEEDS_FREE =        (  1 << 24), // runtime
};
