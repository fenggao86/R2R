#-*-encoding:utf-8-*-
# __author__ = 'liuxiao'
# __date__ = '2018/6/9'
# __Desc__ = 用sparkl查询去除冗余属性


import rdflib
import re
from rdflib import Namespace,RDF

def redundancy ():
    g1 = rdflib.Graph()
    g1.parse("./output1.owl",format="xml")
    ns = Namespace('http://www.semanticweb.org/xzra/ontologies/2018/0/wust#')
    ans1 = []
    for s in g1.all_nodes():
        #if (s.comment):
        #    print s.comment
        ans1.append(s)
    print ans1