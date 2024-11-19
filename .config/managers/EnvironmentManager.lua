local EnvironmentManager = {}

function EnvironmentManager.append_env_var(var, val)
	os.setenv(var, os.getenv(var) .. val)
end

function EnvironmentManager.prepend_env_var(var, val)
	os.setenv(var, val .. os.getenv(var))
end

return EnvironmentManager