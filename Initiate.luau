--!strict
local PlaceInfo: {[string]: any} = {PlaceName = "Game", PlaceFileName = "Game"}

local NotificationMessage

do
	local GetPlaceName = loadstring(game:HttpGet("https://github.com/alyssagithub/FrostByte/raw/main/GetPlaceName.luau"))

	if not GetPlaceName then
		NotificationMessage = "Failed to get the GetPlaceName module"
	else
		PlaceInfo = GetPlaceName()
	end
end

local Success = PlaceInfo.Success
local Function = PlaceInfo.Function

if not Success or not Function then
	Function = loadstring(game:HttpGet("https://github.com/alyssagithub/FrostByte/raw/main/Games/Universal.luau"))
	NotificationMessage = "Game not found, loading universal script..."
end

if not Function then
	NotificationMessage = "Failed to load, try again."
end

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "FrostByte (discord.gg/sS3tDP6FSB)",
	Text = NotificationMessage or "Game found, loading script...",
	Duration = 10
})

local Success, Result = pcall(Function)

if not Success then
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "FrostByte Load Error",
		Text = `Report this in discord.gg/sS3tDP6FSB: {Result}`,
		Duration = 10
	})
	task.spawn(error, Result)
end
