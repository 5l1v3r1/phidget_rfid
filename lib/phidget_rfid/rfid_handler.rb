module PhidgetRfid
  class RfidHandler
    @rfid
    @prompt
    @time
    attr_accessor :log
    
    def initialize()
      @rfid = Phidgets::RFID.new
      @time = Time.new
      @prompt = "at #{@time.strftime("%Y-%m-%d %H:%M:%S")} \033[0m"
      @log = ""
      
      @rfid.on_detach  do |device, obj|
        @log.append "\n#{device.attributes.inspect} removed"
      end
      
      @rfid.on_attach  do |device, obj|
        @rfid.antenna = true
        @rfid.led = false
      end
      
      @rfid.on_error do |device, obj, code, description|
        @log << "\033[31m\nError #{code}: #{description} #{@prompt}" 
      end
      
      @rfid.on_tag  do |device, tag, obj|
        @rfid.led = true
        @log << "\n\033[32m[+] #{protocol} tag detected #{@prompt}" 
      end
      
      @rfid.on_tag_lost do |device, tag, obj|
        @rfid.led = false
        @log << "\n\033[33m[-] #{protocol} tag removed #{@prompt}"
      end
      
      
    end
    
    def protocol
      if(@rfid.attached?)
        @rfid.last_tag_protocol
      end
    end
    
    def read
      if(@rfid.attached?)
        @rfid.last_tag
      end
    end
    
    def write(value, protocol = @rfid.last_tag_protocol, lock = false)
      if(@rfid.attached?)
        p = protocol.to_sym

        if lock
          puts "Data: #{value}"
          puts "Protocol: #{p}"
          puts "Are you sure you want to lock the RFID Tag? This will make it read-only (y/N)"
          r = gets.chomp
          @rfid.write value, p, true if r == "y"

        end

      end
    end
    
    def device
      puts "Library Version: #{Phidgets::FFI.library_version}"
      puts "Class: #{device.device_class}"
      puts "Id: #{device.id}"
      puts "Serial number: #{device.serial_number}"
      puts "# Digital Outputs: #{device.outputs.size}"
    end
    
    
      
  end

end



