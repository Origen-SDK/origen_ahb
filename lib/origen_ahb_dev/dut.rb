module OrigenAhbDev
  class DUT
    include Origen::TopLevel
    include OrigenAhb

    def initialize(options = {})
      instantiate_pins(options)
      instantiate_registers(options)
      instantiate_sub_blocks(options)
    end

    def instantiate_pins(options = {})
      # Standard DUT pins
      add_pin :tclk
      add_pin :tdi
      add_pin :tdo
      add_pin :tms
      add_pin :resetb

      # AHB Control Signals
      add_pin :hclk
      add_pin :hready
      add_pin :hwrite
      add_pin :htrans, size: 2
      add_pin :hburst, size: 3
      add_pin :hmastlock
      add_pin :hsize, size: 3
      add_pin :hprot, size: 3

      # AHB Data Signals
      add_pin :haddr, size: 32
      add_pin :hwdata, size: 32
      add_pin :hrdata, size: 32
    end

    def instantiate_registers(options = {})
      add_reg :top_reg, 0x20000000, 32, data: { pos: 0, bits: 32 }
    end

    def instantiate_sub_blocks(options = {})
      sub_block :block, class_name: 'OrigenAhbDev::BLOCK', base_address: 0x2200_0000
    end
  end
end
