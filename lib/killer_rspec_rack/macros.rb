module KillerRspecRack
  module Macros
    def the_response_body_of url, options = {:method => :get}, &assertion
      decoders = Hash.new(lambda { |body| body })
      decoders.merge!({"application/json" => lambda { |body| ActiveSupport::JSON.decode(body) }})

      context "the response body of #{url}" do
        subject do
          self.send(options[:method], url)
          decoder = decoders[last_response.headers["Content-Type"]]
          decoder.call(last_response.body)
        end

        self.instance_eval &assertion
      end
    end

    def the_response_of url, options = {:method => :get}, &assertion
      context "the response of #{url}" do
        subject do
          self.send(options[:method], url)
          last_response
        end

        self.instance_eval &assertion
      end
    end
  end
end
