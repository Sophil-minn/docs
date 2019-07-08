import axios, { create } from "axios";
import Qs from 'qs'

import getUrlParams from './getUrlParams';

let urlParams = getUrlParams(window.location.href);
const token = urlParams['token'];
localStorage.setItem('token', token);
var u = navigator.userAgent;
var isIOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
localStorage.setItem('isIOS', isIOS);


axios.default.retry = 3 // 重试次数
axios.default.retryDelay = 5000 // 重试延时，5秒重试一次
axios.default.shouldRetry = (error) => true // 重试条件，默认只要是错误都需要重试

axios.default.withCredentials = true // 表示跨域请求时是否需要使用凭证(cookie/session)


function setHeaders(axios) {
  axios.defaults.headers.post['Content-Type'] = 'application/json;utf-8';
}

function requestIntercptor(axios) {
  // 添加请求拦截器
  axios.interceptors.request.use(function (config) {
    // 在发送请求之前做些什么
    config.headers['token'] = `${localStorage.getItem('token') || '57153b405450d004347941116afcf0ff'}`
    config.headers['zmjx_client'] = urlParams['zmjx_client'] || (isIOS ? 1 : 2);
    config.url = `${config.url}&app_version=1.0`;

    return config;
  }, function (error) {
    // 对请求错误做些什么
    return Promise.reject(error);
  });
}

function responceIntercptor(axios) {
  // 添加响应拦截器
  axios.interceptors.response.use(function (response) {
    // 对响应数据做点什么
    return response.data;
  }, function (err) {
    var config = err.config

    // 判断是否配置了重试
    if (!config || !config.retry) return Promise.reject(err)
    if (!config.shouldRetry || typeof config.shouldRetry !== 'function') return Promise.reject(err)

    // 判断是否满足重试条件
    if (!config.shouldRetry(err)) return Promise.reject(err)

    // 设置重试次数
    config.__retryCount = config.__retryCount || 0
    if (config.__retryCount >= config.retry) return Promise.reject(err)

    // 重试次数自增
    config.__retryCount += 1

    // 延时处理
    var backoff = new Promise(function (resolve) {
      setTimeout(function () {
        resolve()
      }, config.retryDelay || 1)
    })
    config.data = Qs.parse(config.data)
    // 重新发起axios请求
    return backoff.then(() => {
      return axios(config)
    })

  });
}

export default (() => {
  let api_url = 'xxx';
  const axios = create({
    baseURL: api_url,
    // `timeout` 指定请求超时的毫秒数(0 表示无超时时间)
    // 如果请求话费了超过 `timeout` 的时间，请求将被中断
    timeout: 10000,
    // `withCredentials` 表示跨域请求时是否需要使用凭证
    withCredentials: true, // 默认的false, true:让ajax携带cookie
  });

  setHeaders(axios)
  requestIntercptor(axios);
  responceIntercptor(axios);
  return axios;
})();