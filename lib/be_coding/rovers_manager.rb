module BECoding
  class RoversManager
    def initialize(rovers = [])
      @rovers = rovers
    end

    def send_commands(rover_number, commands)
      commands.each_char do |command|
        @rovers[rover_number].execute_command(Command::Lookup.init_by_uppercase(command))
      end
    end
  end
end