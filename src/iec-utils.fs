\ iec-utils.fs  : low-level iec/drive helpers
include dos

variable src-drive
variable dst-drive

: init-drive ( n -- )
  device s" U0>M1" send-cmd rderr ;

: init-drives ( src dst -- )
  dup dst-drive ! init-drive
  dup src-drive ! init-drive ;


