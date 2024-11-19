local ConfigManager = {}

local envman = require("EnvironmentManager")

function ConfigManager.add_to_path(val)
	envman.prepend_env_var("PATH", val)
end

return ConfigManager