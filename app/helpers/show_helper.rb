module ShowHelper
  class Proxy
    def method_missing(method, *args, &block)
      return 0
    end
  end

  def stat_proxy(stat)
    stat || Proxy.new
  end
end
