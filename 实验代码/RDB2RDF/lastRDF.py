#-*-encoding:utf-8-*-
# __author__ = 'liuxiao'
# __date__ = '2018/11/14'
# __Desc__ = '聚合父类'

import pymysql
import Primarykey
from nltk.corpus import wordnet as wn

def mkdir(map):
    DataTypePropertyMap = map['dataproperty']
    ObjectPropertyMap = map['objectproperty']
    AllPropertyMap = map['class']
    DataPropertykeys = list(DataTypePropertyMap.keys())
    ObjectPropertykeys = list(ObjectPropertyMap.keys())
    ClassName = list(AllPropertyMap.keys())
    PKproperty = Primarykey.PKProperty()
    vocabulary = {
        'BirthPlace':['Birth','Place'],
        'ChargeType':['Charge','Type'],
        'ContactRelation':['Contact','Relation'],
        'DetailedDoctorAdviceRecord':['Doctor','Advice','Record'],
        'DetailedFeeType':['Fee','Type'],
        'DetailedInPatientFeeRecord':['In','Patient','Fee','Record'],
        'DetailedOutEmergencyPatientFeeRecord':['Out','Emergency','Patient','Fee','Record'],
        'DiagnosisCodeType':['Diagnosis','Code','Type'],
        'DischargeSummaryRecord':['Discharge','Summary','Record'],
        'DoctorAdviceRevokeMark':['Doctor','Advice','Revoke','Mark'],
        'EthnicGroup':['Ethnic','Group'],
        'Gender':['Gender'],
        'InPatientCaseRecord':['In','Patient','Case','Record'],
        'isAppointment':['Appointment'],
        'MarriageStatus':['Marriage','Status'],
        'MedicalFeeSource':['Medical','Fee','Source'],
        'Nationality':['Nationality'],
        'OutPatientCaseRecord':['Out','Patient','Case','Record'],
        'Patient':['Patient'],
        'PatientJurisdiction':['Patient','Jurisdiction'],
        'PersonalIDCardType':['Personal','ID','Card','Type'],
        'Doctor':['Doctor']
    }
    print (DataPropertykeys)
    print (ObjectPropertykeys)
    print (ClassName)

    file = open("output4.owl", "w")
    s1 = "<?xml version=\"1.0\"?>\n"
    s2 = "<!DOCTYPE rdf:RDF [\n  <!ENTITY xsd  \"http://www.w3.org/2001/XMLSchema#\" >\n]>\n"
    s3 = "<rdf:RDF xmlns=\"http://www.semanticweb.org/xzra/ontologies/2018/0/wust#\"\n"
    s4 = "    xml:base=\"http://www.semanticweb.org/xzra/ontologies/2018/0/wust\"\n"
    s5 = "    xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n"
    s6 = "    xmlns:owl=\"http://www.w3.org/2002/07/owl#\"\n"
    s7 = "    xmlns:xml=\"http://www.w3.org/XML/1998/namespace\"\n"
    s8 = "    xmlns:xsd=\"http://www.w3.org/2001/XMLSchema#\"\n"
    s9 = "    xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\">\n"
    s10 = "    <owl:Ontology rdf:about=\"http://www.semanticweb.org/xzra/ontologies/2018/0/wust\"/>\n\n"
    file.write(s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8 + s9 + s10)

    # domainArray = []
    for propertyName in ObjectPropertykeys:
        domainRange = ObjectPropertyMap[propertyName]
        if len(domainRange.keys()) == 0:
            objectProperty = "  <owl:ObjectProperty rdf:ID=\"" + propertyName + "\">\n"
            objectProperty += "  </owl:ObjectProperty>\n\n"
        elif len(domainRange.keys()) == 1:
            objectProperty = "  <owl:ObjectProperty rdf:ID=\"" + propertyName + "\">\n"
            objectProperty += "    <rdfs:domain rdf:resource=\"#" + domainRange.keys()[0] + "\"/>\n"
            objectProperty += "    <rdfs:range rdf:resource=\"#" + domainRange.values()[0] + "\"/>\n"
            objectProperty += "  </owl:ObjectProperty>\n\n"
        else:
            objectProperty = "  <owl:ObjectProperty rdf:ID=\"" + propertyName + "\">\n"
            objectProperty += "  </owl:ObjectProperty>\n\n"
            for domain in domainRange:
                objectProperty += "  <owl:ObjectProperty rdf:ID=\"" + domain + propertyName + "\">\n"
                objectProperty += "    <rdfs:subPropertyOf rdf:resource=\"#" + propertyName + "\"/>\n"
                objectProperty += "    <rdfs:domain rdf:resource=\"#" + domain + "\"/>\n"
                objectProperty += "    <rdfs:range rdf:resource=\"#" + domainRange[domain] + "\"/>\n"
                objectProperty += "  </owl:ObjectProperty>\n\n"
        file.write(objectProperty)

    for propertyName in DataPropertykeys:
        domainRange = DataTypePropertyMap[propertyName]
        if len(domainRange.keys()) == 0:
            dataProperty = "  <owl:DatatypeProperty rdf:ID=\"" + propertyName + "\">\n"
            dataProperty += "  </owl:DatatypeProperty>\n\n"
        elif len(domainRange.keys()) == 1:
            mydomin = domainRange.keys()[0]
            dataProperty = "  <owl:DatatypeProperty rdf:ID=\"" + propertyName + "\">\n"
            dataProperty += "    <rdfs:domain rdf:resource=\"#" + mydomin + "\"/>\n"
            # objectProperty += "    <rdfs:range rdf:resource=\"#" + domainRange[mydomin] + "\"/>\n"
            if domainRange[mydomin] == "int" or domainRange[mydomin] == "bigint" or domainRange[mydomin] == "decimal":
                dataProperty += "    <rdfs:range rdf:resource=" + "\"" + "&xsd;nonNegativeInteger" + "\"/>\n"
            elif domainRange[mydomin] == "bool":
                dataProperty += "    <rdfs:range rdf:resource=" + "\"" + "&xsd;boolean" + "\"/>\n"
            elif domainRange[mydomin] == "datetime":
                dataProperty += "    <rdfs:range rdf:resource=" + "\"" + "&xsd;dateTime" + "\"/>\n"
            else:
                dataProperty += "    <rdfs:range rdf:resource=" + "\"" + "&xsd;string" + "\"/>\n"
            dataProperty += "  </owl:DatatypeProperty>\n\n"
        else :
            # domainArray.append(domainRange.keys())
            dataProperty = "  <owl:DatatypeProperty rdf:ID=\"" + propertyName + "\">\n"
            dataProperty += "  </owl:DatatypeProperty>\n\n"
            for domain in domainRange:
                dataProperty += "  <owl:DatatypeProperty rdf:ID=\"" + domain + propertyName + "\">\n"
                dataProperty += "    <rdfs:subPropertyOf rdf:resource=\"#" + propertyName + "\"/>\n"
                dataProperty += "    <rdfs:domain rdf:resource=" + "\"#" + domain + "\"" + "/>\n"
                if domainRange[domain] == "int" or domainRange[domain] == "bigint" or domainRange[domain] == "decimal":
                    dataProperty += "    <rdfs:range rdf:resource=" + "\"" + "&xsd;nonNegativeInteger" + "\"/>\n"
                elif domainRange[domain] == "bool":
                    dataProperty += "    <rdfs:range rdf:resource=" + "\"" + "&xsd;boolean" + "\"/>\n"
                elif domainRange[domain] == "datetime":
                    dataProperty += "    <rdfs:range rdf:resource=" + "\"" + "&xsd;dateTime" + "\"/>\n"
                else:
                    dataProperty += "    <rdfs:range rdf:resource=" + "\"" + "&xsd;string" + "\"/>\n"
                dataProperty += "  </owl:DatatypeProperty>\n\n"
        file.write(dataProperty)



    coupleClass = {}
    inheritRelation = []
    repuClass = []
    for i in range(0, len(ClassName)):
        key1 = ClassName[i]
        key1Array = []
        for j in  range(i+1, len(ClassName)):
            key2 = ClassName[j]
            propertyArray1 = AllPropertyMap[key1]
            propertyArray2 = AllPropertyMap[key2]
            tmp = [val for val in propertyArray1 if val in propertyArray2]
            if len(tmp) > 4:
                key1Array.append(key2)
        if len(key1Array) > 0:
            coupleClass[key1] = key1Array
    for key in coupleClass.keys():
        vocabulary1 = vocabulary[key]
        repuClass.append(key)
        for key2 in coupleClass[key]:
            repuClass.append(key2)
            vocabulary2 = vocabulary[key2]
            classArr = []
            length = 0
            if len(vocabulary1) > len(vocabulary2):
                length = len(vocabulary2)
            else:
                length = len(vocabulary1)
            str = ''
            for i in range(0, length):
                word1 = vocabulary1[len(vocabulary1) - 1 - i]
                word2 = vocabulary2[len(vocabulary2) - 1 - i]
                right = wn.synset(word1 + '.n.01')
                minke = wn.synset(word2 + '.n.01')
                tmp = right.lowest_common_hypernyms(minke)#找到right与minke的最小普通上位词
                str = tmp[0].lemma_names()[0] + str
                if  tmp[0].lemma_names()[0] == 'entity' or tmp[0].lemma_names()[0] == 'abstraction':
                    break
                else:
                    classArr.append(str)
            print (key + " vs " + key2)
            # for k in range(0, len(classArr)):
            #     tmpmap = {}
            #     if k == 0:
            #         arr = [key,key2]
            #         tmpmap[classArr[len(classArr) - 1]] = arr
            #     else:
            #         tmpmap[classArr[len(classArr) - k - 1]] = map
            #     map = tmpmap
            if len(classArr) > 0:
                map1 = {}
                map2 = {}
                map1[key] = classArr
                map2[key2] = classArr
                inheritRelation.append(map1)
                inheritRelation.append(map2)
    print (inheritRelation)

    restrictionMap = {}
    newClass = []
    for name in repuClass:
        restrictionArr = []
        for k in range(0, len(inheritRelation)):
            map = {}
            map = inheritRelation[k]
            if list(map.keys())[0] == name:
                structArr = map[name]
                if structArr[len(structArr)-1] not in restrictionArr:
                    restrictionArr.append(structArr[len(structArr)-1])# +=
                for w in range(0,len(structArr)):
                    #列表前一个元素是后一个的父类
                    nowclass = structArr[len(structArr) - w - 1]
                    if w == len(structArr) - 1 :#第一个元素没有父类
                        if nowclass not in newClass:
                            newClass.append(nowclass)
                    else:
                        refer = ""
                        refer = structArr[len(structArr) - w - 2]
                        if nowclass in newClass:
                            resArr = restrictionMap[nowclass]
                            if refer not in resArr:
                                resArr.append(refer)
                                restrictionMap[nowclass] = refer
                                # restrictionMap[nowclass] += "  <rdfs:subClassOf rdf:resource=\"#" + refer + "\"/>\n"
                        else :
                            newClass.append(nowclass)
                            resArr = []
                            resArr.append(refer)
                            restrictionMap[nowclass] = resArr#"  <rdfs:subClassOf rdf:resource=\"#" + refer + "\"/>\n"

        if name in ClassName:
            restriction = ""
            if len(restrictionArr) == 2:
                str1 = restrictionArr[0]
                str2 = restrictionArr[1]
                if str1 in str2:
                    restriction += "  <rdfs:subClassOf rdf:resource=\"#" + str2 + "\"/>\n"
                if str2 in str1:
                    restriction += "  <rdfs:subClassOf rdf:resource=\"#" + str1 + "\"/>\n"
            else:
                for res in restrictionArr:
                    restriction +=  "  <rdfs:subClassOf rdf:resource=\"#" + res + "\"/>\n"
            restriction += PKproperty[name]['restriction']
            restrictionMap[name]= restriction

#写入新类
    for newClassname in newClass:
        file.write("\n<owl:Class rdf:ID = \"" + newClassname + "\">\n")
        if newClassname in restrictionMap:
            restriction = ""
            resArr = restrictionMap[newClassname]
            for res in resArr:
                restriction += "  <rdfs:subClassOf rdf:resource=\"#" + res + "\"/>\n"
            file.write(restriction)
        file.write("</owl:Class>\n\n")

#写入表中已有类
    for name in ClassName:
        if name not in newClassname:
            file.write(PKproperty[name]['PKproperty'])
            file.write("\n<owl:Class rdf:ID = \"" + name + "\">\n")
            if name in restrictionMap.keys():
                file.write(restrictionMap[name])
            else:
                file.write(PKproperty[name]['restriction'])
            file.write("</owl:Class>\n\n")
            file.write(PKproperty[name]['instance'])

    file.write("</rdf:RDF >")

