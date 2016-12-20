module PhidgetRfid
  class RfidHandler
    @phidget
    @prompt
    @time
    attr_accessor :log
    
    def initialize()
      @phidget = Phidgets::RFID.new
      @time = Time.new
      @prompt = "at #{@time.strftime("%Y-%m-%d %H:%M:%S")} \033[0m"
      @log = ""
      
      @phidget.on_detach  do |device, obj|
        @log.append "\n#{device.attributes.inspect} removed"
      end
      
      @phidget.on_attach  do |device, obj|
        @phidget.antenna = true
        @phidget.led = false
      end
      
      @phidget.on_error do |device, obj, code, description|
        @log << "\033[31m\nError #{code}: #{description} #{@prompt}" 
      end
      
      @phidget.on_tag  do |device, tag, obj|
        @phidget.led = true
        @log << "\n\033[32m[+] #{protocol} tag detected #{@prompt}" 
      end
      
      @phidget.on_tag_lost do |device, tag, obj|
        @phidget.led = false
        @log << "\n\033[33m[-] #{protocol} tag removed #{@prompt}"
      end
      
      
    end
    
    def protocol
      if(@phidget.attached?)
        @phidget.last_tag_protocol
      end
    end
    
    def read
      if(@phidget.attached?)
        @phidget.last_tag
      end
    end
    
    def write(value, protocol = nil, lock = false)
      if (protocol == nil)
        protocol = 
          if @phidget.tag_present
            @phidget.last_tag_protocol
          else
            "EM4100"
          end
      end

      if(@phidget.attached?)
        p = protocol.to_sym

        if lock
          puts "Data: #{value}"
          puts "Protocol: #{p}"
          puts "Are you sure you want to lock the RFID Tag? This will make it read-only (y/N)"
          r = gets.chomp
          @phidget.write(value, p, true) if r == "y"
        else
          @phidget.write(value, p)
        end


      end
    end
    
    def device
      puts "Library Version: #{Phidgets::FFI.library_version}"
      puts "Class: #{@phidget.device_class}"
      puts "Id: #{@phidget.id}"
      puts "Serial number: #{@phidget.serial_number}"
      puts "Digital Outputs: #{@phidget.outputs.size}"
    end
    
    
      
  end

end



