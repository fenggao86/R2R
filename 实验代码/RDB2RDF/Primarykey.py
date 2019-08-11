#-*-encoding:utf-8-*-
# __author__ = 'liuxiao'
# __date__ = '2018/11/14'
# __Desc__ = '提取主键信息和实例信息'

import pymysql

def PKProperty():
    PKmap = {}
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
    # 获取数据库中所有表名
    cursor.execute(
        "select table_name from information_schema.tables where table_schema='healthRDB3.12' and table_type='base table'")
    tablenames = cursor.fetchall()

    Allprimary = [] #所有表中的所有主键
    # 遍历每张表
    for row in tablenames:
        query = "select * from information_schema.columns where TABLE_NAME = '" + row[
            0] + "' and TABLE_SCHEMA = 'healthRDB3.12'"  # 查询所有的列
        cursor.execute(query)
        columns_info = cursor.fetchall()
        # cursor.scroll(0, mode='absolute')
        query_1 = "select * from information_schema.KEY_COLUMN_USAGE where TABLE_NAME = '" + row[
            0] + "' and TABLE_SCHEMA = 'healthRDB3.12'"  # 查询所有主外键约束
        # print(query_1)
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
                # print(primary)
                # print(foreign)
        if len(columns_info) != 2 or len(foreign) != 2:  # 表中所有列都是另外两表的外键，则将表转为objectProperty# 否则将表转为class
            restriction = ""  # restriction
            property = ""  # property
            for column in columns_info:
                # 如果该列是主键 不是外键
                if column[3] in primary and column[3] not in foreign_name:
                    if column[3] not in Allprimary:
                        Allprimary.append(column[3])
                        property += "<owl:InverseFunctionalProperty rdf:ID = \"" + column[3] + "\"/>\n"
                    restriction += "  <rdfs:subClassOf >\n    <owl:Restriction >\n      <owl:onProperty rdf:resource = \"#" + \
                                    column[3] + "\"/>\n"
                    if column[7] == "int" or column[7] == "bigint" or column[7] == "decimal":
                        restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;nonNegativeInteger\">1</owl:minCardinality>\n"
                    elif column[7] == "datetime":
                        restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;dateTime\">1</owl:minCardinality>\n"
                    elif column[7] == "bool":
                        restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;boolean\">1</owl:minCardinality>\n"
                    else:
                        restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;string\">1</owl:minCardinality>\n"
                    restriction += "    </owl:Restriction>\n  </rdfs:subClassOf>\n"
                # 如果该列是外键
                if column[3] in foreign_name:
                    reference_tab = ""
                    for fk_info in foreign:
                        if fk_info[6] == column[3]:  # 找到该列的外键信息
                            reference_tab = fk_info[10]
                    if column[3] not in primary:  # 该列是外键不是主键
                        restriction += "  <rdfs:subClassOf>\n    <owl:Restriction>\n"
                        restriction += "      <owl:onProperty rdf:resource = \"#" + column[3] + "\" />\n"
                        restriction += "      <owl:allValuesFrom rdf:resource = \"#" + reference_tab + "\" />\n"
                        restriction += "    </owl:Restriction >\n  </rdfs:subClassOf>\n"
                    elif (column[3] in primary) and len(primary) > 1:  # 该外键是主键的一部分
                        restriction += "  <rdfs:subClassOf >\n    <owl:Restriction >\n      <owl:onProperty rdf:resource = \"#" + \
                                       column[3] + "\"/>\n"
                        if column[7] == "int" or column[7] == "bigint" or column[7] == "decimal":
                            restriction += "      <owl:cardinality rdf:datatype = \"&xsd;nonNegativeInteger\"> 1 </owl:cardinality>\n"
                        elif column[7] == "datetime":
                            restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;dateTime\">1</owl:minCardinality>\n"
                        elif column[7] == "bool":
                            restriction += "      <owl:cardinality rdf:datatype = \"&xsd;boolean\">1</owl:cardinality>\n"
                        else:
                            restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;string\">1</owl:minCardinality>\n"
                        restriction += "    </owl:Restriction >\n  </rdfs:subClassOf>\n"
                    elif (column[3] in primary) and len(primary) == 1:  # 该列既是外键又是唯一主键 对应于继承关系
                        restriction += "  <rdfs:subClassOf rdf:resource=\"#" + reference_tab + "\"/>\n"
                elif (column[3] not in primary) and (column[3] not in foreign):  # 该列既不是主键也不是外键
                    if column[6] == "NO":  # notnull约束
                        restriction += "  <rdfs:subClassOf >\n    <owl:Restriction >\n      <owl:onProperty rdf:resource = \"#" + \
                                       column[3] + "\"/>\n"
                        if column[7] == "int" or column[7] == "bigint" or column[7] == "decimal":
                            restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;nonNegativeInteger\">1</owl:minCardinality>\n"
                        elif column[7] == "bool":
                            restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;boolean\">1</owl:minCardinality>\n"
                        elif column[7] == "datetime":
                            restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;dateTime\">1</owl:minCardinality>\n"
                        else:
                            restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;string\">1</owl:minCardinality>\n"
                        restriction += "    </owl:Restriction >\n  </rdfs:subClassOf>\n"

            ##行映射为实例
            instance_str = ""
            # cursor.scroll(0, mode='absolute')  # 重置游标的位置
            query_2 = "select * from " + row[0]
            cursor.execute(query_2)
            instance_list = cursor.fetchall()
            instance_str = ""
            for instan in instance_list:
                instance_str += "<" + row[0] + ">\n"
                for index in range(len(instan)):
                    value = instan[index]
                    if columns_info[index][7] == "int" or column[7] == "bigint" or column[7] == "decimal":
                        instance_str += "  <" + columns_info[index][3] + "   rdf:datatype=\"&xsd;int\">"
                    elif column[7] == "datetime":
                        restriction += "      <owl:minCardinality rdf:datatype = \"&xsd;dateTime\">1</owl:minCardinality>\n"
                    elif columns_info[index][7] == "varchar" or columns_info[index][7] == "char":
                        instance_str += "  <" + columns_info[index][3] + "   rdf:datatype=\"&xsd;string\">"
                    elif column[7] == "bool":
                        instance_str += "  <" + columns_info[index][3] + "   rdf:datatype=\"&xsd;boolean\">"
                    else:
                        instance_str += "  <" + columns_info[index][3] + ">"
                    instance_str += str(value) + "</" + columns_info[index][3] + ">\n"
                instance_str += "</" + row[0] + ">\n\n"

        map = {}
        map['PKproperty'] = property
        map['restriction'] = restriction
        map['instance'] = instance_str
        PKmap[row[0]] = map

    return PKmap

            # file.write(property)
            # file.write("\n<owl:Class rdf:ID = \"" + row[0] + "\">\n")
            # file.write(restriction)
            # file.write("</owl:Class>\n\n")
            # file.write(instance_str)