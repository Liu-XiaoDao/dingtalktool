module Dingtalktool
  class UserService
    def self.getUserInfo(accessToken, code)
      response = HttpService.get("/user/getuserinfo", {access_token: accessToken, code: code});
      return response;
    end

    def self.get(accessToken, userId)
      response = HttpService.get("/user/get", {access_token: accessToken, userid: userId});
      return response;
    end

    def self.simplelist(accessToken,deptId)
      response = HttpService.get("/user/simplelist", {access_token: accessToken,department_id: deptId});
      return response;
    end

    def self.list(accessToken,deptId)
      response = HttpService.get("/user/list", {access_token: accessToken,department_id: deptId})
      return response
    end
  end
end
