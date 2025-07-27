local GamePlaces = game:GetService("AssetService"):GetGamePlacesAsync()

local Success, Function

local PlaceName
local PlaceFileName

while true do
	for _, PlaceInfo: {Name: string, PlaceId: number} in GamePlaces:GetCurrentPage() do
		PlaceName = PlaceInfo.Name

		PlaceFileName = PlaceName
		PlaceFileName = PlaceFileName:gsub("%b[]", "")
		PlaceFileName = PlaceFileName:gsub("[^%a]", "")

		Success, Function = pcall(function()
			return loadstring(game:HttpGet(`https://github.com/alyssagithub/FrostByte/raw/main/Games/{PlaceFileName}.luau`))
		end)

		if Success and Function then
			break
		end
	end

	if GamePlaces.IsFinished or (Success and Function) then
		break
	end

	GamePlaces:AdvanceToNextPageAsync()
end

if not Success or not Function then
	PlaceName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	
	PlaceFileName = PlaceName
	PlaceFileName = PlaceFileName:gsub("%b[]", "")
	PlaceFileName = PlaceFileName:gsub("[^%a]", "")
end

return {PlaceName = PlaceName, PlaceFileName = PlaceFileName, Success = Success, Function = Function}
