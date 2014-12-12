require "ox"

module BoardGameGeek
  class Parser
    def parse(content)
      parsed_content = Ox.parse(content)
      parsed_content.nil? ? {} : convert_to_hash(parsed_content)
    end

    private

    def convert_to_hash(node)
      ret = node.attributes.to_hash || {}
      ret[:@name] = node.value
      ret[:@children] = []

      node.nodes.each do |child|
        ret[:@children] << convert_to_hash(child)
      end

      ret
    end
  end
end
