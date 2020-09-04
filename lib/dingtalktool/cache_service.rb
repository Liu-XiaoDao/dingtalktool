require 'yaml'
module Dingtalktool
  class CacheService
    def self.setJsTicket(ticket)
      set("js_ticket", ticket, ex: 7000); # js ticket有效期为7200秒，这里设置为7000秒
    end

    def self.getJsTicket()
      return get("js_ticket")
    end

    def self.setCorpAccessToken(accessToken)
      set("corp_access_token", accessToken, ex: 7000) # corp access token有效期为7200秒，这里设置为7000秒
    end

    def self.getCorpAccessToken
      return get("corp_access_token")
    end

    # 保存变量
    def self.set_value(name,value)
      set(name, value)
    end
    # 使用变量
    def self.get_value(name)
      get(name)
    end

    def self.set(key,value,options = {})
      ex = options[:ex] ? Time.now.to_i + options[:ex] : 0
      if key && value
        data = get_file("tmp/cache/filecache.yml")

        item = {}
        item["#{key}"] = value
        item['expire_time'] = ex
        item['create_time'] = Time.now.to_i
        data["#{key}"] = item
        set_file("tmp/cache/filecache.yml",data.to_json)
      end
    end

    def self.get(key)
      if key && key.is_a?(String)
        data = get_file("tmp/cache/filecache.yml")
        if !data.empty? && data.has_key?(key)
            item = data["#{key}"]
            return false  if !item
            if item['expire_time']>0 && item['expire_time'] < Time.now.to_i
                return false;
            end
            return item["#{key}"]
        else
          return false;
        end
      end
    end

    def self.get_file(filename)
      if !File.exist?(filename)
        file = File.open(filename, "w")
        file.write("{}")
        file.close
      end
      return YAML.load(File.read(filename))
    end

    def self.set_file(filename, content)
      file = File.open(filename, "w")
      file.write(content)
      file.close unless file.nil?
    end
  end
end
