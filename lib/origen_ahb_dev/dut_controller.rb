module OrigenAhb
  module Test
    class DUTController
      include Origen::Controller
      
      def startup(options = {})
        tester.set_timeset('ahb', 40)
        
        init_pins     # Give pattern a known start up
        
        # Do some startup stuff here
        pin(:resetb).drive(0)
        tester.wait time_in_ns: 250
        pin(:resetb).drive(1)
      end
      
      def shutdown(options = {})
        # Shut everything down
        tester.wait time_in_ns: 250
        pin(:resetb).drive(0)
        
        cleanup_pins  # Give patterns a known exit condition
      end
      
      def init_pins
        pin(:resetb).drive(0)
        pin(:tclk).drive(0)
        pin(:tdi).drive(0)
        pin(:tms).drive(0)
        pin(:tdo).dont_care
      end
      
      def cleanup_pins
        pin(:resetb).drive(0)
        pin(:tclk).drive(0)
        pin(:tdi).drive(0)
        pin(:tms).drive(0)
        pin(:tdo).dont_care
      end
      
      def write_register(reg, options = {})
        ahb.write_register(reg, options)
      end

      def read_register(reg, options = {})
        ahb.read_register(reg, options)
      end

      def ahb_trans(options = {})
        pin(:hclk).drive(0)
        pins(:htrans).drive(0)
        pin(:hwrite).drive(0)
        pin(:hsize).drive(0)
        pin(:hburst).drive(0)
        pin(:hmastlock).drive(0)
        pin(:hprot).drive(0)
        pin(:hready).dont_care
        pins(:haddr).dont_care
        pins(:hwdata).dont_care
        pins(:hrdata).dont_care
        tester.cycle
        
        # Address Phase
        #
        # Master drives the address and control signals onto bus after the rising edge of HCLK
        pin(:hclk).drive(1)
        tester.cycle

        pin(:htrans).drive(0b00)
        pin(:hwrite).drive(options[:hwrite])
        pin(:hsize).drive(options[:hsize])
        pin(:hburst).drive(options[:hburst])
        pin(:hmastlock).drive(options[:hmastlock])
        pin(:hprot).drive(options[:hprot])
        pins(:haddr).drive(options[:haddr])

        pin(:hclk).drive(0)
        tester.cycle
       
        # Data Phase
        #
        # Slave samples the address and control information on the next rising edge of HCLK 
        pin(:hclk).drive(1)
        tester.cycle

        pin(:hclk).drive(0)
        pin(:hready).compare(1)
        pins(:hwdata).drive(options[:hdata]) if options[:hwrite] == 1
        tester.cycle
        
        pin(:hclk).drive(1)
        pins(:hrdata).assert(options[:hdata]) if options[:hwrite] == 0
        tester.cycle
        
        pin(:hclk).drive(0)
        tester.cycle

        pin(:hclk).drive(1)
        pins(:htrans).drive(0)
        pin(:hwrite).drive(0)
        pin(:hsize).drive(0)
        pin(:hburst).drive(0)
        pin(:hmastlock).drive(0)
        pin(:hprot).drive(0)
        pin(:hready).dont_care
        pins(:haddr).dont_care
        pins(:hwdata).dont_care
        pins(:hrdata).dont_care
        tester.cycle
      

        pin(:hclk).drive(0)
        tester.cycle

      
      end
     
    end
  end
end
