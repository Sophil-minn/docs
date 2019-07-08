const { override, addWebpackAlias, addLessLoader } = require('customize-cra');
const path = require("path");

const rewiredMap = () => config => {
  if (config.mode === 'production') {
    config.module.rules[2].oneOf.splice(0, 1, {
      test: [/\.bmp$/, /\.gif$/, /\.jpe?g$/, /\.png$/],
      use: [{
        loader: require.resolve('url-loader'),
        options: {
          limit: 10000, // 8k以内的图片进行转b64码
          name: 'images/[name].[hash:8].[ext]',
          publicPath: '../../'
        }
      }]
    });
  }
  config.resolve.extensions.push('.less');
  config.output.publicPath = './';
  return config;
};

module.exports = override(
  rewiredMap(),
  addLessLoader({
    strictMath: true,
    noIeCompat: true,
    localIdentName: '[local]--[hash:base64:5]' // if you use CSS Modules, and custom `localIdentName`, default is '[local]--[hash:base64:5]'.
  }),
  addWebpackAlias({
    ["aliasimgurl"]: path.resolve(__dirname, "src/assets")
  }),
);