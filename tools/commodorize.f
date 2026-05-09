\ commodorize (Nasm/JonesForth)

0 VALUE SRC-FD
0 VALUE DST-FD

VARIABLE CHAR


: CHECK-I/O ( rc msg u -- )
    2 PICK  \ grab rc
    IF S" Failed " TELL PERROR QUIT ELSE 2DROP DROP THEN ;


: CREATE-FD ( addr u -- fd )
    R/W CREATE-FILE S" create" CHECK-I/O ;


: OPEN-FD ( addr u -- fd )
    R/O OPEN-FILE S" open" CHECK-I/O ;


: CLOSE-FD ( fd -- )
    CLOSE-FILE S" close" CHECK-I/O ;


: C64-FILE  ( src u dst u -- )
    2SWAP               ( dst u src u )
    OPEN-FD   TO SRC-FD \ make sure we can open the source
    CREATE-FD TO DST-FD \ before creating the destination

    BEGIN
        CHAR 1 SRC-FD READ-FILE S" read" CHECK-I/O
        DUP             ( cnt cnt )
        CHAR SWAP TELL  ( cnt )
    0= UNTIL

    SRC-FD CLOSE-FD
    DST-FD CLOSE-FD ;


: COMMODORIZE ( -- )
    ARGC
    3 < IF S" Usage: COMMODORIZE src dst" TELL CR QUIT THEN
    1 ARGV      ( src u )
    2 ARGV      ( src u dst u )
    C64-FILE ;


CR COMMODORIZE
