#-*-encoding:utf-8-*-
# __author__ = 'liuxiao'
# __date__ = '2018/11/14'
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
    ClassMap = {}
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
        propertyArr = [] #表中的所有属性
        for column in columns_info:
            propertyArr.append(column[3])
        for check in pfcheck:
            if check[2] == "PRIMARY":
                primary.append(check[6])
            else:
                foreign_name.append(check[6])
                foreign.append(check)
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
        if len(columns_info) == 2 and len(foreign) == 2: #表中两列是另外两表的外键，则该表不转为class
            print ('关联表')
        else:
            ClassMap[row[0]] = propertyArr



    #  搜取所有结果
    # results = cursor.fetchall()
    map = {}
    map['dataproperty'] = DataPropertyMap
    map['objectproperty'] = ObjectPropertyMap
    map['class'] = ClassMap   #表中的所有列
    return (map)
    cursor.close()
    connect.close()
