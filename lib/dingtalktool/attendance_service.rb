module Dingtalktool
  class AttendanceService
    # data = {
    #   "userIds": [1, 2, 3],
    #   "checkDateFrom": "2019-10-11 00:00:00",
    #   "checkDateTo": "2019-10-12 00:00:00",
    #   "isI18n": "false"
    # }
    # listRecord(accessToken,data)
    # 获取打卡详情
    def self.listRecord(accessToken, opt)
      response = HttpService.post("/attendance/listRecord",{access_token: accessToken}, opt.to_json)
      return response
    end

    # data = {
    #   "workDateFrom": "2019-10-11 00:00:00",
    #   "workDateTo": "2019-10-11 00:00:00",
    #   "userIdList": [1, 2, 3],
    #   "offset": 0,
    #   "limit": 1
    # }
    # listRecord(accessToken,data)
    # 获取打卡结果
    def self.list(accessToken, opt)
      response = HttpService.post("/attendance/list",{access_token: accessToken}, opt.to_json)
      return response
    end
  end
end
