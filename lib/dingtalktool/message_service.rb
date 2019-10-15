module Dingtalktool
  class MessageService
    def self.sendToConversation(accessToken, opt)
      response = HttpService.post("/message/send_to_conversation?", {access_token: accessToken}, opt.to_json)
      return response
    end

    def self.send(accessToken, opt)
      response = HttpService.post("/message/send",{access_token: accessToken}, opt.to_json)
      return response
    end

    def self.send_chat(accessToken, opt)
      response = HttpService.post("/chat/send",{access_token: accessToken}, opt.to_json)
      return response
    end
  end
end
