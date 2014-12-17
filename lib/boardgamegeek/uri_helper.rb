module BoardGameGeek
  class URIHelper
    def initialize(base_url)
      @base_url = base_url
    end

    def resource_to_uri(resource_name, params = {})
      full_uri = "#{@base_url}/#{escape(resource_name)}"
      full_uri << "?#{params_to_query_string(params)}" unless params.empty?

      URI(full_uri)
    end

    def params_to_query_string(params)
      params.map{ |key, val| param_to_query_string_pair(key, val) }.sort.join('&')
    end

    def param_to_query_string_pair(key, val)
      escaped_value = case val
                      when Enumerable
                        # BGGXML allows comma-separated value to handle non-scalar values
                        val.each { |v| escape(v) }.join(',')
                      when TrueClass
                        "1"
                      when FalseClass
                        "0"
                      else
                        escape(val)
                      end

      "#{escape(key)}=#{escaped_value}"
    end

    def escape(val)
      CGI.escape(val.to_s)
    end
  end
end
