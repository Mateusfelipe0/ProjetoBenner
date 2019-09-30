const path = require('path');
const glob = require('glob');
const webpack = require('webpack');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");

const FileLoader = {
    loader: 'file-loader',
    options: {
        outputPath: '../dist/'
    }
};

module.exports = function (env) {
    return {
        mode: env.mode,
        watch: false,
        devtool: 'source-map',
        entry: {
            benner: './content/entry/entry.15.js',
            tests: glob.sync('./content/tests/**/*.test.js')
        },
        output: {
            filename: '[name].min.js',
            chunkFilename: '[name].min.js',
            path: path.resolve(__dirname, '../dist')
        },
        optimization: {
            minimizer: [
                new OptimizeCSSAssetsPlugin({})
            ]
        },
        module: {
            rules: [
                {
                    test: /\.m?js$/,
                    exclude: /(node_modules|bower_components)/,
                    use: {
                        loader: 'babel-loader',
                        options: {
                            presets: ['@babel/preset-env']
                        }
                    }
                },
                {
                    test: /\.css$/,
                    use: [
                        MiniCssExtractPlugin.loader,
                        'css-loader'
                    ]
                },
                {
                    test: /\.scss/,
                    use: [
                        MiniCssExtractPlugin.loader,
                        'css-loader',
                        'sass-loader']
                },
                {
                    test: /\.(png|jpeg|jpg|gif)$/,
                    use: FileLoader
                },
                {
                    test: /\.woff(2)?(\?v=[0-9]\.[0-9]+\.[0-9]+)?$/,
                    use: {
                        loader: 'url-loader',
                        options: {
                            limit: 4096,
                            mimetype: 'application/font-woff',
                            outputPath: '../dist/'
                        }
                    }
                },
                {
                    test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]+\.[0-9]+)?$/,
                    use: FileLoader
                },
                {
                    test: /\.vue$/,
                    loader: 'vue-loader'
                }
            ]
        },
        resolve: {
            extensions: ['.js', '.vue', '.jsx', '.json', '.css'],
            alias: {
                '~': path.resolve('./'),
                'vue$': 'vue/dist/vue.esm.js'
            }
        },
        plugins: [
            new webpack.ProvidePlugin({
                $: 'jquery',
                jQuery: 'jquery',
                _: 'lodash'
            }),
            new MiniCssExtractPlugin({
                filename: '../dist/[name].min.css',
                chunkFilename: '../dist/[name].min.css'
            }),
            new VueLoaderPlugin()
        ]
    };
};
