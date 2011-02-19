require 'spec_helper'
require 'rack/test'
require 'sinatra'
require 'lib/killer_rspec_rack'
require 'active_support'

include KillerRspecRack

def sinatra &app_block
  app = Class.new(Sinatra::Base)
  app.instance_eval &app_block
  app
end

describe 'hello world app' do
  def app
    sinatra do
      get '/' do
        content_type 'text/plain'
        "Hello World!"
      end
    end
  end

  the_response_of '/' do
    it { should be_ok }
    it { should have_content_type 'text/plain;charset=utf-8' }
    it { should have_content_length 12 }
    it { should have_header 'Content-Type', 'text/plain;charset=utf-8' }
  end

  the_response_body_of '/' do
    it { should == 'Hello World!' }
  end
end

describe 'unauthorized app' do
  def app
    sinatra do
      get '/401' do
        status 401
      end
    end
  end

  the_response_of '/401' do
    it { should be_unauthorized }
  end
end


describe 'unauthorized app' do
  def app
    sinatra do
      get '/json' do
        content_type 'application/json; charset=utf-8'
        "{'key': 'value'}"
      end
    end
  end

  the_response_of '/json' do
    it { should be_ok_and_json }
  end

  the_response_body_of '/json' do
    it { should == {'key' => 'value'} }
  end
end
