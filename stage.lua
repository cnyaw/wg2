local lock = 73

LEVEL = {14,36,56,90,125,171,213,270,337,412,496,559}
MaxLevel = nil

SelStage = {}

SelStage.OnCreate = function(param)
  if (nil == MaxLevel) then
    local inf = io.open("wg2.sav", "r")
    if (nil == inf) then
      MaxLevel = 1
    else
      MaxLevel = inf:read("*number")
      inf:close()
      if (1 > MaxLevel) then
        MaxLevel = 1
      end
      if (12 < MaxLevel) then
        MaxLevel = 12
      end
    end
  end
  for i = MaxLevel, 11 do
    local row = math.floor(i / 4)
    local col = i % 4
    local o = GenTexObj(-1, lock, 0, 0)
    Good.SetPos(o, 50 + 150 * col, 40 + 120 * row)
    Good.SetBgColor(o, 0xbbffffff)
    Good.KillObj(60 + i)
  end
  SetBkg(param._id)
end

SelStage.OnStep = function(param)
  if (Input.IsKeyPressed(Input.LBUTTON)) then
    local x,y = Input.GetMousePos()
    if (PtInObj(x, y, 37)) then
      Good.GenObj(-1, 3)                  -- Back to title.
      return
    end
    local W,H = Good.GetWindowSize()
    local col = math.floor(x / (W/4))
    local row = math.floor(y / (H/3))
    local i = 1 + col + row * 4
    if (1 <= i and MaxLevel >= i) then
      Sound.PlaySound(79)
      Good.GenObj(-1, LEVEL[i])
    end
  elseif (Input.IsKeyPressed(Input.RETURN + Input.BTN_A)) then
    Good.GenObj(-1, 14)                 -- Start level 1.
  elseif (Input.IsKeyPressed(Input.ESCAPE)) then
    Good.GenObj(-1, 3)                  -- Back to title.
  end
end
