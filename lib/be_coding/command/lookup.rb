module BECoding::Command
  module Lookup
    COMMANDS = {
        M: Move,
        L: Left,
        R: Right
    }

    def self.init_by_uppercase(uppercase)
      raise NoCommandFoundError.new, "No command found by uppercase: #{uppercase}" unless COMMANDS.has_key? uppercase.to_sym
      COMMANDS[uppercase.to_sym].new
    end

    class NoCommandFoundError < StandardError ; end

  end
end