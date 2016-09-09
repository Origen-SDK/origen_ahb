Pattern.create do
  
  cc 'Write to top-level register'
  $dut.reg(:top_reg).write!(0x5555_AAAA)
  
  cc 'Write to block-level register'
  $dut.block.reg(:control).write!(0xBA5E_BA11)
  
  cc 'Read from block-level register'
  $dut.block.reg(:status).read!(0x0022_0000)

end
