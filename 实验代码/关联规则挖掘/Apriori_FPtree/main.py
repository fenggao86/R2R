import FPtree
import datetime
from operator import itemgetter, attrgetter

def load_data_set():
    """
    Load a sample data set (From Data Mining: Concepts and Techniques, 3th Edition)
    Returns:
        A data set: A list of transactions. Each transaction contains several items.
    """
    # data_set = [['l1', 'l2', 'l5'], ['l2', 'l4'], ['l2', 'l3'],
    #         ['l1', 'l2', 'l4'], ['l1', 'l3'], ['l2', 'l3'],
    #         ['l1', 'l3'], ['l1', 'l2', 'l3', 'l5'], ['l1', 'l2', 'l3']]
    file = open("T104D")
    text = file.readlines()
    data_set = []
    for fields in text:
        fields = fields.strip('\n')
        fields = fields.split(' ')
        if '' in fields:
            fields.remove('')
        data_set.append(fields)
    return data_set

def adjacencyMatrix(data_set,min_support,support_data):
    indexMa = []
    L1 = set()
    L2 = set()
    for t in data_set:
        for item in t:
            if item not in indexMa:
                indexMa.append(item)
    matrix = [[0 for i in range(len(indexMa))] for i in range(len(indexMa))]
    t_num = float(len(data_set))
    support_L1 = {}
    for t in data_set:
        index = []
        for item in t:
             index.append(indexMa.index(item))
        for i in range(len(index)):
            matrix[index[i]][index[i]] += 1
            for j in range(i+1,len(index)):
                matrix[index[i]][index[j]] += 1
                matrix[index[j]][index[i]] += 1
    for i in range(len(indexMa)):
        for j in range(len(indexMa)):
            if i == j:
                item = frozenset([indexMa[i]])
                if (matrix[i][j] / t_num) >= min_support:
                    L1.add(item)
                    support_L1[indexMa[i]] = matrix[i][j] / t_num
                    support_data[item] = matrix[i][j] / t_num
            if i < j:
                item = frozenset([indexMa[i],indexMa[j]])
                if (matrix[i][j] / t_num) >= min_support:
                    L2.add(item)
                    support_data[item] = matrix[i][j] / t_num
    return L1,L2,support_L1




def create_C1(data_set):
    """
    Create frequent candidate 1-itemset C1 by scaning data set.
    Args:
        data_set: A list of transactions. Each transaction contains several items.
    Returns:
        C1: A set which contains all frequent candidate 1-itemsets
    """
    C1 = set()
    for t in data_set:
        for item in t:
            item_set = frozenset([item])
            C1.add(item_set)
    return C1


def is_apriori(Ck_item, Lksub1):
    """
    Judge whether a frequent candidate k-itemset satisfy Apriori property.
    Args:
        Ck_item: a frequent candidate k-itemset in Ck which contains all frequent
                 candidate k-itemsets.
        Lksub1: Lk-1, a set which contains all frequent candidate (k-1)-itemsets.
    Returns:
        True: satisfying Apriori property.
        False: Not satisfying Apriori property.
    """
    for item in Ck_item:
        sub_Ck = Ck_item - frozenset([item])
        if sub_Ck not in Lksub1:
            return False
    return True


def create_Ck(Lksub1, k):
    """
    Create Ck, a set which contains all all frequent candidate k-itemsets
    by Lk-1's own connection operation.
    Args:
        Lksub1: Lk-1, a set which contains all frequent candidate (k-1)-itemsets.
        k: the item number of a frequent itemset.
    Return:
        Ck: a set which contains all all frequent candidate k-itemsets.
    """
    Ck = set()
    len_Lksub1 = len(Lksub1)
    Lksub = list(Lksub1)
    for i in range(len_Lksub1):
        for j in range(1, len_Lksub1):
            l1 = list(Lksub[i])
            l2 = list(Lksub[j])
            l1.sort()
            l2.sort()
            if l1[0:k-2] == l2[0:k-2]:
                Ck_item = Lksub[i] | Lksub[j]
                # pruning
                if is_apriori(Ck_item, Lksub1):
                    Ck.add(Ck_item)
    return Ck


def generate_Lk_by_Ck(fptree, data_set, Ck,dim, min_support, support_data):
    """
    Generate Lk by executing a delete policy from Ck.
    Args:
        data_set: A list of transactions. Each transaction contains several items.
        Ck: A set which contains all all frequent candidate k-itemsets.
        min_support: The minimum support.
        support_data: A dictionary. The key is frequent itemset and the value is support.
    Returns:
        Lk: A set which contains all all frequent k-itemsets.
    """
    Lk = set()
    item_count = {}
    t_num = float(len(data_set))
    if dim == 1:
        for t in data_set:
            for item in Ck:
                if item.issubset(t):
                    if item not in item_count:
                        item_count[item] = 1
                    else:
                        item_count[item] += 1
        t_num = float(len(data_set))
    else:
        for item in Ck:
            array = list(item)
            subData, support = fptree.getSubData(array[len(array) - 1], dim)
            for i in range(0, len(subData)):
                if item.issubset(subData[i]):
                    if item not in item_count:
                        item_count[item] = support[i]
                    else:
                        item_count[item] += support[i]
    for item in item_count:
        if (item_count[item] / t_num) >= min_support:
            Lk.add(item)
            support_data[item] = item_count[item] / t_num

    return Lk




def generate_L(data_set, k, min_support):
    """
    Generate all frequent itemsets.
    Args:
        data_set: A list of transactions. Each transaction contains several items.
        k: Maximum number of items for all frequent itemsets.
        min_support: The minimum support.
    Returns:
        L: The list of Lk.
        support_data: A dictionary. The key is frequent itemset and the value is support.
    """
    fptree = FPtree.fptree(data_set, min_support)
    print("pre:",datetime.datetime.now())
    fptree.getPretable()
    print("pre:",datetime.datetime.now())
    fptree.getRootTree()
    support_data = {}

    # L1,L2,support_L1 = adjacencyMatrix(data_set,min_support,support_data)
    # pretable = sorted(support_L1.items(), key=itemgetter(1, 0), reverse=True)
    # fptree = FPtree.fptree(data_set, min_support,pretable)
    # fptree.getRootTree()
    # Lksub1 = L2.copy()
    C1 = create_C1(data_set)
    # print (C1)
    # print ("=====================")
    L1 = generate_Lk_by_Ck(fptree,data_set, C1,1, min_support, support_data)
    Lksub1 = L1.copy()
    L = []
    L.append(Lksub1)
    for i in range(2, k+1):
        Ci = create_Ck(Lksub1, i)
        # print (Ci)
        # print ("=====================")
        Li = generate_Lk_by_Ck(fptree, data_set, Ci, i, min_support, support_data)
        Lksub1 = Li.copy()
        L.append(Lksub1)
    return L, support_data


def generate_big_rules(L, support_data, min_conf):
    """
    Generate big rules from frequent itemsets.
    Args:
        L: The list of Lk.
        support_data: A dictionary. The key is frequent itemset and the value is support.
        min_conf: Minimal confidence.
    Returns:
        big_rule_list: A list which contains all big rules. Each big rule is represented
                       as a 3-tuple.
    """
    big_rule_list = []
    sub_set_list = []
    for i in range(0, len(L)):
        for freq_set in L[i]:
            for sub_set in sub_set_list:
                if sub_set.issubset(freq_set):
                    conf = support_data[freq_set] / support_data[freq_set - sub_set]
                    big_rule = (freq_set - sub_set, sub_set, conf)
                    if conf >= min_conf and big_rule not in big_rule_list:
                        # print freq_set-sub_set, " => ", sub_set, "conf: ", conf
                        big_rule_list.append(big_rule)
            sub_set_list.append(freq_set)
    return big_rule_list


if __name__ == "__main__":
    """
    Test
    """

    data_set = load_data_set()
    min_support = 0.4
    starttime = datetime.datetime.now()
    L, support_data = generate_L(data_set, 2, min_support)
    endtime = datetime.datetime.now()
    print (endtime - starttime)
    print (L)
    # big_rules_list = generate_big_rules(L, support_data, min_conf=0.7)
    # for Lk in L:
    #     print "="*50
    #     print "frequent " + str(len(list(Lk)[0])) + "-itemsets\t\tsupport"
    #     print "="*50
    #     for freq_set in Lk:
    #         print freq_set, support_data[freq_set]
    # print
    # print "Big Rules"
    # for item in big_rules_list:
    #     print item[0], "=>", item[1], "conf: ", item[2]
