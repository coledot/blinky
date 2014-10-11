require 'chicanery/cctray'
require 'chicanery'
module Blinky
  module CCTrayServer
    include Chicanery

    def watch_cctray_server url, options = {}
      server Chicanery::Cctray.new 'blinky build', url, options

      when_run do |current_state|
        if current_state.building?
          building!
        else
          current_state.has_failure? ? failure! : success!
        end
      end

      begin
        run_every 1
      rescue => e
        warning!
        raise e
      end
    end
  end
end
