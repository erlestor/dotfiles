local wezterm = require("wezterm")
local mux = wezterm.mux

local function array_concat(...)
	local t = {}
	for n = 1, select("#", ...) do
		local arg = select(n, ...)
		if type(arg) == "table" then
			for _, v in ipairs(arg) do
				t[#t + 1] = v
			end
		else
			t[#t + 1] = arg
		end
	end
	return t
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function workspace_exists(label)
	for _, ws in ipairs(mux.get_workspace_names()) do
		if ws == label then
			return true
		end
	end
	return false
end

return {
	array_concat = array_concat,
	basename = basename,
	workspace_exists = workspace_exists,
}
