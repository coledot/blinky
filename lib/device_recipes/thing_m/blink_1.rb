module Blinky
  module ThingM
    module Blink1
      def success!(intensity= 255)
        stop
        colorstr = [0, intensity, 0].pack('c*')
        set_colour(colorstr)
      end

      def failure!(intensity= 255)
        stop
        colorstr = [intensity, 0, 0].pack('c*')
        set_colour(colorstr)
      end

      def building!(intensity= 255)
        stop
        colorstr = [0, 0, intensity].pack('c*')
        set_colour(colorstr)
      end

      def warning!(intensity= 255)
        stop
        colorstr = [intensity, intensity, 0].pack('c*')
        set_colour(colorstr)
      end

      def off!
        stop
        set_colour("\x00\x00\x00")
      end

      def init
         set_flash_pattern("\xFF\x00\x00")
      end

      def serial_number
        @device.serial_number
      end

      private
      def set_colour colour
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01\x6E#{colour}\x00\x00\x00\x00", 0)
      end

      def play
         @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01p\x01\x01\x00\x00\x00\x00\x00", 0)
      end

      def stop
         @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01p\x00\x01\x00\x00\x00\x00\x00", 0)
      end

      def set_flash_pattern colour
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P#{colour}\x00\x0A\x00\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x0A\x01\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x02\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x03\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x04\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x05\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x06\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x07\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x08\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x09\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x0A\x00", 0)
        @handle.usb_control_msg(0x21, 0x09, (3 << 8) | 1, 0, "\x01P\x00\x00\x00\x00\x00\x0B\x00", 0)
      end

    end
  end
end
