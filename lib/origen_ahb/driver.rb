module OrigenAhb
  class Driver
    attr_reader :owner

    def initialize(owner, options = {})
      @owner = owner
    end

    def read_register(reg_or_val, options = {})
      options = {
        haddr:     reg_or_val.address,
        hdata:     reg_or_val.data,
        hwrite:    0,
        hsize:     get_hsize(reg_or_val.size),
        hburst:    0,
        hmastlock: 0,
        hprot:     0xF
      }.merge(options)
      $dut.ahb_trans(options)
    end

    def write_register(reg_or_val, options = {})
      options = {
        haddr:     reg_or_val.address,
        hdata:     reg_or_val.data,
        hwrite:    1,
        hsize:     get_hsize(reg_or_val.size),
        hburst:    0,
        hmastlock: 0,
        hprot:     0xF
      }.merge(options)
      $dut.ahb_trans(options)
    end

    def get_hsize(size)
      if size <= 8
        hsize = 0
      elsif size > 8 and size <= 16
        hsize = 1
      elsif size > 16 and size <= 32
        hsize = 2
      elsif size > 32 and size <= 64
        hsize = 3
      elsif size > 64 and size <= 128
        hsize = 4
      elsif size > 128 and size <= 256
        hsize = 5
      elsif size > 256 and size <= 512
        hsize = 6
      elsif size > 512 and size <= 1024
        hsize = 7
      end
      get_hsize = hsize
    end
  end
end
