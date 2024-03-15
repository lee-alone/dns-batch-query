# dns-batch-query
dns 批量查询，用于批量域名查询缓冲，提高dns服务器命中率。
两个文件放置于同一路径；
修改chinalist.txt文件内容，为你所需要的域名列表，每行一个域名。


建议使用python脚本进行多线程查询。考虑dns服务器的查询可能有限制，线程数不要太高，并考虑加入延时。
windows无python使用bat，此脚本未完善。


