class Member
  attr_accessor :standing, :name, :auth_test
  attr_reader :ws

  def initialize(ws, name, standing="unkown")
    @ws = ws
    @name = name
    @standing = standing
    @auth_test = nil
  end

  def authorize
    @auth_test[:prompt]
  end

  def send(msg)
    @ws.send(msg)
  end

end
