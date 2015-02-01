//
//  DDLogging
//
//  Created by Denis Dorokhov on 22/06/2012.
//

#define ddlog_file (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)

#if defined(DEBUG) && DEBUG == 1
#define ddlog(...) NSLog(@"%s:%d %s - %@", ddlog_file, __LINE__, __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define ddlog(...) do {} while (0)
#endif
