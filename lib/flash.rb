require 'json'

class Flash


  def initialize(req)
    if req.cookies["_rails_lite_app_flash"]
      rlaf = req.cookies["_rails_lite_app_flash"]
      @flash = JSON.parse(rlaf)
    else
      @flash = {}
    end
    @old_keys = @flash.keys
    @flash[:now] = {}
  end

  def now
    @flash[:now]
  end

  def [](key)
    if @flash[key]
      @flash[key]
    elsif @flash[:now][key]
      @flash[:now][key]
    else
      nil
    end
  end

  def []=(key, value)
    @flash[key] = value
  end

  def store_flash(res)
    @flash.delete(:now)
    @old_keys.each { |k| @flash.delete(k) }
    @flash = @flash.to_json
    res.set_cookie("_rails_lite_app_flash", {path: "/", value: @flash})
  end


end
