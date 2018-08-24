
#ifndef __CONSTS__
#define __CONSTS__

#import <UIKit/UIKit.h>

#define EDGE 22.5

#define BTN_HEIGHT 40
#define BTN_WIDTH 330

#define EDIT_HEIGHT 36

#define REG_EMAIL @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[[A-Za-z]{2,8}]"
//#define REG_EMAIL @"\\w{1,}[@]{1}[a-zA-Z0-9]{2,5}(.com|.co|.net)"
#define MATCH_PWD @"(?![a-zA-Z]+$)(?![A-Z0-9]+$)(?![a-z0-9]+$)(?![a-z\\W_]+$)[a-zA-Z0-9]{8,16}"

#define TAG_ERROR_SUCCESS 999

#endif
