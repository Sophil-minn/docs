import React, { useState, useEffect } from "react";
import qs from 'qs';
import "./History.less";
import { setTitle, axios } from '../utils/index';
import { useStore } from '../context';

function Histroy() {
  const store = useStore();
  console.log(store)
  const [list, setList] = useState([
    // {
    //   name: '第三期战绩',
    //   time: '9月1日-9月30日',
    //   orderNums: 44,
    //   personalOrderNums: 2,
    //   personalCommission: "8.88",
    //   personalSubsidy: "8.88",
    //   rankNum: 1,
    //   teamOrderNums: 1,
    //   rankSubsidy: "8888.00",
    //   teamCommission: "6.66",
    //   teamSubsidy: "6.66",
    //   totalSubsidy: "15.54"
    // }
  ]);


  useEffect(() => {

    let devData = null;
    setTitle("往期 PLUS PK 赛");
    // setData(f_data);
    // 当前客户排名情况
    async function fetchUserPKRank(month) {


      let res = await axios.get("/usercenter/pkRank/myRank/info?" + qs.stringify({
        stage: month - 5
      }));

      let _data = res.entry;



      // setList(_data);
      return _data;
    }

    let month = devData || new Date().getMonth();
    if (month > 6) {

      let ret = [];
      if (month >= 7) {
        fetchUserPKRank(6).then(_d => {
          if (_d) {
            _d = Object.assign(_d, {
              name: '第一期战绩',
              time: '7月1日-7月31日',
            })
            ret.push(_d);
            setList(ret)
          }
        })


      }

      if (month >= 8) {
        fetchUserPKRank(7).then(_d => {
          if (_d) {
            _d = Object.assign(_d, {
              name: '第二期战绩',
              time: '8月1日-8月31日',
            })
            ret.push(_d);
            setList(ret)
          }
        })

      }

      if (month >= 9) {
        fetchUserPKRank(8).then(_d => {
          if (_d) {
            _d = Object.assign(_d, {
              name: '第三期战绩',
              time: '9月1日-9月30日',
            })
            ret.push(_d);
            setList(ret)
          }
        })

      }


    };



  }, [])


  return (
    <div className='History'>
      {
        list && list.map((item, index) => {
          return <section key={index}>
            <div className="section-title">
              <span className="left">{item.name}</span><span className="right">{item.time}</span>
            </div>
            <div className="section-body">
              <div className="body-des">
                <div className="flex-h">
                  <div className="h-b">
                    <div className="h-b-title">我的排名</div>
                    <div className="h-b-value">{item.rankNum}</div>
                  </div>
                  <div className="spliter"></div>
                  <div className="h-b">
                    <div className="h-b-title">预估补贴</div>
                    <div className="h-b-value money">{item.totalSubsidy}<center className="h-b-tip">含排名补贴<span className="money">{item.rankSubsidy}</span></center></div>

                  </div>
                </div>
                <div className="h-container">
                  <center className="h-b-info">
                    个人战绩
                </center>
                  <div className="flex-h">
                    <div className="h-b">
                      <div className="h-b-title small">有效订单</div>
                      <div className="h-b-value gray">{item.personalOrderNums}</div>
                    </div>
                    <div className="spliter"></div>
                    <div className="h-b">
                      <div className="h-b-title small">预估佣金</div>
                      <div className="h-b-value money gray">{item.personalCommission}</div>
                    </div>
                    <div className="spliter"></div>
                    <div className="h-b">
                      <div className="h-b-title small">预估补贴</div>
                      <div className="h-b-value money gray">{item.personalSubsidy}</div>
                    </div>
                  </div>
                </div>
                <div className="h-container">
                  <center className="h-b-info">
                    团队贡献战绩
                </center>
                  <div className="flex-h">
                    <div className="h-b">
                      <div className="h-b-title small">有效订单</div>
                      <div className="h-b-value gray">{item.teamOrderNums}</div>
                    </div>
                    <div className="spliter"></div>
                    <div className="h-b">
                      <div className="h-b-title small">预估佣金</div>
                      <div className="h-b-value money gray">{item.teamCommission}</div>
                    </div>
                    <div className="spliter"></div>
                    <div className="h-b">
                      <div className="h-b-title small">预估补贴</div>
                      <div className="h-b-value money gray">{item.teamSubsidy}</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
        })
      }
    </div>
  )
}

export default Histroy;