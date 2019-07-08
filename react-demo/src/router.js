import App from './views/App';
import History from './views/History';


export default [
  {
    path: '/',
    title: 'PLUS PK赛',
    component: App,
  },
  {
    path: '/history',
    title: '往期PLUS PK 赛',
    component: History,
  },
]