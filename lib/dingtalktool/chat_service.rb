module Dingtalktool
  class ChatService

    def self.createChat(accessToken, chatOpt)
      response = HttpService.post("/chat/create?", {access_token: accessToken}, chatOpt.to_json)
      return response
    end

    def self.bindChat(accessToken, chatid,agentid)
     response = HttpService.get("/chat/bind?",{access_token: accessToken,chatid: chatid,agentid: agentid})
     return response
    end

    def self.sendmsg(accessToken, opt)
      response = HttpService.post("/chat/send?", {access_token: accessToken}, opt.to_json)
      return response
    end

  end
end
