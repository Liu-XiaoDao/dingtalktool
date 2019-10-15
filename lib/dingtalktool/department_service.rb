module Dingtalktool
  class DepartmentService

    def self.createDept(accessToken, dept)
      response = HttpService.post("/department/create?", {access_token: accessToken}, dept.to_json)
      return response
    end

    def self.listDept(accessToken)
      response = HttpService.get("/department/list?", {access_token: accessToken})
      return response
    end

    def self.list_ids(accessToken)
      response = HttpService.get("/department/list_ids?", {access_token: accessToken})
      return response
    end

    def self.department_info(accessToken)
      response = HttpService.get("/department/get?", {access_token: accessToken,id: 66950253})
      return response
    end

    def self.deleteDept(accessToken, id)
      response = HttpService.get("/department/delete?",{access_token: accessToken, id: id})
      return response
    end

  end
end
