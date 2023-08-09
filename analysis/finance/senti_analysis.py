"""
Finance Analysis:

金融股指评论情感分析


dependent packages:

pip install numpy
pip install pandas
pip install matplotlib

pip install requests
pip install requests_cache
pip install pyrate-limiter
pip install requests_ratelimiter

pip install beautifulsoup4

pip install cemotion

-----------------------------------------------------------------------------------
国内切换为阿里云镜像
pip install -i https://mirrors.aliyun.com/pypi/simple/ package_name
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as colors

from requests import Session
from requests_cache import CacheMixin, SQLiteCache
from pyrate_limiter import Duration, RequestRate, Limiter
from requests_ratelimiter import LimiterMixin, MemoryQueueBucket

import os
from os import path
from bs4 import BeautifulSoup

from cemotion import Cemotion # 中文情感分析

### ========================  Build Session  =========================== ###
"""
Class: Limiter Download Rate
"""
class CachedLimiterSession(CacheMixin, LimiterMixin, Session):
    pass


session = CachedLimiterSession(
    limiter=Limiter(RequestRate(2, Duration.SECOND * 5)),  # max 2 requests per 5 seconds
    bucket_class=MemoryQueueBucket,
    backend=SQLiteCache("finance.cache"),
)

# initialize session
session.headers["User-agent"] = "analysis/1.0"

### ========================  Download Data  =========================== ###

# 获取当前文件路径
dir_path = path.dirname(__file__) if "__file__" in locals() else os.getcwd()

"""
获取东方财富网单页评论
@uri 网址
"""
def one_page_info(uri: str):
    resp = session.get(uri)
    text = resp.text
    parser = BeautifulSoup(text, "html.parser")
    posts = parser.find_all("tr", class_="listitem")
    data = []
    for post in posts:
        read_cnt = post.find("div", class_="read").text
        reply_cnt = post.find("div", class_="reply").text
        title = post.find("div", class_="title").text
        author = post.find("div", class_="author").text
        update_time = post.find("div", class_="update").text
        data.append([title, author, read_cnt, reply_cnt, update_time])
    return data

"""
获取东方财富网评论
@stock_symbol 股指代码
@n: 前n页
"""
def fetch_posts(stock_symbol: str , n: int):
    data_all = []
    for i in range(1, n + 1):
        uri = "https://guba.eastmoney.com/list,{}_{}.html".format(stock_symbol, i)
        data_all.extend(one_page_info(uri))

    columns=["title", "author", "read_cnt", "reply_cnt", "timestamp"]
    file_path = "{}\data\posts_{}.csv".format(dir_path, stock_symbol)
    pd.DataFrame(data_all, columns=columns).to_csv(file_path)

# fetch_posts("zssh000001", 30) # 获取上证股指 前30页评论

### ========================  Handle Data  =========================== ###
def senti_analysis(stock_symbol: str):
    posts_path = "{}\data\posts.csv".format(dir_path)
    df = pd.read_csv(posts_path)
    cemo = Cemotion()
    df["emotion"] = df["title"].apply(lambda text: "{:4f}".format(cemo.predict(text)))
    df["timestamp"] = df["timestamp"].apply(lambda text: text.strip()[:8])
    dst_path = "{}\data\senti_posts_{}.csv".format(dir_path, stock_symbol)
    df.to_csv(dst_path, columns = ["emotion", "timestamp"])
    

# senti_analysis("zssh000001")


### ========================  Draw Piecture  =========================== ###
def draw_all(stock_symbol: str):
    plt.grid(False)
    file_path = "{}\data\senti_posts_{}.csv".format(dir_path, stock_symbol)
    df = pd.read_csv(file_path)
    # set stylesheet as ggplot
    op_dt_cut = lambda text: text.strip()[:2]
    df = df.sort_values(by = "timestamp", ascending = True)
    df["month"] = df["timestamp"].apply(op_dt_cut)
    df.groupby(by = ["month"]).apply(draw_by_month)

def draw_by_month(df):
    month = df["month"].iloc[0]
    plt.title("Month {}".format(month))
    changecolor = colors.Normalize(vmin=0.01, vmax=1.0)
    op_amp__size = lambda e: e * 240 # 数值放大器
    op_amp__color = lambda e: e # 数值放大器
    op_dt_cut = lambda text: text.strip()[:5]
    plt.scatter(
        y = df["emotion"],
        x = df["timestamp"].apply(op_dt_cut),
        s = df["emotion"].apply(op_amp__size),
        c = df["emotion"].apply(op_amp__color),
        alpha=0.4, cmap='jet', norm = changecolor)

    plt.colorbar()
    plt.show()

draw_all("zssh000001")