module BoardGameGeek
  class Error < StandardError
  end
  
  class ParseError < Error
  end

  class APIError < Error
  end

  class InvalidResourceError < APIError
  end
end
