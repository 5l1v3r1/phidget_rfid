module PhidgetRfid
    class Commands

    #Dir.chdir(params[0]) unless params.empty?


        private
        extend CLI::Task
        
        @rfid

        public

        def initialize (rfid)
          @rfid = rfid
        end
      
      
        usage 'Usage: read'
        desc 'Reads the value from the connected RFID tag'

        def read(params)
            puts @rfid.read
        end



        usage 'Usage: write "string to write" <protocol> <lock>'
        desc 'Writes the provided text into the RFID tag. Protocols: EM4100, ISO11785_FDX_B, PhidgetTAG, 1'

        def write(params)
            puts @rfid.write params[0] unless params.empty?
        end



        usage 'Usage: protocol'
        desc 'Displays the current tag protocol'

        def protocol(params)
            puts @rfid.protocol
        end



        usage 'Usage: clear'
        desc 'Clears the console'
        
        def clear(params)
          system "clear" or system "cls"
        end

        usage 'Usage: device'
        desc 'Displays: reader id, serial number and state, Antenna and Led state. Library API version'
        
        def device(params)
          puts @rfid.device
        end
        
        usage 'Usage: log'
        desc 'Shows the event log'
        
        def log(params)
          puts @rfid.log
        end


    end
end