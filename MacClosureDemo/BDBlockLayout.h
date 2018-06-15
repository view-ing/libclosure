//
//  BDBlockLayout.h
//  MacClosureDemo
//
//  Created by zuopengl on 2018/6/15.
//

#include <stdio.h>
#include <iostream>



struct BDNSBlockDescriptor_1 {
    uintptr_t reserved;
    uintptr_t size;
};

struct BDNSBlockDescriptor_2 {
    // requires BLOCK_HAS_COPY_DISPOSE
    void (*copy)(void *dst, const void *src);
    void (*dispose)(const void *);
};

struct BDNSBlockDescriptor_3 {
    // requires BLOCK_HAS_SIGNATURE
    const char *signature;
    const char *layout;     // contents depend on BLOCK_HAS_EXTENDED_LAYOUT
};

struct BDNSBlockLayout {
    void *isa;
    volatile int32_t flags; // contains ref count
    int32_t reserved;
    void (*invoke)(void *, ...);
    struct BDNSBlockDescriptor_1 *descriptor;
    // imported variables
};


struct BDNSBlockLayout * get_Block_layout(void *aBlock);
struct BDNSBlockDescriptor_1 * get_Block_descriptor_1(struct BDNSBlockLayout *aBlock);
struct BDNSBlockDescriptor_2 * get_Block_descriptor_2(struct BDNSBlockLayout *aBlock);
struct BDNSBlockDescriptor_3 * get_Block_descriptor_3(struct BDNSBlockLayout *aBlock);

size_t get_Block_size(void *aBlock);
bool if_Block_has_signature(void *aBlock);
const char * get_Block_signature(void *aBlock);



#pragma mark -

struct BDNSBlockByref {
    void *isa;
    struct BDNSBlockByref *forwarding;
    volatile int32_t flags; // contains ref count
    uint32_t size;
};

struct BDNSBlockByref_2 {
    // requires BLOCK_BYREF_HAS_COPY_DISPOSE
    void (*byref_keep)(struct BDNSBlockByref *dst, struct BDNSBlockByref *src);
    void (*byref_destroy)(struct BDNSBlockByref *);
};

struct BDNSBlockByref_3 {
    // requires BLOCK_BYREF_LAYOUT_EXTENDED
    const char *layout;
};

