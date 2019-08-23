# R2R
实验分为两个部分：
1、	将关系数据库转为OWL本体
实验数据来自某医院的关系数据库healthRDB3.12.sql。实验代码RDB2RDF使用python来从RDB构建RDF:
在main.py中首先调用extractProerty.py抽取出数据库中的ObjectProperty、DataTypeProperty、Class等信息。接着调用lastRDF.mkdir将抽取的信息用OWL元素表示，输出一个OWL文件。
另外包括一个对数据库中的组合词表名进行分词的实验fenci，分别用正向、逆向、双向最大匹配算法，以WordNet为词典进行分词。
2、	从关系数据库中挖掘关联规则
实验数据来自：http://fimi.uantwerpen.be/data/ 和http://www.philippe-fournier-viger.com/spmf/index.php?link=datasets.php
实验分别用Apriori算法、FPgrowth算法及Apriori_FPtree算法进行关联规则挖掘，其中Apriori_FPtree算法是对Apriori算法与FPgrowth算法的结合。
