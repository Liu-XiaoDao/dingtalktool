module Dingtalktool
  class HttpService
    require 'net/https'
    require 'uri'
    require 'rest-client'
    require 'json'

    @@oapi_host = 'https://oapi.dingtalk.com'

    def self.get(url,params)
      uri = URI.parse("#{@@oapi_host}/#{url}?")
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      if res.code == "200"
        return resbody = JSON.parse(res.body)
      end
      return nil
    end

    def self.post(url, params, data)
      res = RestClient.post joinParams(url, params), data, :content_type => :json, :accept => :json
    end

    def self.joinParams(path,params)
      url = "#{@@oapi_host}#{path}"
      if params.count > 0
        url = url + "?"
        params.each do |key,value|
          url = url + key.to_s + "=" + value.to_s + "&";
        end
        url.last == "&" &&  url.chop!
      end
      return url
    end
  end
end
