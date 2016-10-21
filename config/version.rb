module OrigenAhb
  MAJOR = 0
  MINOR = 2
  BUGFIX = 2
  DEV = nil

  VERSION = [MAJOR, MINOR, BUGFIX].join(".") + (DEV ? ".pre#{DEV}" : '')
end
