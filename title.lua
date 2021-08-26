BG_COLOR = 0xffc0c0c0

function SetBkg(id)
  Good.SetBgColor(id, BG_COLOR)
  local o = GenTexObj(-1, 76, 0, 0)
  Good.SetRep(o, 1, 1)
  Good.AddChild(id, o, 0)
end

MoveSpeed = nil

Title = {}

Title.OnCreate = function(param)
  if (nil == MoveSpeed) then
    local inf = io.open("wg2b.sav", "r")
    if (nil == inf) then
      MoveSpeed = 2
    else
      MoveSpeed = inf:read("*number")
      inf:close()
      if (1 ~= MoveSpeed and 2 ~= MoveSpeed) then
        MoveSpeed = 2
      end
    end
  end
  if (1 == MoveSpeed) then
    Good.SetVisible(75, Good.INVISIBLE)
  else
    Good.SetVisible(75, Good.VISIBLE)
  end
  SetBkg(param._id)
end

Title.OnStep = function(param)
  if (Input.IsKeyPressed(Input.RETURN + Input.BTN_A + Input.LBUTTON)) then
    Sound.PlaySound(79)
    local x,y = Input.GetMousePos()
    local o = Good.PickObj(x, y, Good.SPRITE)
    if (23 == o or 25 == o) then
      if (1 == MoveSpeed) then
        MoveSpeed = 2
        Good.SetVisible(75, Good.VISIBLE)
      else
        MoveSpeed = 1
        Good.SetVisible(75, Good.INVISIBLE)
      end
      local outf = io.open("wg2b.sav", "w")
      outf:write(MoveSpeed)
      outf:close()
    else
      Good.GenObj(-1, 42)                 -- Select stage.
    end
  end
end
