/*******************
 *  Standard error handling for scourge
 * 
 *  Each function begins with INIT_RETURN and STANDARD_RETURN
 * 
 *    - CP(x): checks if x is positive, excludes 0
 *    - CPEx(x,y): CP(x) bug logs error msg y on failure
 *    - CPZ(x): checks if x is positive, includes 0 
 * **********************************/


#define INIT_RETURN int res = -1

/* ECNOTE: would like to print x as well, but we don't know it's type, so
           don't know what to use int he format specifier, need to come up
           with a solution that lets the results automatically be logged, 
           but not spending time on it now
           
           Ideally we'd be able to do something like this: 
    #define LINELOG(x,mes) log("%s - (%d) at %s:%d",mes,x,__FILE__,__LINE__)
           */ 
#define LINELOG(x,mes) log("%s - at %s:%d",mes,__FILE__,__LINE__)

#define STANDARD_RETURN Error:          \
                          return res;   \

/* core checks */ 

#define CP(x) CPEx(x,"cres: cp error")
#define CPZ(x) CPZEx(x, "cres: cpz error")
#define CN(x) CNEx(x,"cres: cn error")

/* convienance checks */ 
#define CTrue(x)  CP((x) == true)
#define CFalse(x) CP((x) == false)

/* Ex checks */ 
#define CPZEx(x) res = x; \
                 if (x < 0)     \
                 {                \
                    LINELOG(x,y);      \
                    goto Error;  \
                 }

#define CPEx(x,y)   res = x;                    \
                    if (x < 1)                  \
                    {                           \
                        if(x < 0)               \
                        {                       \
                            LINELOG(x,y);       \
                        }                       \
                        goto Error;             \
                    }

#define CNEx(x,y) do {              \
                    res = x;        \
                    if (x >= 0)     \
                    {               \
                    goto Error;     \
                    }               \
                  while (0) 



                    
                            