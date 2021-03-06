module OrigenAhb
  class Driver
    attr_reader :owner

    # Initialize owner
    def initialize(owner, options = {})
      @owner = owner
    end

    # Read register. Handles register model as input or data/address pair.
    # Sets up AHB parameters values and passes along to pin-layer ahb
    # transaction method.
    def read_register(reg_or_val, options = {})
      options = {
        haddr:     options[:address] || reg_or_val.address,
        hdata:     reg_or_val,
        hwrite:    0,
        hsize:     get_hsize(reg_or_val.size),
        hburst:    0,
        hmastlock: 0,
        hprot:     0xF
      }.merge(options)
      cc '==== AHB Read Transaction ===='
      if reg_or_val.respond_to?('data')
        data = reg_or_val.data
        name_string = 'Reg: ' + reg_or_val.name.to_s + ' '
      else
        data = reg_or_val
        options[:hsize] = 2
        name_string = ''
      end
      cc name_string + 'Addr: 0x' + options[:haddr].to_s(16) + ' Data: 0x' + data.to_s(16) + ' Size: ' + options[:hsize].to_s
      $dut.ahb_trans(options)
    end

    # Read register. Handles register model as input or data/address pair.
    # Sets up AHB parameters values and passes along to pin-layer ahb
    # transaction method.
    def write_register(reg_or_val, options = {})
      options = {
        haddr:     options[:address] || reg_or_val.address,
        hdata:     reg_or_val,
        hwrite:    1,
        hsize:     get_hsize(reg_or_val.size),
        hburst:    0,
        hmastlock: 0,
        hprot:     0xF
      }.merge(options)
      cc '==== AHB Write Transaction ===='
      if reg_or_val.respond_to?('data')
        data = reg_or_val.data
        name_string = 'Reg: ' + reg_or_val.name.to_s + ' '
      else
        data = reg_or_val
        options[:hsize] = 2
        name_string = ''
      end
      cc name_string + 'Addr: 0x' + options[:haddr].to_s(16) + ' Data: 0x' + data.to_s(16) + ' Size: ' + options[:hsize].to_s
      $dut.ahb_trans(options)
    end

    # Convert bit width to HSIZE
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
