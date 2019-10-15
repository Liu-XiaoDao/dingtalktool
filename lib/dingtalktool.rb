require "dingtalktool/version"
require "dingtalktool/configuration"
require "dingtalktool/http_service"
require "dingtalktool/log_service"
require "dingtalktool/cache_service"
require "dingtalktool/auth_service"
require "dingtalktool/chat_service"
require "dingtalktool/department_service"
require "dingtalktool/message_service"
require "dingtalktool/user_service"
require "dingtalktool/attendance_service"

begin
  require "pry"
rescue LoadError
end

module Dingtalktool
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Dingtalktool::Configuration.new
  end

  def self.reset
    @configuration = Dingtalktool::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
