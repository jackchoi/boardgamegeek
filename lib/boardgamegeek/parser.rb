require "ox"

module BoardGameGeek
  class Parser
    def parse(content)
      begin
        parsed_content = Ox.parse(content)
        parsed_content = parsed_content.root if parsed_content.respond_to? :root

        parsed_content.nil? ? {} : convert_to_hash(parsed_content)
      rescue Ox::Error
        # catch Ox-specific errors
        raise BoardGameGeek::ParseError, "error parsing the provided content"
      end
    end

    private

    def convert_to_hash(node)
      node_hash = node.attributes.to_hash || {}
      node_hash[:@name] = node.value
      node_hash[:@children] = []

      node.nodes.inject(node_hash[:@children]) do |children, child|
        children << case child
                    when Ox::Element then convert_to_hash(child)
                    else child
                    end
      end

      node_hash
    end
  end
end
