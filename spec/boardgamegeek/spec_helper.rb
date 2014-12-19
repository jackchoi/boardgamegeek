def make_http_request(url)
  request_handler = BoardGameGeek.configuration.request_handler
  parser = BoardGameGeek.configuration.parser
  raw_data = request_handler.get(URI(url))
  parser.parse(raw_data[:body])
end
