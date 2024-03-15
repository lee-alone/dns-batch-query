import threading
import socket
import time
import os

# 定义查询线程类
class DNSLookupThread(threading.Thread):
    def __init__(self, domain, interval):
        threading.Thread.__init__(self)
        self.domain = domain
        self.interval = interval / 1000  # 将毫秒转换为秒

    def run(self):
        try:
            ip = socket.gethostbyname(self.domain)  # 解析域名为IP地址
            print(f"{self.domain}: {ip}")
            with open("query_results.txt", "a") as file:
                file.write(f"{self.domain}: {ip}\n")  # 将查询结果保存到文件中
        except socket.gaierror:
            print(f"警告：无法解析域名 {self.domain}")
            global failed_queries
            failed_queries += 1  # 记录无法解析的域名数量

# 读取域名列表文件
with open("chinalist.txt", "r") as file:
    domain_list = file.read().splitlines()

# 请求用户输入查询线程数和每线程查询的时间间隔
num_threads = int(input("请输入查询线程数："))
interval = int(input("请输入每线程查询的时间间隔（毫秒）："))

# 清除之前记录的结果
if os.path.exists("query_results.txt"):
    os.remove("query_results.txt")

# 创建并启动查询线程
threads = []
failed_queries = 0  # 无法解析的域名数量计数器
for domain in domain_list:
    thread = DNSLookupThread(domain, interval)
    threads.append(thread)
    thread.start()
    time.sleep(interval / 1000)  # 线程之间的间隔

# 等待所有查询线程结束
for thread in threads:
    thread.join()

# 显示查询结果统计信息
total_queries = len(domain_list)
successful_queries = total_queries - failed_queries

print(f"查询完成！总共查询域名数：{total_queries}，成功查询数：{successful_queries}，失败查询数：{failed_queries}")
