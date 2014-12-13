require "ox"

module BoardGameGeek
  class Parser
    def parse(content)
      begin
        parsed_content = Ox.parse(content)
        parsed_content.nil? ? {} : convert_to_hash(parsed_content)
      rescue Ox::Error
        # catch Ox-specific errors
        raise BoardGameGeek::ParseError, "error parsing the provided content"
      end
    end

    private

    def convert_to_hash(node)
      ret = node.attributes.to_hash || {}
      ret[:@name] = node.value
      ret[:@children] = []

      node.nodes.inject(ret[:@children]) do |children, child|
        children << case child
                    when Ox::Element then convert_to_hash(child)
                    else child
                    end
      end

      ret
    end
  end
end
