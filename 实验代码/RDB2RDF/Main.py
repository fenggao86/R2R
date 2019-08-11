#-*-encoding:utf-8-*-
# __author__ = 'liuxiao'
# __date__ = '2018/01/20'
# __Desc__ = RDB-->RDF

import time
import Converter
import Redundancy
import NewRDF
import  MkdirRDF
import lastRDF
import extractProerty
import nltk
from nltk.corpus import wordnet as wn
import sys
reload(sys)
sys.setdefaultencoding('utf-8')



def run():
    #用原有规则提取RDF
    # Converter.converter();#output1.owl
    #
    # #通过合并相同属性的domain range来去除冗余
    # map = extractProerty.extractmap()
    # MkdirRDF.mkdir(map)  #output2.owl
    #
    # #合并相同属性的domain range成为父属性，subPropertyof保留子属性。
    # map = extractProerty.extractmap()
    # NewRDF.mkdir(map)  #output3.owl
    #
    # #将相似的类聚合出父类subClassof
    map = extractProerty.extractmap()
    lastRDF.mkdir(map)  #output4.owl

    # word = 'In'
    # if wn.synsets(word) != []:
    #     print("{}是一个单词".format(word))
    # else:
    #     print("{}不是一个单词".format(word))

    #right = wn.synset('city.n.01')
    # minke = wn.synset('address.n.01')
    # tmp = right.lowest_common_hypernyms(minke)#找到right与minke的最小普通上位词
    # str = tmp[0].lemma_names()[0]
   # print (str)

    #Redundancy.redundancy()









if __name__ == '__main__':
    run()




