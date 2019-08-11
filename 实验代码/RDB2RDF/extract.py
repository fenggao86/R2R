#-*-encoding:utf-8-*-
# __author__ = 'liuxiao'
# __date__ = '2018/6/18'
# __Desc__ = 从数据库中提取信息

import pymysql

def extractmap ():
    # 连接数据库
    connect = pymysql.Connect(
        host='127.0.0.1',
        port=3306,
        user='root',
        passwd='123456',
        db='healthRDB3.12',
        charset='utf8'
    )
    cursor = connect.cursor()
    DataPropertyMap = {}
    ObjectPropertyMap = {}
    # 获取数据库中所有表名
    cursor.execute(
        "select table_name from information_schema.tables where table_schema='healthRDB3.12' and table_type='base table'")
    tablenames = cursor.fetchall()

    # 遍历每张表
    for row in tablenames:
        # query = "select * from "+row[0]
        # cursor.execute(query)
        # # 重置游标的位置
        # cursor.scroll(0,mode='absolute')
        # fields = cursor.description
        # print(fields)
        query = "select * from information_schema.columns where TABLE_NAME = '" + row[
            0] + "' and TABLE_SCHEMA = 'healthRDB3.12'"  #查询所有的列
        cursor.execute(query)
        columns_info = cursor.fetchall()
        # cursor.scroll(0, mode='absolute')
        query_1 = "select * from information_schema.KEY_COLUMN_USAGE where TABLE_NAME = '" + row[
            0] + "' and TABLE_SCHEMA = 'healthRDB3.12'"  # 查询所有主外键约束
        cursor.execute(query_1)
        pfcheck = cursor.fetchall()
        primary = []  # 表中所有主键name
        foreign = []  # 表中所有外键info
        foreign_name = []  # 表中所有外键name
        for check in pfcheck:
            if check[2] == "PRIMARY":
                primary.append(check[6])
            else:
                foreign_name.append(check[6])
                foreign.append(check)
        if len(columns_info) == 2 and len(foreign) == 2:  # 表中所有列都是另外两表的外键，则将表转为objectProperty

            keys = list(ObjectPropertyMap.keys())
            if columns_info[0][3] in keys:
                ObjectPropertyMap[columns_info[0][3]][foreign[1][10]] = foreign[0][10]
            else :
                domainrangeMap = {}
                domainrangeMap[foreign[1][10]] = foreign[0][10]
                ObjectPropertyMap[foreign[0][10]] = domainrangeMap

            if columns_info[1][3] in keys:
                ObjectPropertyMap[columns_info[0][3]][foreign[1][10]] = foreign[0][10]
            else:
                domainrangeMap = {}
                domainrangeMap[foreign[1][10]] = foreign[0][10]
                ObjectPropertyMap[foreign[0][10]] = domainrangeMap

        else:  # 否则将表转为class
            for column in columns_info:
                # 如果该列是外键
                if column[3] in foreign_name:
                    reference_tab = ""
                    for fk_info in foreign:
                        if fk_info[6] == column[3]:  # 找到该列的外键信息
                            reference_tab = fk_info[10]
                            keys = list(ObjectPropertyMap.keys())
                            if column[3] in keys:
                                ObjectPropertyMap[column[3]][row[0]] = reference_tab
                            else:
                                domainrangeMap = {}
                                domainrangeMap[row[0]] = reference_tab
                                ObjectPropertyMap[column[3]] = domainrangeMap
                elif (column[3] not in primary) and (column[3] not in foreign):  # 该列既不是主键也不是外键 即DataProperty
                    keys = list(DataPropertyMap.keys())
                    if column[3] in keys:
                        DataPropertyMap[column[3]][row[0]] = column[7]
                    else:
                        domainrangeMap = {}
                        domainrangeMap[row[0]] = column[7]
                        DataPropertyMap[column[3]] = domainrangeMap

    #  搜取所有结果
    # results = cursor.fetchall()
    map = {}
    map['dataproperty'] = DataPropertyMap
    map['objectproperty'] = ObjectPropertyMap
    return (map)
    cursor.close()
    connect.close()
