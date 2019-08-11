__author__ = 'Liu Xiao'
import time
import nltk
from nltk.corpus import wordnet as wn

def  FMM(word):
    # 正向
    my_list = [];
    while len(word) > 0:
        lenth = 12
        if len(word) < lenth:
            lenth = len(word)
        tryWord = word[0:lenth]
        while wn.synsets(tryWord) == []:
            if len(tryWord) == 1:
                break
            tryWord = tryWord[0:len(tryWord) - 1]
        my_list.append(tryWord)
        word = word[len(tryWord):]
    return my_list
def BMM(word):
    # 逆向最大匹配算法
    my_list = [];
    while len(word) > 0:
        lenth = 12
        if len(word) < lenth:
            lenth = len(word)
        tryWord = word[-lenth:]
        while wn.synsets(tryWord) == []:
            if len(tryWord) == 1:
                break
            tryWord = tryWord[1:]
        my_list.append(tryWord)
        word = word[0:len(word) - len(tryWord)]
    return my_list

def SegDouble(word):
    # 双向最大匹配算法
    list_FMM = FMM(word)
    list_BMM = BMM(word)
    if len(list_BMM) != len(list_FMM):
        if len(list_FMM) > len(list_BMM):
            return list_BMM
        else:
            return list_FMM
    else:
        iFMM = 0
        iBMM = 0
        isSame = True
        for index in range(len(list_BMM)):
            if list_FMM[index] != list_BMM[index]:
                isSame = False
            if len(list_FMM[index]) == 1:
                iFMM = iFMM + 1
            if len(list_BMM[index]) ==1:
                iBMM = iBMM + 1
        if isSame:
            return list_FMM
        else:
            return list_FMM if iFMM < iBMM else list_BMM

def run():
    wordList = ['Birthplace','Chargetype','ContactRelation','Detaileddoctoradvicerecord',
    'DetailedFeeType',
    'Detailedinpatientfeerecord',
    'DetailedOutEmergencyPatientFeeRecord',
    'Diagnosiscodetype',
    'Dischargesummaryrecord',
    'DoctorAdviceRevokeMark',
    'EthnicGroup',
    'InpatientCaserecord',
    'Medicalfeesource',
    'Outpatientcaserecord',
    'Patientjurisdiction',
    'Personalidcardtype',
    'Doctor',
    'Gender',
    'Marriage',
    'Nationality',
    'Patient']
    for word in wordList:
        # word = "Dischargesummaryrecord"
        list = SegDouble(word)
        print list

if __name__ == '__main__':
    starttime = time.time()
    run()
    endtime = time.time()

    print (endtime - starttime)



