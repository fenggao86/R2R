#-*- coding:utf-8 –*-
__author__ = 'lxx'

import node
from operator import itemgetter, attrgetter

class fptree:
	def __init__(self,datas,support):
		self.pretable=[]
		self.datas=datas
		self.support=support
		self.headnode=node.node('null',None)
		self.headtable={}
	def getPretable(self):
		self.pretable=self.getpretable()
		self.pretable=[i for i in self.pretable if i[1]/float(len(self.datas)) >= self.support]
		#print(self.pretable)
	def getpretable(self):
		pretable={}
		for t in self.datas:
			for item in t:
				pretable.setdefault(item,0);
				pretable[item]+=1
		return sorted(pretable.items(),key=itemgetter(1,0),reverse = True)
	def getRootTree(self):
		nowheadtable={}
		for t in self.datas:
			headnode=self.headnode
			for itemset in self.pretable:
				for item in itemset:
					if item in t:
						thenode=headnode.findchildnode(item)
						if not thenode:
							thenode=node.node(item,headnode)
							headnode.child.append(thenode)
							self.headtable.setdefault(item,thenode)
							if item in nowheadtable.keys():
								nowheadtable[item].next=thenode
								nowheadtable[item]=thenode
							nowheadtable.setdefault(item,thenode)
						thenode.count+=1
						headnode=thenode
		#print(headnode)
		#print('fds')
		return self.headnode
	def getSubData(self,nodename,dim):
		subData = []
		support = []
		endNode = self.headtable[nodename]
		while endNode:
			nodeTemp = endNode
			vectorItem = []
			while nodeTemp.name != 'null':
				vectorItem.append(nodeTemp.name)
				nodeTemp = nodeTemp.parent
			if len(vectorItem) >= dim:
				subData.append(vectorItem)
				support.append(endNode.count)
			endNode = endNode.next
		return subData,support





