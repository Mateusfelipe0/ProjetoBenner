module.exports = function (env) {
    return {
        devtool: 'cheap-module-eval-source-map',
        watch: (!env.visualstudio)
    };
};