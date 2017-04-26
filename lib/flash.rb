require 'json'

class Flash

  def initialize(req)
    if req.cookies["_rails_lite_app_flash"]
      rlaf = req.cookies["_rails_lite_app_flash"]
      @old_flash = JSON.parse(rlaf)
    else
      @old_flash = {}
    end
    @flash = {}
    @flash[:old] = @old_flash
    @flash[:now] = {}
  end

  def now
    @flash[:now]
  end

  def [](key)
    if @flash[:now][key]
      @flash[:now][key]
    elsif @flash[:old][key]
      @flash[:old][key]
    elsif @flash[key]
        @flash[key]
    else
      nil
    end
  end

  def []=(key, value)
    @flash[key] = value
  end

  def store_flash(res)
    @flash.delete(:now)
    @flash.delete(:old)
    @flash = @flash.to_json
    res.set_cookie("_rails_lite_app_flash", {path: "/", value: @flash})
  end


end
