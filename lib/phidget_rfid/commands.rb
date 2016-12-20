module PhidgetRfid
    class Commands

    #Dir.chdir(params[0]) unless params.empty?


        private
        extend CLI::Task
        
        

        public

        def initialize (r)
          @rfid_handler = r
        end
      
      
        usage 'Usage: read'
        desc 'Reads the value from the connected RFID tag'

        def read(params)
            puts @rfid_handler.read
        end



        usage 'Usage: write "string to write" <protocol> <lock>'
        desc 'Writes the provided text into the RFID tag. Protocols: EM4100, ISO11785_FDX_B, PhidgetTAG, 1.\nHave in mind that if the TAG is blank you need to write it for the first time with the PhidgetTAG protocol'


        def write(params)
            
            if params.size == 1
                puts @rfid_handler.write params[0]
            elsif params.size == 2
                puts @rfid_handler.write params[0], params[1]
            elsif params.size == 3
                
                puts  @rfid_handler.write params[0], params[2], params[3]
            end
        end



        usage 'Usage: protocol'
        desc 'Displays the current tag protocol'

        def protocol(params)
            puts @rfid_handler.protocol
        end



        usage 'Usage: clear'
        desc 'Clears the console'
        
        def clear(params)
          system "clear" or system "cls"
        end

        usage 'Usage: device'
        desc 'Displays: reader id, serial number and state, Antenna and Led state. Library API version'
        
        def device(params)
          puts @rfid_handler.device
        end
        
        usage 'Usage: log'
        desc 'Shows the event log'
        
        def log(params)
          puts @rfid_handler.log
        end


    end
end