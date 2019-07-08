import React, { useState, useEffect } from "react";
import qs from 'qs';
import './App.less';
import { scrollToAnchor, axios, setTitle } from '../utils/index';
import { useStore } from '../context';


function App(props) {
  const store = useStore();

  console.log(store)
  // console.log(state)
  // console.log(props)
  // 选项卡值 6 7 8
  const [active, setActive] = useState(0);
  // 更多数据显示框 0 不显示, 1 显示
  const [showDialog, setShowDialog] = useState(0);
  /**
   * 排名 -1 未报名, >-1 已报名
   *  前 200名 
   *  未进 200 名 
   *  未报名 default
   * */
  const [rank, setRank] = useState(-1);
  const [data, setData] = useState({});


  // 接口数据
  const [list, setList] = useState([]);
  const [listAll, setListAll] = useState([]);
  const [wxTip, setWxTip] = useState('温馨提示：奖励及排名数据每2小时更新1次');
  const [inCalc, setInCalc] = useState(0);

  // allow month
  // const [m] = useState()
  const m = [6, 7, 8]


  useEffect(() => {
    let devData = null;
    setTitle('PLUS PK 赛')
    const m = [6, 7, 8]
    // 获取 排行 数据
    async function fetchPKRankList() {
      let month = devData || new Date().getMonth();

      setActive(month);
      if (m.indexOf(month) === -1) return;
      // 当前时间 7 月 8 月 9 月 进行请求
      let res = await axios.get("/usercenter/pkRank/list/get?" + qs.stringify({
        stage: month - 5,
        page: 1,
        pageSize: 10
      }));
      console.log(res)
      let _list = res.entry || [];
      setList(_list.filter((item, index) => index < 10));
      setListAll(_list)
      //

    }

    // 当前客户排名情况
    async function fetchUserPKRank() {
      let month = devData || new Date().getMonth();
      if (m.indexOf(month) === -1) return;
      let res = await axios.get("/usercenter/pkRank/myRank/info?" + qs.stringify({
        stage: month - 5
      }));
      console.log(res)
      let _data = res.entry || {};
      if (!!res.entry === false) {
        _data = { hasSignUp: false }
      }
      setData(_data);
      setRank(_data.rankNum)

    }

    fetchPKRankList();
    fetchUserPKRank();

    let _times = 0;
    let timer = setInterval(() => {
      let oDate = new Date(),
        month = devData || oDate.getMonth(),// 0- 11
        date = oDate.getDate(), // 1 ~ 31
        hours = oDate.getHours();//, // 0 ~ 23
      // minu = oDate.getMinutes(), // 0 - 59
      // seco = oDate.getSeconds(); // 0 - 59
      _times++;
      // 整小时
      // if (minu === 0 && seco === 0) {
      if (_times % 7200 === 0) {

        // if (_hours % 2 === 0) {
        // 整点 数据更新
        fetchPKRankList();
        fetchUserPKRank();
        // }

      }
      // 月初0-1点提示文案更新
      if ([7, 8, 9].indexOf(month) > -1 && date === 1 && hours === 0) {
        // 月初 0-1 小时内
        setInCalc(1);
        setWxTip(`温馨提示：${parseInt(month)}月PK赛已结束，正在结算战绩，敬请关注`);
      } else {
        setWxTip('温馨提示：奖励及排名数据每2小时更新1次')
      }
    }, 1000)

    return () => clearInterval(timer);
  }, [])


  var nickNameHandle = (str) => {
    let ret = '...'
    if (str && str.length >= 2) {
      let a = str.slice(0, 1),
        b = str.slice(-1);

      ret = `${a}...${b}`;
    }
    return ret;
  }

  var dialogHandle = (isShow) => {

    setShowDialog(isShow)
    let month = new Date().getMonth();
    axios.get("/usercenter/pkRank/list/get?" + qs.stringify({
      stage: month - 5,
      page: 1,
      pageSize: 100
    })).then(res => {

      console.log(res)
      let _list = res.entry || [];
      setListAll(_list)
      //
    })
  }

  var changeName = ind => {
    console.log(ind)
    // store.state.name = ind;
    store.dispatch({
      type: 'name',
      payload: { ind },
    })
  }

  return (
    <div className={`App ${showDialog === 1 ? 'overflow-hidden' : ''}`}>
      <div className={`wx-tip ${((m.indexOf(active) > -1) || (active === 9 && inCalc)) ? '' : 'hide'}`}>{wxTip}</div>
      <header className="App-header">
        <div className="rules" onClick={() => scrollToAnchor("rules")}>
          <div>活动</div>
          <div>规则</div>
        </div>
        <img src={require("../assets/banner@2x.png")} className="App-banner" alt="logo" />
      </header>
      <nav>
        <div className={`tab ${6 === active ? 'active' : ''}`} onClick={() => changeName("1")}>
          <div className="tab-title">第一期</div>
          <center className="sub-title">7月1日-7月31日</center>
          <div className="arrow"></div>
        </div>
        <div className={`tab ${7 === active ? 'active' : ''}`} onClick={() => changeName("2")}>
          <div className="tab-title">第二期</div>
          <center className="sub-title">8月1日-8月31日</center>
          <div className="arrow"></div>
        </div>
        <div className={`tab ${8 === active ? 'active' : ''}`} onClick={() => changeName("3")}>
          <div className="tab-title">第三期</div>
          <center className="sub-title">9月1日-9月30日</center>
          <div className="arrow"></div>
        </div>
      </nav>
      <div className="App-ranking">
        <div className={`more-ac ${(active >= 6) ? '' : 'hide'}`} onClick={() => props.history.push('history')}>
          查看往期
        </div>
        <section className={rank > 0 ? '' : 'hide'}>
          <div className="section-title">本期战绩</div>
          <div className="section-body">
            <div className="body-des">
              <div className="flex-h">
                <div className="h-b">
                  <div className="h-b-title">我的排名</div>
                  <div className="h-b-value">{rank}</div>
                </div>
                <div className="spliter"></div>
                <div className="h-b">
                  <div className="h-b-title">预估补贴</div>
                  <div className="h-b-value money">{data.ptSubsidy === "0" ? "--" : data.ptSubsidy}</div>
                </div>

              </div>
              <div className={rank > 200 ? 'hide' : ''}>
                <center className="h-b-1">我的排名补贴</center>
                <center className="h-b-2 money">{data.rankSubsidy}</center>
                <center className="h-b-1">保持排名至本期活动结束即可获得该补贴奖励</center>
              </div>

            </div>
          </div>
        </section>
        <section className={rank > 0 ? '' : 'hide'}>
          <div className="section-title">战绩详情</div>
          <div className="section-body">
            <div className="body-des">
              <center className="h-b-3">
                <div className="h-b-info d">
                  个人战绩
                </div>
              </center>
              <div className="flex-h">
                <div className="h-b">
                  <div className="h-b-title">有效订单</div>
                  <div className="h-b-value small">{data.personalOrderNums || 0}</div>
                </div>
                <div className="spliter small"></div>
                <div className="h-b">
                  <div className="h-b-title">预估佣金</div>
                  <div className="h-b-value money small">{data.personalCommission || 0}</div>
                </div>
                <div className="spliter small"></div>
                <div className="h-b">
                  <div className="h-b-title">预估补贴</div>
                  <div className="h-b-value money small">{data.personalSubsidy || 0}</div>
                </div>
              </div>
              <center className="h-b-3">
                <div className="h-b-info d">
                  团队贡献战绩
                </div>
              </center>
              <div className="flex-h">
                <div className="h-b">
                  <div className="h-b-title">有效订单</div>
                  <div className="h-b-value small">{data.teamOrderNums || 0}</div>
                </div>
                <div className="spliter small"></div>
                <div className="h-b">
                  <div className="h-b-title">预估佣金</div>
                  <div className="h-b-value money small">{data.teamCommission || 0}</div>
                </div>
                <div className="spliter small"></div>
                <div className="h-b">
                  <div className="h-b-title">预估补贴</div>
                  <div className="h-b-value money small">{data.teamSubsidy || 0}</div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section className={(m.indexOf(active) === -1 || list.length === 0) ? 'hide' : ''}>
          <div className="section-title">排行榜</div>
          <div className="section-body">
            <div className="body-des">
              <div className="flex-h">
                <div className="h-b active">排行</div>
                <div className="h-b-4 active">达人</div>
                <div className="h-b-4 active">预估佣金</div>
                <div className="h-b-4 active">预估补贴</div>
              </div>
              {
                list && list.map((item, index) => {
                  return <div className="flex-h" key={item.userId}>
                    <div className={`h-b rank active-2 ${1 === item.rankNum ? 'gold' : (2 === item.rankNum ? 'silver' : (3 === item.rankNum ? 'copper' : ''))}`}>{item.rankNum}</div>
                    <div className="h-b-4 active-2">
                      <div className="daren">
                        <img alt="" src={item.headImg} />
                        <span className="daren-name">{nickNameHandle(item.nickName)}</span>
                      </div>
                    </div>
                    <div className="h-b-4 active-2 money">{item.totalCommission}</div>
                    <div className="h-b-4 active-2 money">{item.totalSubsidy}</div>
                  </div>
                })
              }
              <center className="h-b-3">
                <div className="h-b-info small" onClick={() => dialogHandle(1)}>
                  查看更多
                </div>
              </center>
            </div>
          </div>
        </section>
        <section>
          <div className="section-title" id="rules">活动规则</div>
          <div className="section-body ac">
            <p>1. 所有满资格报名参加的PLUS会员均可获得团体贡献佣金收益20%的额外平台补贴奖励；</p>
            <p>2. 个人出单收益5%额外平台补贴奖励。</p>
            <p>3. 团队佣金总和排名第1名奖励现金8888元＋荣誉证书＋荣誉奖杯；</p>
            <p>4. 团队佣金总和排名第2名奖励现金3888元＋荣誉证书＋荣誉奖杯；</p>
            <p>5. 团队佣金总和排名第3名奖励现金888元＋荣誉证书＋荣誉奖杯；</p>
            <p>6. 团队佣金总和排名第4名至第10名奖励现金388元；</p>
            <p>7. 团队佣金总和排名第11名至第200名奖励现金88元；</p>
            <p>8. 排名第201名之后不奖励。</p>
            <p>团队佣金总和：计算淘宝、拼多多和京东含金粉和银粉的团队佣金总和。</p>
            <p>如果出现作弊刷单情况则取消资格！</p>
          </div>
        </section>
        <section>
          <div className="section-title">奖励发放</div>
          <div className="section-body ac">
            所有额外佣金补贴均于8月24日随佣金结算一起结算，额外现金奖励也自动发放到提现支付宝账号
          </div>
        </section>
        <section>
          <div className="section-title">举例说明</div>
          <div className="section-body ac">
            <p>1. 团队贡献佣金收益20%额外平台补贴：举个栗子，金粉银粉出单所得分成为1000元，那么则平台额外再补贴200元，以此类推； </p>
            <p>2. 个人出单收益5%额外平台补贴：举个栗子，个人出单佣金所得1000元，那么则平台额外再补贴50元，以此类推； </p>
            <p>3. 所有额外补贴金额均为个人所得，不会再进行分成； </p>
            <p>4. 排名顺序会因退货退款等因素而产生变化，最终会按实际结算情况作为最终排名奖励。</p>
          </div>
        </section>

      </div>
      <div className={`App-tip ${data.hasSignUp === false ? '' : 'hide'}`}>您未参与到此次活动</div>
      <div className={`App-tip ${active > 0 && active < 6 ? '' : 'hide'}`}>活动未开始，敬请期待~</div>
      <div className={`App-tip ${active > 8 ? '' : 'hide'}`}>活动已结束，下次活动敬请关注~</div>
      <div className={`App-ranking App-dialog ${0 === showDialog ? 'hide' : ''}`}>
        <section>
          <div className="section-body relative">
            <div className="body-des scroller">
              <div className="flex-h">
                <div className="h-b active">排行</div>
                <div className="h-b-4 active">达人</div>
                <div className="h-b-4 active">预估佣金</div>
                <div className="h-b-4 active">预估补贴</div>
              </div>
              {
                listAll.map((item, index) => {
                  return <div className="flex-h" key={`1_${item.userId}`}>
                    <div className={`h-b rank active-2 ${1 === item.rankNum ? 'gold' : (2 === item.rankNum ? 'silver' : (3 === item.rankNum ? 'copper' : ''))}`}>{item.rankNum}</div>
                    <div className="h-b-4 active-2">
                      <div className="daren">
                        <img alt="" src={item.headImg} />
                        <span className="daren-name">{nickNameHandle(item.nickName)}</span>
                      </div>
                    </div>
                    <div className="h-b-4 active-2 money">{item.totalCommission}</div>
                    <div className="h-b-4 active-2 money">{item.totalSubsidy}</div>
                  </div>
                })
              }
            </div>
            <center><span className="close-btn" onClick={() => setShowDialog(0)}></span></center>
          </div>
        </section>
      </div>
    </div>
  );
}

export default App;
