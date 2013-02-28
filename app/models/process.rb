class Process
  
  def initialize(game_session)
    @game = Game.for_session(game_session).first
  end
  
end