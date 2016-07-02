local allowedIPs = {}
local whitelistFile = 'whitelist.txt'

AddEventHandler('onResourceStarting', function(res)
	LoadList()
end)

RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setCallback)
	local identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		local ip = stringsplit(identifiers[i], ':')[2]
		if allowedIPs[ip] == nil then 
			print('Player tried to join but is not in whitelist: ' .. ip)
			setCallback("You are not allowed to enter this server.")
			CancelEvent()
		end
	end
end)

function LoadList()
	if file_exists(whitelistFile) then
		for line in io.lines(whitelistFile) do
			if line ~= nil and line ~= "" then
				allowedIPs[line] = true
			end
		end
		file:close()
	end
end

function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end
