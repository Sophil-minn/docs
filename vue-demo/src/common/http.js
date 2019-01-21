import axios from 'axios'

const debug = process.env.NODE_ENV !== 'production'
const root = process.env.API_ROOT


// 全局 axios 默认配置

axios.defaults.baseURL = 'https://api.example.com';
axios.defaults.headers.common['Authorization'] = AUTH_TOKEN;
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
axios.defaults.timeout = 5000
axios.defaults.headers = {
    'X-Requested-With': 'XMLHttpRequest'
}


// 拦截器
// 添加一个请求拦截器
// axios.interceptors.request.use(function(config) {
//     //在请求发出之前进行一些操作
//     return config;
// }, function(err) {
//     //Do something with request error
//     return Promise.reject(error);
// });
// 添加一个响应拦截器
// axios.interceptors.response.use(function(res) {

//     //在这里对返回的数据进行处理
//     return res;
// }, function(err) {
//     //Do something with response error
//     return Promise.reject(error)
// })
// http request 拦截器
axios.interceptors.request.use(
    config => {
        if (store.state.token) {  // 判断是否存在token，如果存在的话，则每个http header都加上token
            config.headers.Authorization = `token ${store.state.token}`;
        }
        return config;
    },
    err => {
        return Promise.reject(err);
    });

// http response 拦截器
axios.interceptors.response.use(
    response => {
        return response;
    },
    error => {
        if (error.response) {
            switch (error.response.status) {
                case 401:
                    // 返回 401 清除token信息并跳转到登录页面
                    store.commit(types.LOGOUT);
                    router.replace({
                        path: 'login',
                        query: {redirect: router.currentRoute.fullPath}
                    })
            }
        }
        return Promise.reject(error.response.data)   // 返回接口返回的错误信息
    });


/**
 * @param {String} method  //GET or POST
 * @param {String}  url // request url
 * @param {Object} params // request options
 * 
 */
// exprot
// const fetchMethods = (method, url, params) => {
//     let type = method.toUpperCase()
//     return new Promise((resolve, reject) => {
//         if (type === 'get') {
//             axios.get()
//         } else if (type === 'post') {
//             axios.post()
//         }
//     })
// }


let cancel, promiseArr = {}
const CancelToken = axios.CancelToken;
//请求拦截器
axios.interceptors.request.use(config => {
    //发起请求时，取消掉当前正在进行的相同请求
    if (promiseArr[config.url]) {
        promiseArr[config.url]('操作取消')
        promiseArr[config.url] = cancel
    } else {
        promiseArr[config.url] = cancel
    }
    return config
}, error => {
    return Promise.reject(error)
})

//响应拦截器即异常处理
// axios.interceptors.response.use(response => {
//     return response
// }, error => {
//     if (error && err.response) {
//         switch (err.response.status) {
//             case 400:
//                 err.message = '错误请求'
//                 break;
//             case 401:
//                 err.message = '未授权，请重新登录'.
//                 break;
//             case 403:
//                 err.message = '拒绝访问'
//                 break;
//             case 404:
//                 err.message = '请求错误,未找到该资源'
//                 break;
//             case 405:
//                 err.message = '请求方法未允许'
//                 break;
//             case 408:
//                 err.message = '请求超时'
//                 break;
//             case 500:
//                 err.message = '服务器端出错'
//                 break;
//             case 501:
//                 err.message = '网络未实现'
//                 break;
//             case 502:
//                 err.message = '网络错误'
//                 break;
//             case 503:
//                 err.message = '服务不可用'
//                 break;
//             case 504:
//                 err.message = '网络超时'
//                 break;
//             case 505:
//                 err.message = 'http版本不支持该请求'
//                 break;
//             default:
//                 err.message = `连接错误${err.response.status}`
//         }
//     } else {
//         err.message = "连接到服务器失败"
//     }
//     message.error(err.message)
//     return Promise.resolve(error.response)
// })


export default {
    //get请求  
    get(url, params) {
        if (debug) {
            return new Promise((resolve, reject) => {
                axios({
                    method: 'get',
                    url: `/silverbox-sweeporder/${url}`,
                    params: params,
                    cancelToken: new CancelToken(c => {
                        cancel = c
                    })
                }).then(res => {
                    resolve(res)
                })
            })
        } else {
            return new Promise((resolve, reject) => {
                axios({
                    method: 'get',
                    url: `${root}/${url}`,
                    params: params,
                    cancelToken: new CancelToken(c => {
                        cancel = c
                    })
                }).then(res => {
                    resolve(res)
                })
            })
        }

    },
    //post请求
    post(url, params) {
        if (debug) {
            return new Promise((resolve, reject) => {
                axios({
                    method: 'post',
                    url: `/silverbox-sweeporder/${url}`,
                    data: params,
                    cancelToken: new CancelToken(c => {
                        cancel = c
                    })
                }).then(res => {
                    resolve(res)
                })
            })
        } else {
            return new Promise((resolve, reject) => {
                axios({
                    method: 'post',
                    url: `${root}/${url}`,
                    data: params,
                    cancelToken: new CancelToken(c => {
                        cancel = c
                    })
                }).then(res => {
                    resolve(res)
                })
            })
        }
    }
}