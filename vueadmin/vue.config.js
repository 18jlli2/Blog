module.exports = {
  //axios域代理，解决axios跨域问题
  devServer: {
      proxy: {
          '/': {
              target: 'http://localhost:8082',
              changeOrigin: true,
              ws: true,
              pathRewrite: {
                  '^/': ''
              }
          }
      }
  }
}