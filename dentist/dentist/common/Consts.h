
#ifndef __CONSTS__
#define __CONSTS__

#import <UIKit/UIKit.h>

#define EDGE 22.5

#define BTN_HEIGHT 40
#define BTN_WIDTH 330

#define EDIT_HEIGHT 36

#define REG_EMAIL @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,8}"

#define MATCH_PWD  @"^(?![0-9]+$)(?![a-z]+$)[0-9A-Za-z]{8,16}$"

#define TAG_ERROR_SUCCESS 999


#define EDIT_STYLE_NONE             0
#define EDIT_STYLE_ROUNDED          100
#define EDIT_STYLE_LINED            200

#define EDIT_SUBSTYLE_NONE          0
#define EDIT_SUBSTYLE_GRAY          100
#define EDIT_SUBSTYLE_PWD           200
#define EDIT_SUBSTYLE_SEARCH           300

#define EDIT_THEME_NORMAL       0
#define EDIT_THEME_ACTIVE       200
#define EDIT_THEME_DISABLED     300
#define EDIT_THEME_SUCCESS      400
#define EDIT_THEME_ERROR        500


#define DATE_FORMAT @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"


#endif
