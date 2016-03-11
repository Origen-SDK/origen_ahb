module OrigenAhb
  MAJOR = 0
  MINOR = 2
  BUGFIX = 0
  DEV = 6

  VERSION = [MAJOR, MINOR, BUGFIX].join(".") + (DEV ? ".pre#{DEV}" : '')
end
