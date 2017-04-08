require 'active_support/dependencies/autoload'

module BECoding
  extend ActiveSupport::Autoload

  autoload :Plateau
  autoload :Point
  autoload :Rover
  autoload :RoversManager

  module Validators
    extend ActiveSupport::Autoload

    autoload :LocationBounds
  end

  module Command
    extend ActiveSupport::Autoload

    autoload :Lookup
    autoload :Move
    autoload :Left
    autoload :Right
  end

  module Direction
    extend ActiveSupport::Autoload

    autoload :Lookup
    autoload :East
    autoload :North
    autoload :South
    autoload :West
  end

end