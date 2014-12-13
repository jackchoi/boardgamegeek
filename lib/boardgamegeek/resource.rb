module BoardGameGeek
  module Resource
    def request(*args)
      BoardGameGeek.get(resource_name, *args) do |data|
        # TODO: handle stuff
      end
    end

    def resource_name
      @resource_name ||= default_resource_name
    end

    def resource_name=(resource_name)
      @resource_name = resource_name
    end

    private

    def default_resource_name
      self.to_s.split('::').last.downcase
    end
  end
end
