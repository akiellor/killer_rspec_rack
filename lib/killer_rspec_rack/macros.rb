module KillerRspecRack
  class DefaultDecoder
    def can_decode? response
      true
    end

    def decode body
      body
    end
  end

  class JsonDecoder
    def can_decode? response
      response.headers["Content-Type"].include? "application/json"
    end

    def decode body
      ActiveSupport::JSON.decode(body)
    end
  end

  module Macros
    def the_response_body_of url, options = {:method => :get}, &assertion
      decoders = [JsonDecoder.new, DefaultDecoder.new]

      context "the response body of #{url}" do
        subject do
          self.send(options[:method], url)
          decoder = decoders.detect {|dec| dec.can_decode? last_response }
          decoder.decode last_response.body
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
