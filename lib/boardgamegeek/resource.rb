module BoardGameGeek
  module Resource
    def request(*args, &block)
      api_handler.get(resource_name, *args, &block)
    end

    def resource_name
      @resource_name ||= default_resource_name
    end

    def resource_name=(resource_name)
      @resource_name = resource_name
    end

    def api_handler
      @api_handler ||= BoardGameGeek.api_handler
    end

    private

    def default_resource_name
      self.name.split('::').last.downcase
    end
  end
end
