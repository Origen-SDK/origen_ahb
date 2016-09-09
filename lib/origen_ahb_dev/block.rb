module OrigenAhbDev
  class BLOCK
    include Origen::Model

    def initialize(options = {})
      instantiate_registers(options)
    end

    def instantiate_registers(options = {})
      add_reg :control, 0x00, 32, data: { pos: 0, bits: 32 }
      add_reg :status, 0x04, 32, data: { pos: 0, bits: 32 }
    end
  end
end

