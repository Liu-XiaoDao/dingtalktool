module Dingtalktool
  class Configuration
    attr_accessor :oapi_host, :corpid, :secret, :agentid, :encoding_aes_key, :token

    def initialize
      @oapi_host = "https://oapi.dingtalk.com"
      @corpid = ""
      @secret = ""

      @agentid = "" #必填，在创建微应用的时候会分配
      @encoding_aes_key = "123456" #加解密需要用到的token，普通企业可以随机填写,例如:123456
      @token = "111111111111111111111111111111111" #数据加密密钥。用于回调数据的加密，长度固定为43个字符，从a-z, A-Z, 0-9共62个字符中选取,您可以随机生成
    end
  end
end
