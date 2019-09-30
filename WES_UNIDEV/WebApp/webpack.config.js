const path = require('path');
const merge = require('webpack-merge');
const fileExists = require('file-exists');

function getEnvMode(env) {
	if (env) {
		if (env.visualstudio){
			var vsMode = env.vsmode;
			if (vsMode && vsMode === 'Release')
				return 'production';
			return 'development';
		}
		
		if (env.production)
			return 'production';
		if (env.development)
			return 'development';
		if (env.mode)
			return env.mode;
		if (process.env.NODE_ENV)
			return process.env.NODE_ENV;
	}
	return 'development';
}

function loadConfig(configFile) {
    var file = path.resolve(__dirname, 'content/entry/' + configFile);
	if (fileExists.sync(file)) {
		var layerConfig = require(file);
		return layerConfig;
	}
	return {};
}

function mergeConfigs(config, newFile, env) {
	var newConfig = loadConfig(newFile);
	
	if (typeof(newConfig) === 'function' || newConfig instanceof Function){
		newConfig = newConfig(env);
	}
	
	config = merge.strategy({
		watch: 'replace'
	})(config, newConfig);
	return config;
}

function BennerWebPack(env) {

	var ENV = getEnvMode(env);
	env.mode = ENV;

	var config = {};
	config = mergeConfigs(config, 'webpack.15.config.js', env);
	config = mergeConfigs(config, 'webpack.20.config.js', env);
	config = mergeConfigs(config, 'webpack.30.config.js', env);
	config = mergeConfigs(config, 'webpack.40.config.js', env);
	config = mergeConfigs(config, 'webpack.' + ENV + '.config.js', env);

	return config;
};

module.exports = BennerWebPack;