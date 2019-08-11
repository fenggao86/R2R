/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost
 Source Database       : healthRDB3.12

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : utf-8

 Date: 05/11/2019 20:30:54 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `BirthPlace`
-- ----------------------------
DROP TABLE IF EXISTS `BirthPlace`;
CREATE TABLE `BirthPlace` (
  `id` varchar(32) NOT NULL,
  `encodingType` varchar(8) CHARACTER SET utf8 NOT NULL,
  `encodingValue` varchar(32) CHARACTER SET utf8 NOT NULL,
  `encodingItem` varchar(8) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `BirthPlace`
-- ----------------------------
BEGIN;
INSERT INTO `BirthPlace` VALUES ('001', 'general', '420100', '武汉市'), ('002', 'general', '420106', '武昌区');
COMMIT;

-- ----------------------------
--  Table structure for `ChargeType`
-- ----------------------------
DROP TABLE IF EXISTS `ChargeType`;
CREATE TABLE `ChargeType` (
  `id` char(1) NOT NULL,
  `encodingType` varchar(255) NOT NULL,
  `encodingValue` varchar(3) NOT NULL,
  `encodingItem` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `ChargeType`
-- ----------------------------
BEGIN;
INSERT INTO `ChargeType` VALUES ('1', 'wuhan', '1', '收费'), ('2', 'wuhan', '2', '退费');
COMMIT;

-- ----------------------------
--  Table structure for `ContactRelation`
-- ----------------------------
DROP TABLE IF EXISTS `ContactRelation`;
CREATE TABLE `ContactRelation` (
  `id` varchar(8) NOT NULL,
  `encodingType` varchar(255) CHARACTER SET utf8 NOT NULL,
  `encodingValue` varchar(8) CHARACTER SET utf8 NOT NULL,
  `encodingItem` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `ContactRelation`
-- ----------------------------
BEGIN;
INSERT INTO `ContactRelation` VALUES ('0', 'yaxin', '0', '本人'), ('1', 'yaxin', '1', '配偶'), ('10', 'wuhan', '1', '配偶'), ('11', 'wuhan', '2', '子'), ('12', 'wuhan', '3', '女'), ('14', 'wuhan', '4', '孙子、孙女或外孙子、外孙女'), ('15', 'wuhan', '5', '父母'), ('16', 'wuhan', '6', '祖父母或外祖父母'), ('17', 'wuhan', '7', '兄、弟、姐、妹'), ('18', 'wuhan', '8', '其他'), ('2', 'yaxin', '2', '儿子'), ('3', 'yaxin', '3', '女儿'), ('4', 'yaxin', '4', '孙子、孙女或外孙子、外孙女'), ('5', 'yaxin', '5', '父母'), ('6', 'yaxin', '6', '祖父母或外祖父母'), ('7', 'yaxin', '7', '兄弟姐妹'), ('8', 'yaxin', '8', '同事同学'), ('9', 'yaxin', '9', '其他');
COMMIT;

-- ----------------------------
--  Table structure for `DetailedDoctorAdviceRecord`
-- ----------------------------
DROP TABLE IF EXISTS `DetailedDoctorAdviceRecord`;
CREATE TABLE `DetailedDoctorAdviceRecord` (
  `hasFacilityCode` varchar(22) NOT NULL,
  `hasDoctorAdviceID` varchar(32) NOT NULL,
  `hasInPatientCaseSerialID` varchar(50) NOT NULL,
  `hasDoctorAdviceRevokeMark` char(1) NOT NULL,
  `hasIDNumber` varchar(32) NOT NULL,
  `hasIDCardType` varchar(16) NOT NULL,
  `hasCurrentDisease` varchar(32) DEFAULT NULL,
  `hasIssuingFacilityDepartmentCode` varchar(15) NOT NULL,
  `hasIssuingFacilityDepartmentName` varchar(30) NOT NULL,
  `hasOrderingDoctorWorkID` varchar(16) NOT NULL,
  `hasOrderingDoctorName` varchar(32) NOT NULL,
  `hasOrderingTime` datetime NOT NULL,
  `hasExecutionDepartmentCode` varchar(15) NOT NULL,
  `hasExecutionDepartmentName` varchar(30) NOT NULL,
  `hasExecutorWorkID` varchar(16) DEFAULT NULL,
  `hasExecutorName` varchar(32) DEFAULT NULL,
  `hasStopperWorkID` varchar(16) DEFAULT NULL,
  `hasStopperWorkName` varchar(32) DEFAULT NULL,
  `hasBillingDepartmentCode` varchar(15) NOT NULL,
  `hasBillingDepartmentName` varchar(30) NOT NULL,
  `hasBillingDoctorWorkID` varchar(16) DEFAULT NULL,
  `hasBillingDoctorName` varchar(255) DEFAULT NULL,
  `hasRecordDateTime` datetime DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `hasDoctorAdviceText` varchar(256) DEFAULT NULL,
  `hasDetailedServiceCode` varchar(32) NOT NULL,
  `hasServiceName` varchar(256) NOT NULL,
  `hasMedicineName` varchar(32) DEFAULT NULL,
  `hasMedicineUsageFrequency` varchar(32) DEFAULT NULL,
  `hasMethodOfAdministration` varchar(4) DEFAULT NULL,
  `isSkinTest` char(1) DEFAULT NULL,
  `hasDecoctionOfChineseDrugCode` varchar(4) DEFAULT NULL,
  `isMainDrug` char(1) DEFAULT NULL,
  `hasPrice` decimal(12,3) DEFAULT NULL,
  `modification` decimal(1,0) NOT NULL,
  `hasConfidentiality` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`hasFacilityCode`,`hasDoctorAdviceID`),
  KEY `hasDoctorAdviceRevokeMark` (`hasDoctorAdviceRevokeMark`),
  KEY `hasInPatientCaseSerialID` (`hasInPatientCaseSerialID`),
  CONSTRAINT `detaileddoctoradvicerecord_ibfk_1` FOREIGN KEY (`hasDoctorAdviceRevokeMark`) REFERENCES `DoctorAdviceRevokeMark` (`id`),
  CONSTRAINT `detaileddoctoradvicerecord_ibfk_7` FOREIGN KEY (`hasInPatientCaseSerialID`) REFERENCES `InPatientCaseRecord` (`hasInPatientCaseSerialID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `DetailedFeeType`
-- ----------------------------
DROP TABLE IF EXISTS `DetailedFeeType`;
CREATE TABLE `DetailedFeeType` (
  `id` varchar(2) NOT NULL,
  `encodingType` varchar(255) NOT NULL,
  `encodingValue` varchar(2) NOT NULL,
  `encodingItem` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `DetailedFeeType`
-- ----------------------------
BEGIN;
INSERT INTO `DetailedFeeType` VALUES ('1', 'wuhan', '00', '挂号费'), ('10', 'wuhan', '09', '麻醉费'), ('11', 'wuhan', '10', '材料费'), ('12', 'wuhan', '13', '其他费用'), ('2', 'wuhan', '01', '西药费'), ('3', 'wuhan', '02', '中成药'), ('4', 'wuhan', '03', '中草药'), ('5', 'wuhan', '04', '诊查费（包括留观费）'), ('6', 'wuhan', '05', '检验费'), ('7', 'wuhan', '06', '检查费'), ('8', 'wuhan', '07', '治疗费'), ('9', 'wuhan', '08', '手术费');
COMMIT;

-- ----------------------------
--  Table structure for `DetailedInPatientFeeRecord`
-- ----------------------------
DROP TABLE IF EXISTS `DetailedInPatientFeeRecord`;
CREATE TABLE `DetailedInPatientFeeRecord` (
  `hasFacilityCode` varchar(22) NOT NULL,
  `hasDetailedInPatientFeeRecordID` varchar(64) NOT NULL,
  `hasChargeType` char(1) NOT NULL,
  `hasInPatientCaseSerialID` varchar(50) NOT NULL,
  `hasDoctorAdviceRecordID` varchar(32) DEFAULT NULL,
  `hasInvoiceID` varchar(32) DEFAULT NULL,
  `hasBillID` varchar(32) NOT NULL,
  `hasDetailedFeeType` varchar(2) DEFAULT NULL,
  `hasServiceCode` varchar(32) NOT NULL,
  `HealthInsuranceServiceCode` varchar(32) DEFAULT NULL,
  `hasServiceName` varchar(128) NOT NULL,
  `hasTotalPrice` decimal(12,3) NOT NULL,
  `modification` decimal(1,0) NOT NULL,
  `hasInternalPatientIDNumber` varchar(32) NOT NULL,
  `hasCaseRecordID` varchar(32) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`hasFacilityCode`,`hasDetailedInPatientFeeRecordID`,`hasChargeType`),
  KEY `hasDetailedFeeType` (`hasDetailedFeeType`),
  KEY `hasChargeType` (`hasChargeType`),
  KEY `hasInPatientCaseSerialID` (`hasInPatientCaseSerialID`),
  KEY `hasInternalPatientIDNumber` (`hasInternalPatientIDNumber`),
  CONSTRAINT `detailedinpatientfeerecord_ibfk_1` FOREIGN KEY (`hasDetailedFeeType`) REFERENCES `DetailedFeeType` (`id`),
  CONSTRAINT `detailedinpatientfeerecord_ibfk_2` FOREIGN KEY (`hasChargeType`) REFERENCES `ChargeType` (`id`),
  CONSTRAINT `detailedinpatientfeerecord_ibfk_3` FOREIGN KEY (`hasInPatientCaseSerialID`) REFERENCES `InPatientCaseRecord` (`hasInPatientCaseSerialID`),
  CONSTRAINT `detailedinpatientfeerecord_ibfk_6` FOREIGN KEY (`hasInternalPatientIDNumber`) REFERENCES `Patient` (`hasInternalPatientIDNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `DetailedOutEmergencyPatientFeeRecord`
-- ----------------------------
DROP TABLE IF EXISTS `DetailedOutEmergencyPatientFeeRecord`;
CREATE TABLE `DetailedOutEmergencyPatientFeeRecord` (
  `hasDetailedOutEmergencyFeeRecordID` varchar(64) NOT NULL,
  `hasChargeType` char(1) NOT NULL,
  `hasFacilityCode` varchar(32) NOT NULL,
  `hasOutPatientCaseSerialID` varchar(50) NOT NULL,
  `hasDepartmentName` varchar(50) DEFAULT NULL,
  `hasPrescriptionID` varchar(32) DEFAULT NULL,
  `hasInvoiceID` varchar(32) DEFAULT NULL,
  `hasChargeBillID` varchar(32) NOT NULL,
  `hasDetailedFeeType` varchar(2) NOT NULL,
  `hasRecordDateTime` datetime NOT NULL,
  `hasServiceCode` varchar(32) NOT NULL,
  `hasHealthInsuranceServiceCode` varchar(32) DEFAULT NULL,
  `hasServiceName` varchar(128) NOT NULL,
  `hasTotalPrice` decimal(12,3) NOT NULL,
  `modification` decimal(1,0) NOT NULL,
  `hasInternalPatientIDNumber` varchar(32) NOT NULL,
  PRIMARY KEY (`hasDetailedOutEmergencyFeeRecordID`,`hasChargeType`,`hasFacilityCode`),
  KEY `hasDetailedFeeType` (`hasDetailedFeeType`),
  KEY `hasChargeType` (`hasChargeType`),
  KEY `hasOutPatientCaseSerialID` (`hasOutPatientCaseSerialID`),
  KEY `hasInternalPatientIDNumber` (`hasInternalPatientIDNumber`),
  CONSTRAINT `detailedoutemergencypatientfeerecord_ibfk_1` FOREIGN KEY (`hasDetailedFeeType`) REFERENCES `DetailedFeeType` (`id`),
  CONSTRAINT `detailedoutemergencypatientfeerecord_ibfk_2` FOREIGN KEY (`hasChargeType`) REFERENCES `ChargeType` (`id`),
  CONSTRAINT `detailedoutemergencypatientfeerecord_ibfk_3` FOREIGN KEY (`hasOutPatientCaseSerialID`) REFERENCES `OutPatientCaseRecord` (`hasOutPatientCaseSerialID`),
  CONSTRAINT `detailedoutemergencypatientfeerecord_ibfk_6` FOREIGN KEY (`hasInternalPatientIDNumber`) REFERENCES `Patient` (`hasInternalPatientIDNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `DiagnosisCodeType`
-- ----------------------------
DROP TABLE IF EXISTS `DiagnosisCodeType`;
CREATE TABLE `DiagnosisCodeType` (
  `id` varchar(2) NOT NULL,
  `encodingType` varchar(255) NOT NULL,
  `encodingValue` varchar(2) NOT NULL,
  `encodingItem` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `DiagnosisCodeType`
-- ----------------------------
BEGIN;
INSERT INTO `DiagnosisCodeType` VALUES ('1', 'wuhan', '01', 'ICD-10'), ('2', 'wuhan', '02', 'GB/T 15657-1995');
COMMIT;

-- ----------------------------
--  Table structure for `DischargeSummaryRecord`
-- ----------------------------
DROP TABLE IF EXISTS `DischargeSummaryRecord`;
CREATE TABLE `DischargeSummaryRecord` (
  `hasInPatientCaseSerialID` varchar(50) NOT NULL,
  `hasFacilityCode` varchar(22) NOT NULL,
  `hasCaseRecordID` varchar(18) DEFAULT NULL,
  `hasDepartmentCode` varchar(15) NOT NULL,
  `hasDepartmentName` varchar(30) NOT NULL,
  `hasFacilityDistrictName` varchar(50) DEFAULT NULL,
  `hasRoomID` varchar(10) DEFAULT NULL,
  `hasBedID` varchar(16) NOT NULL,
  `hasPatientName` varchar(32) NOT NULL,
  `hasPatientGender` varchar(1) NOT NULL,
  `hasPatientAge` varchar(16) NOT NULL,
  `hasAdmissionTime` varchar(8) NOT NULL,
  `hasDischargeTime` varchar(8) NOT NULL,
  `hasLengthofStayInDays` varchar(5) NOT NULL,
  `hasDiagnosisCode` varchar(1024) DEFAULT NULL,
  `hasAdmissionDiagnosis` varchar(1024) DEFAULT NULL,
  `hasDischargeDiagnosis` varchar(1024) NOT NULL,
  `hasAdmissionSymptomsSigns` varchar(2048) NOT NULL,
  `hasDischargeSymptomsSigns` varchar(2048) DEFAULT NULL,
  `hasExaminationResultAndConsultationDescription` varchar(2048) NOT NULL,
  `hasSpecialExamination` varchar(1024) DEFAULT NULL,
  `hasTreatmentProcess` varchar(2048) NOT NULL,
  `hasComplication` varchar(1024) DEFAULT NULL,
  `hasDischargeSituation` varchar(2048) NOT NULL,
  `hasDoctorAdvice` varchar(2048) NOT NULL,
  `hasConditionTurnoutTypeCode` varchar(10) NOT NULL,
  `hasAttendingDoctorWorkID` varchar(16) NOT NULL,
  `hasAttendingDoctorName` varchar(32) NOT NULL,
  `hasResidentDoctorWorkID` varchar(16) NOT NULL,
  `hasResidentDoctorName` varchar(32) NOT NULL,
  `hasSignatureDateTime` datetime DEFAULT NULL,
  `hasInternalPatientIDNumber` varchar(32) NOT NULL,
  `hasFileLink` varchar(256) DEFAULT NULL,
  `hasConfidentiality` varchar(16) DEFAULT NULL,
  `hasAdmissionConditionDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`hasInPatientCaseSerialID`,`hasFacilityCode`),
  KEY `hasInternalPatientIDNumber` (`hasInternalPatientIDNumber`),
  CONSTRAINT `dischargesummaryrecord_ibfk_3` FOREIGN KEY (`hasInPatientCaseSerialID`) REFERENCES `InPatientCaseRecord` (`hasInPatientCaseSerialID`),
  CONSTRAINT `dischargesummaryrecord_ibfk_6` FOREIGN KEY (`hasInternalPatientIDNumber`) REFERENCES `Patient` (`hasInternalPatientIDNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Doctor`
-- ----------------------------
DROP TABLE IF EXISTS `Doctor`;
CREATE TABLE `Doctor` (
  `hasWorkIDNumber` varchar(16) NOT NULL,
  `hasFacilityCode` varchar(22) NOT NULL,
  `hasName` varchar(32) NOT NULL,
  `dateOfBirth` varchar(8) NOT NULL,
  `hasGender` varchar(5) NOT NULL,
  `hasIDNumber` varchar(32) DEFAULT NULL,
  `hasDepartmentCode` varchar(15) DEFAULT NULL,
  `hasJobCode` varchar(32) DEFAULT NULL,
  `hasJobName` varchar(32) DEFAULT NULL,
  `hasJobTitleName` varchar(32) DEFAULT NULL,
  `hasIntranetID` varchar(16) NOT NULL,
  `hasMajor` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`hasWorkIDNumber`,`hasFacilityCode`),
  KEY `hasGender` (`hasGender`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`hasGender`) REFERENCES `Gender` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `DoctorAdviceRevokeMark`
-- ----------------------------
DROP TABLE IF EXISTS `DoctorAdviceRevokeMark`;
CREATE TABLE `DoctorAdviceRevokeMark` (
  `id` char(1) NOT NULL,
  `encodingType` varchar(255) NOT NULL,
  `encodingValue` char(1) NOT NULL,
  `encodingItem` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `DoctorAdviceRevokeMark`
-- ----------------------------
BEGIN;
INSERT INTO `DoctorAdviceRevokeMark` VALUES ('1', 'wuhan', '1', '正常'), ('2', 'wuhan', '2', '撤销该医嘱');
COMMIT;

-- ----------------------------
--  Table structure for `EthnicGroup`
-- ----------------------------
DROP TABLE IF EXISTS `EthnicGroup`;
CREATE TABLE `EthnicGroup` (
  `id` varchar(6) NOT NULL,
  `encodingType` varchar(45) CHARACTER SET utf8 NOT NULL,
  `encodingValue` varchar(6) CHARACTER SET utf8 NOT NULL,
  `encodingItem` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `EthnicGroup`
-- ----------------------------
BEGIN;
INSERT INTO `EthnicGroup` VALUES ('001', 'general', '09', '布依族'), ('002', 'general', '01', '汉族');
COMMIT;

-- ----------------------------
--  Table structure for `Gender`
-- ----------------------------
DROP TABLE IF EXISTS `Gender`;
CREATE TABLE `Gender` (
  `id` varchar(5) NOT NULL,
  `encodingType` varchar(45) CHARACTER SET utf8 NOT NULL,
  `encodingValue` varchar(45) CHARACTER SET utf8 NOT NULL,
  `encodingItem` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `Gender`
-- ----------------------------
BEGIN;
INSERT INTO `Gender` VALUES ('1', 'yaxin', '0', '未知的性别'), ('2', 'yaxin', '1', '男'), ('3', 'yaxin', '2', '女'), ('4', 'yaxin', '9', '未说明的性别'), ('5', 'wuhan', '0', '未知的性别'), ('6', 'wuhan', '1', '男性'), ('7', 'wuhan', '2', '女性'), ('8', 'wuhan', '9', '未说明的性别');
COMMIT;

-- ----------------------------
--  Table structure for `InPatientCaseRecord`
-- ----------------------------
DROP TABLE IF EXISTS `InPatientCaseRecord`;
CREATE TABLE `InPatientCaseRecord` (
  `hasFacilityCode` varchar(22) NOT NULL,
  `hasInPatientCaseSerialID` varchar(50) NOT NULL,
  `hasInpatientID` varchar(32) NOT NULL,
  `hasPatientName` varchar(32) NOT NULL,
  `hasAttendingDoctorWorkID` varchar(18) DEFAULT NULL,
  `hasAttendingDoctorName` varchar(50) DEFAULT NULL,
  `hasAdmissionDepartmentCode` varchar(15) NOT NULL,
  `hasAdmissionDepartmentName` varchar(30) NOT NULL,
  `hasDischargeDepartmentCode` varchar(15) NOT NULL,
  `hasDischargeDepartmentName` varchar(30) NOT NULL,
  `hasDiagnosisCode` varchar(64) NOT NULL,
  `hasDiagnosisName` varchar(512) DEFAULT NULL,
  `hasDiagnosisCodeType` varchar(2) NOT NULL,
  `admissionTime` datetime NOT NULL,
  `diagnosedTime` datetime DEFAULT NULL,
  `hasAssuredTime` datetime DEFAULT NULL,
  `dischargedTime` datetime NOT NULL,
  `modification` decimal(1,0) NOT NULL,
  `hasConfidentiality` varchar(16) DEFAULT NULL,
  `hasMedicalFeeSource` varchar(2) DEFAULT NULL,
  `hasPatientJurisdiction` char(1) DEFAULT NULL,
  `hasCaseRecordID` varchar(18) DEFAULT NULL,
  `hasInternalPatientIDNumber` varchar(32) NOT NULL,
  PRIMARY KEY (`hasFacilityCode`,`hasInPatientCaseSerialID`),
  KEY `hasDiagnosisCodeType` (`hasDiagnosisCodeType`),
  KEY `hasMedicalFeeSource` (`hasMedicalFeeSource`),
  KEY `hasPatientJurisdiction` (`hasPatientJurisdiction`),
  KEY `hasInPatientCaseSerialID` (`hasInPatientCaseSerialID`),
  KEY `hasInternalPatientIDNumber` (`hasInternalPatientIDNumber`),
  CONSTRAINT `inpatientcaserecord_ibfk_10` FOREIGN KEY (`hasInternalPatientIDNumber`) REFERENCES `Patient` (`hasInternalPatientIDNumber`),
  CONSTRAINT `inpatientcaserecord_ibfk_6` FOREIGN KEY (`hasDiagnosisCodeType`) REFERENCES `DiagnosisCodeType` (`id`),
  CONSTRAINT `inpatientcaserecord_ibfk_8` FOREIGN KEY (`hasMedicalFeeSource`) REFERENCES `MedicalFeeSource` (`id`),
  CONSTRAINT `inpatientcaserecord_ibfk_9` FOREIGN KEY (`hasPatientJurisdiction`) REFERENCES `PatientJurisdiction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Marriage`
-- ----------------------------
DROP TABLE IF EXISTS `Marriage`;
CREATE TABLE `Marriage` (
  `id` varchar(2) NOT NULL,
  `encodingType` varchar(255) CHARACTER SET utf8 NOT NULL,
  `encodingValue` varchar(2) CHARACTER SET utf8 NOT NULL,
  `encodingItem` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `Marriage`
-- ----------------------------
BEGIN;
INSERT INTO `Marriage` VALUES ('1', 'yaxin', '1', '未婚'), ('10', 'general', '23', '复婚'), ('11', 'general', '30', '丧偶'), ('12', 'general', '40', '离婚'), ('13', 'general', '90', '未说明的婚姻状况\r'), ('2', 'yaxin', '2', '已婚'), ('3', 'yaxin', '3', '离异'), ('4', 'yaxin', '4', '丧偶'), ('5', 'yaxin', '9', '其他'), ('6', 'general', '10', '未婚'), ('7', 'general', '20', '已婚'), ('8', 'general', '21', '初婚'), ('9', 'general', '22', '再婚');
COMMIT;

-- ----------------------------
--  Table structure for `MedicalFeeSource`
-- ----------------------------
DROP TABLE IF EXISTS `MedicalFeeSource`;
CREATE TABLE `MedicalFeeSource` (
  `id` varchar(2) NOT NULL,
  `encodingType` varchar(255) CHARACTER SET utf8 NOT NULL,
  `encodingValue` varchar(3) CHARACTER SET utf8 NOT NULL,
  `encodingItem` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `MedicalFeeSource`
-- ----------------------------
BEGIN;
INSERT INTO `MedicalFeeSource` VALUES ('1', 'wuhan', '01', '城镇职工基本医疗保险'), ('10', 'yaxin', '1', '公费病人'), ('11', 'yaxin', '10', '武汉职保'), ('12', 'yaxin', '11', '基金会病人'), ('13', 'yaxin', '12', '明天计划'), ('14', 'yaxin', '13', '农村合作医疗'), ('15', 'yaxin', '13A', '湖北省农合'), ('16', 'yaxin', '13B', '安徽省农合'), ('17', 'yaxin', '13C', '河南省农合'), ('18', 'yaxin', '13D', '江西省农合'), ('19', 'yaxin', '13E', '武汉农合直补'), ('2', 'wuhan', '02', '城镇居民基本医疗保险'), ('20', 'yaxin', '13F', '湖北农合直补'), ('21', 'yaxin', '13G', '安徽农合直补'), ('22', 'yaxin', '13H', '江西农合直补'), ('23', 'yaxin', '13I', '河南农合直补'), ('24', 'yaxin', '14', '华夏基金'), ('25', 'yaxin', '15', '自费医保'), ('26', 'yaxin', '16', '商业保险'), ('27', 'yaxin', '17', '武汉居保'), ('28', 'yaxin', '18', '大学生医保'), ('29', 'yaxin', '19', '市外居保'), ('3', 'wuhan', '03', '新型农村合作医疗'), ('30', 'yaxin', '20', '省内大病救治'), ('31', 'yaxin', '21', '江西大病救治'), ('32', 'yaxin', '2', '家属'), ('33', 'yaxin', '3', '市外职保'), ('34', 'yaxin', '30', '低保'), ('35', 'yaxin', '31', '孝感医保'), ('36', 'yaxin', '32', '异地就医'), ('37', 'yaxin', '33', '青山离休'), ('38', 'yaxin', '34', '区高干'), ('39', 'yaxin', '35', '区高知'), ('4', 'wuhan', '04', '贫困救助'), ('40', 'yaxin', '36', '区离休高干'), ('41', 'yaxin', '37', '区企离休'), ('42', 'yaxin', '38', '区企优诊'), ('43', 'yaxin', '39', '区伤残'), ('44', 'yaxin', '39A', '区无职业伤残'), ('45', 'yaxin', '4', '自费病人'), ('46', 'yaxin', '40', '区行政离休'), ('47', 'yaxin', '41', '区优诊'), ('48', 'yaxin', '42', '生育医疗'), ('49', 'yaxin', '43', '市企离休'), ('5', 'wuhan', '05', '商业医疗保险'), ('50', 'yaxin', '44', '市伤残'), ('51', 'yaxin', '45', '市直保健'), ('52', 'yaxin', '46', '市直统筹'), ('53', 'yaxin', '47', '市直优诊'), ('54', 'yaxin', '48', '中南建筑设计院'), ('55', 'yaxin', '49', '区优抚'), ('56', 'yaxin', '5', '免号病人'), ('57', 'yaxin', '51', '特价病人'), ('58', 'yaxin', '52', '122交通事故'), ('59', 'yaxin', '53', '110绿色通道'), ('6', 'wuhan', '06', '全公费'), ('60', 'yaxin', '54', '计生'), ('61', 'yaxin', '55', '工伤保险'), ('62', 'yaxin', '6', '职工'), ('63', 'yaxin', '7', '包价病人'), ('64', 'yaxin', '8', '急救病人'), ('65', 'yaxin', '9', '款未到病人'), ('7', 'wuhan', '07', '全自费'), ('8', 'wuhan', '08', '其他社会保险'), ('9', 'wuhan', '99', '其他');
COMMIT;

-- ----------------------------
--  Table structure for `Nationality`
-- ----------------------------
DROP TABLE IF EXISTS `Nationality`;
CREATE TABLE `Nationality` (
  `id` varchar(10) NOT NULL,
  `encodingType` varchar(45) CHARACTER SET utf8 NOT NULL,
  `encodingValue` varchar(10) CHARACTER SET utf8 NOT NULL,
  `encodingItem` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `Nationality`
-- ----------------------------
BEGIN;
INSERT INTO `Nationality` VALUES ('001', 'general', '156', '中国'), ('002', 'general', '840', '美国'), ('1', 'yaxin', '1', '阿鲁巴'), ('10', 'yaxin', '10', '亚美尼亚'), ('100', 'yaxin', '100', '洪都拉斯'), ('101', 'yaxin', '101', '克罗地亚'), ('102', 'yaxin', '102', '海地'), ('103', 'yaxin', '103', '匈牙利'), ('104', 'yaxin', '104', '印度尼西亚'), ('105', 'yaxin', '105', '印度'), ('106', 'yaxin', '106', '英属印度洋领土'), ('107', 'yaxin', '107', '爱尔兰'), ('108', 'yaxin', '108', '伊朗'), ('109', 'yaxin', '109', '伊拉克'), ('11', 'yaxin', '11', '美属萨摩亚'), ('110', 'yaxin', '110', '冰岛'), ('111', 'yaxin', '111', '以色列'), ('112', 'yaxin', '112', '意大利'), ('113', 'yaxin', '113', '牙买加'), ('114', 'yaxin', '114', '约旦'), ('115', 'yaxin', '115', '日本'), ('116', 'yaxin', '116', '约翰斯顿岛'), ('117', 'yaxin', 'yaxin', '哈萨克斯坦'), ('118', 'yaxin', '118', '肯尼亚'), ('119', 'yaxin', '119', '吉尔斯坦'), ('12', 'yaxin', '12', '南极洲'), ('120', 'yaxin', '120', '柬埔寨'), ('121', 'yaxin', '121', '基里巴斯'), ('122', 'yaxin', '122', '圣基茨和尼维斯'), ('123', 'yaxin', '123', '韩国（南朝鲜）'), ('124', 'yaxin', '124', '科威特'), ('125', 'yaxin', '125', '老挝'), ('126', 'yaxin', '126', '黎巴嫩'), ('127', 'yaxin', '127', '利比里亚'), ('128', 'yaxin', '128', '利比亚'), ('129', 'yaxin', '129', '圣卢西亚'), ('13', 'yaxin', '13', '法属南部领土'), ('130', 'yaxin', '130', '列支敦土登'), ('131', 'yaxin', '131', '斯里兰卡'), ('132', 'yaxin', '132', '莱索托'), ('133', 'yaxin', '133', '立陶宛'), ('134', 'yaxin', '134', '卢森堡'), ('135', 'yaxin', '135', '拉脱维亚'), ('136', 'yaxin', '136', '澳门'), ('137', 'yaxin', '137', '摩洛哥'), ('138', 'yaxin', '138', '摩纳哥'), ('139', 'yaxin', '139', '摩尔多瓦'), ('14', 'yaxin', '14', '安提瓜和巴布达'), ('140', 'yaxin', '140', '马达加'), ('141', 'yaxin', '142', '马尔代夫'), ('142', 'yaxin', '143', '墨西哥'), ('143', 'yaxin', '144', '马绍尔群岛'), ('144', 'yaxin', '145', '中途岛'), ('145', 'yaxin', '146', '马其顿'), ('146', 'yaxin', '147', '马里'), ('147', 'yaxin', '148', '马耳他'), ('148', 'yaxin', '149', '缅甸'), ('15', 'yaxin', '15', '澳大利亚'), ('150', 'yaxin', '150', '蒙古'), ('151', 'yaxin', '151', '北马里亚纳'), ('152', 'yaxin', '152', '莫桑比克'), ('153', 'yaxin', '153', '毛里塔尼亚'), ('154', 'yaxin', '155', '蒙特'), ('155', 'yaxin', '156', '马提尼克'), ('156', 'yaxin', '157', '毛里求斯'), ('157', 'yaxin', '158', '马拉维'), ('158', 'yaxin', '159', '马来西亚'), ('159', 'yaxin', '160', '马约特'), ('16', 'yaxin', '16', '奥地利'), ('160', 'yaxin', '161', '纳米比亚'), ('161', 'yaxin', '162', '新喀里多尼亚'), ('162', 'yaxin', '163', '尼日尔'), ('163', 'yaxin', '164', '诺福克岛'), ('164', 'yaxin', '165', '尼日利亚'), ('165', 'yaxin', '166', '尼加拉瓜'), ('166', 'yaxin', '167', '纽埃'), ('167', 'yaxin', '168', '荷兰'), ('168', 'yaxin', '169', '挪威'), ('169', 'yaxin', '170', '尼波尔'), ('17', 'yaxin', '17', '阿塞拜疆'), ('170', 'yaxin', '171', '瑙鲁'), ('171', 'yaxin', '172', '中间地带'), ('172', 'yaxin', '173', '新西兰'), ('173', 'yaxin', '174', '阿曼'), ('174', 'yaxin', '175', '巴基斯坦'), ('175', 'yaxin', '176', '巴拿马'), ('176', 'yaxin', '177', '皮特凯恩群岛'), ('177', 'yaxin', '178', '秘鲁'), ('178', 'yaxin', '179', '菲律宾'), ('179', 'yaxin', '181', '贝劳'), ('18', 'yaxin', '18', '布隆迪'), ('180', 'yaxin', '182', '巴布亚'), ('181', 'yaxin', '183', '波兰'), ('182', 'yaxin', '184', '波多黎各'), ('183', 'yaxin', '185', '朝鲜'), ('184', 'yaxin', '186', '葡萄牙'), ('185', 'yaxin', '187', '巴拉圭'), ('186', 'yaxin', '188', '巴勒斯坦'), ('187', 'yaxin', '189', '法属菠利尼西亚'), ('188', 'yaxin', '190', '卡塔尔'), ('189', 'yaxin', '191', '留尼汪'), ('19', 'yaxin', '19', '比利时'), ('190', 'yaxin', '192', '罗马尼亚'), ('191', 'yaxin', '193', '俄罗斯'), ('192', 'yaxin', '194', '卢旺达'), ('193', 'yaxin', '213', '沙特阿拉伯'), ('194', 'yaxin', '195', '苏丹'), ('195', 'yaxin', '196', '塞内加尔'), ('196', 'yaxin', '217', '塞尔维亚'), ('197', 'yaxin', '198', '新加坡'), ('198', 'yaxin', '199', '南乔治亚岛'), ('199', 'yaxin', '200', '圣赫勒拿'), ('2', 'yaxin', '2', '阿富汗'), ('20', 'yaxin', '20', '贝宁'), ('200', 'yaxin', '201', '斯瓦尔巴群岛'), ('201', 'yaxin', '202', '所罗门群岛'), ('202', 'yaxin', '203', '塞拉利昂'), ('203', 'yaxin', '204', '萨尔瓦多'), ('204', 'yaxin', '205', '圣马力诺'), ('205', 'yaxin', '206', '索马里'), ('206', 'yaxin', '207', '圣皮埃尔和密克隆'), ('207', 'yaxin', '208', '塞班'), ('208', 'yaxin', '209', '圣多美和普林西比'), ('209', 'yaxin', '210', '苏里南'), ('21', 'yaxin', '21', '布基纳法索'), ('210', 'yaxin', '211', '斯洛伐克'), ('211', 'yaxin', '212', '斯洛文尼亚'), ('212', 'yaxin', '214', '瑞典'), ('213', 'yaxin', '215', '斯威士兰'), ('214', 'yaxin', '216', '锡金'), ('215', 'yaxin', '218', '塞舌尔'), ('216', 'yaxin', '219', '叙利亚'), ('217', 'yaxin', '220', '特克斯和凯科群岛'), ('218', 'yaxin', '221', '乍得'), ('219', 'yaxin', '222', '多哥'), ('22', 'yaxin', '22', '孟加拉国'), ('220', 'yaxin', '223', '泰国'), ('221', 'yaxin', '224', '塔吉克斯坦'), ('222', 'yaxin', '225', '托克劳'), ('223', 'yaxin', '226', '土库曼斯坦'), ('224', 'yaxin', '227', '东帝汶'), ('225', 'yaxin', '228', '汤加'), ('226', 'yaxin', '229', '特立尼达和多巴哥'), ('227', 'yaxin', '230', '突尼斯'), ('228', 'yaxin', '231', '土耳其'), ('229', 'yaxin', '232', '图瓦卢'), ('23', 'yaxin', '23', '保加利亚'), ('230', 'yaxin', '233', '台湾'), ('231', 'yaxin', '234', '坦桑尼亚'), ('232', 'yaxin', '235', '乌干达'), ('233', 'yaxin', '236', '乌克兰'), ('234', 'yaxin', '237', '美属太平洋各群岛'), ('235', 'yaxin', '238', '联合国'), ('236', 'yaxin', '239', '联合国'), ('237', 'yaxin', '240', '联合国'), ('238', 'yaxin', '241', '乌拉圭'), ('239', 'yaxin', '242', '美国'), ('24', 'yaxin', '24', '巴林'), ('240', 'yaxin', '243', '乌兹别克斯坦'), ('241', 'yaxin', '244', '梵蒂冈'), ('242', 'yaxin', '245', '圣文森特和格林纳丁斯'), ('243', 'yaxin', '246', '委内瑞拉'), ('244', 'yaxin', '247', '英属维尔京群岛'), ('245', 'yaxin', '248', '美属维尔京群岛'), ('246', 'yaxin', '249', '越南'), ('247', 'yaxin', '250', '瓦努阿图'), ('248', 'yaxin', '251', '威克岛'), ('249', 'yaxin', '252', '瓦利斯和富图纳群岛'), ('25', 'yaxin', '25', '巴哈马'), ('250', 'yaxin', '253', '西萨摩亚'), ('251', 'yaxin', '254', '无国籍（人）'), ('252', 'yaxin', '255', '无国籍（难民）'), ('253', 'yaxin', '256', '无国籍（未声明）'), ('254', 'yaxin', '257', '也门'), ('255', 'yaxin', '258', '南斯拉夫'), ('256', 'yaxin', '259', '南非'), ('257', 'yaxin', '197', '扎伊尔'), ('258', 'yaxin', '154', '赞比亚'), ('259', 'yaxin', '141', '津巴布韦'), ('26', 'yaxin', '26', '波斯尼亚和黑塞哥维那'), ('260', 'yaxin', '180', '津巴布韦'), ('27', 'yaxin', '27', '白俄罗斯'), ('28', 'yaxin', '28', '伯利兹'), ('29', 'yaxin', '29', '百幕大'), ('3', 'yaxin', '3', '安哥拉'), ('30', 'yaxin', '30', '玻利维亚'), ('31', 'yaxin', '31', '巴西'), ('32', 'yaxin', '32', '巴多斯'), ('33', 'yaxin', '33', '文莱'), ('34', 'yaxin', '34', '不丹'), ('35', 'yaxin', '35', '布维岛'), ('36', 'yaxin', '36', '博茨瓦纳'), ('37', 'yaxin', '37', '中非'), ('38', 'yaxin', '38', '加拿大'), ('39', 'yaxin', '39', '科斯群岛'), ('4', 'yaxin', '4', '安圭拉'), ('40', 'yaxin', '40', '瑞士'), ('41', 'yaxin', '41', '智利'), ('42', 'yaxin', '42', '中国'), ('43', 'yaxin', '43', '科特迪瓦'), ('44', 'yaxin', '44', '喀麦隆'), ('45', 'yaxin', '45', '刚果民主共和国'), ('46', 'yaxin', '46', '刚果'), ('47', 'yaxin', '47', '库克群岛'), ('48', 'yaxin', '48', '哥伦比亚'), ('49', 'yaxin', '49', '科摩罗'), ('5', 'yaxin', '5', '阿尔巴尼亚'), ('50', 'yaxin', '50', '佛得角'), ('51', 'yaxin', '51', '哥斯达黎加'), ('52', 'yaxin', '52', '古巴'), ('53', 'yaxin', '53', '圣诞岛'), ('54', 'yaxin', '54', '开曼群岛'), ('55', 'yaxin', '55', '塞浦路斯'), ('56', 'yaxin', '56', '捷克'), ('57', 'yaxin', '57', '德国'), ('58', 'yaxin', '58', '吉布提'), ('59', 'yaxin', '59', '多米尼加'), ('6', 'yaxin', '6', '安道尔'), ('60', 'yaxin', '60', '丹麦'), ('61', 'yaxin', '61', '多米尼家共和国'), ('62', 'yaxin', '62', '阿尔及利亚'), ('63', 'yaxin', '63', '厄瓜多尔'), ('64', 'yaxin', '64', '埃及'), ('65', 'yaxin', '65', '厄立特里亚'), ('66', 'yaxin', '66', '西撒哈拉'), ('67', 'yaxin', '67', '西班牙'), ('68', 'yaxin', '68', '爱沙尼亚'), ('69', 'yaxin', '69', '埃塞俄比亚'), ('7', 'yaxin', '7', '荷属安的列斯'), ('70', 'yaxin', '70', '芬兰'), ('71', 'yaxin', '71', '斐济'), ('72', 'yaxin', '72', '马尔维纳斯群岛'), ('73', 'yaxin', '73', '法国'), ('74', 'yaxin', '74', '法罗群岛'), ('75', 'yaxin', '75', '密克罗尼西亚'), ('76', 'yaxin', '76', '加蓬'), ('77', 'yaxin', '76', '英国（独立领土公民、出不用）'), ('78', 'yaxin', '78', '英国（海外民，出不用）'), ('79', 'yaxin', '79', '英国（海外公民，出不用）'), ('8', 'yaxin', '8', '阿联酋'), ('80', 'yaxin', '80', '英国（保护公民，出不用）'), ('81', 'yaxin', '81', '英国'), ('82', 'yaxin', '82', '英国（隶属，出不用）'), ('83', 'yaxin', '83', '格鲁吉亚'), ('84', 'yaxin', '84', '加纳'), ('85', 'yaxin', '85', '直布罗陀'), ('86', 'yaxin', '86', '几内亚'), ('87', 'yaxin', '87', '瓜德罗普'), ('88', 'yaxin', '88', '冈比亚'), ('89', 'yaxin', '89', '几内亚比绍'), ('9', 'yaxin', '9', '阿根廷'), ('90', 'yaxin', '90', '赤道几内亚'), ('91', 'yaxin', '91', '希腊'), ('92', 'yaxin', '92', '格林纳达'), ('93', 'yaxin', '93', '格陵兰'), ('94', 'yaxin', '94', '危地马拉'), ('95', 'yaxin', '95', '法属圭亚那'), ('96', 'yaxin', '96', '关岛'), ('97', 'yaxin', '97', '圭亚那'), ('98', 'yaxin', '98', '香港'), ('99', 'yaxin', '99', '赫德岛和麦克唐纳');
COMMIT;

-- ----------------------------
--  Table structure for `OutPatientCaseRecord`
-- ----------------------------
DROP TABLE IF EXISTS `OutPatientCaseRecord`;
CREATE TABLE `OutPatientCaseRecord` (
  `hasFacilityCode` varchar(22) NOT NULL,
  `hasOutPatientCaseSerialID` varchar(50) NOT NULL,
  `hasName` varchar(32) NOT NULL,
  `hasDepartmentCode` varchar(15) NOT NULL,
  `hasDepartmentName` varchar(30) NOT NULL,
  `visitTime` varchar(8) NOT NULL,
  `hasAttendingDoctorWorkID` varchar(16) NOT NULL,
  `hasAttendingDoctorName` varchar(32) NOT NULL,
  `hasDiagnosisCode` varchar(64) DEFAULT NULL,
  `hasDiagnosisName` varchar(512) DEFAULT NULL,
  `hasDiagnosisCodeType` varchar(2) DEFAULT NULL,
  `hasDiagnosisDescription` varchar(512) DEFAULT NULL,
  `currentDiseaseHistory` varchar(4000) DEFAULT NULL,
  `hasComplaint` varchar(2048) DEFAULT NULL,
  `modification` decimal(1,0) NOT NULL,
  `hasConfidentiality` varchar(16) DEFAULT NULL,
  `hasMedicalFeeSource` varchar(2) NOT NULL,
  `hasPatientJurisdiction` char(1) DEFAULT NULL,
  `hasInternalPatientIDNumber` varchar(32) NOT NULL,
  `hasSymptomDescription` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`hasFacilityCode`,`hasOutPatientCaseSerialID`),
  KEY `hasPatientJurisdiction` (`hasPatientJurisdiction`),
  KEY `hasDiagnosisCodeType` (`hasDiagnosisCodeType`),
  KEY `hasMedicalFeeSource` (`hasMedicalFeeSource`),
  KEY `hasOutPatientCaseSerialID` (`hasOutPatientCaseSerialID`),
  KEY `hasInternalPatientIDNumber` (`hasInternalPatientIDNumber`),
  CONSTRAINT `outpatientcaserecord_ibfk_10` FOREIGN KEY (`hasMedicalFeeSource`) REFERENCES `MedicalFeeSource` (`id`),
  CONSTRAINT `outpatientcaserecord_ibfk_11` FOREIGN KEY (`hasInternalPatientIDNumber`) REFERENCES `Patient` (`hasInternalPatientIDNumber`),
  CONSTRAINT `outpatientcaserecord_ibfk_4` FOREIGN KEY (`hasPatientJurisdiction`) REFERENCES `PatientJurisdiction` (`id`),
  CONSTRAINT `outpatientcaserecord_ibfk_7` FOREIGN KEY (`hasDiagnosisCodeType`) REFERENCES `DiagnosisCodeType` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `Patient`
-- ----------------------------
DROP TABLE IF EXISTS `Patient`;
CREATE TABLE `Patient` (
  `hasInternalPatientIDNumber` varchar(32) NOT NULL,
  `hasFacilityCode` varchar(22) NOT NULL,
  `hasIssuingRegion` varchar(6) CHARACTER SET utf8 NOT NULL,
  `hasIDNumber` varchar(32) DEFAULT NULL,
  `hasIDCardType` varchar(2) DEFAULT NULL,
  `hasGender` varchar(5) NOT NULL,
  `hasName` varchar(32) CHARACTER SET utf8 NOT NULL,
  `hasPatientJurisdiction` char(1) DEFAULT NULL,
  `hasMarriageStatus` varchar(2) DEFAULT NULL,
  `dateOfBirth` date DEFAULT NULL,
  `hasBirthPlace` varchar(32) DEFAULT NULL,
  `hasEthnicGroup` varchar(6) DEFAULT NULL,
  `hasNativePlace` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `hasNationality` varchar(10) DEFAULT NULL,
  `telephoneNumber` varchar(24) DEFAULT NULL,
  `mobilePhone` varchar(20) DEFAULT NULL,
  `workMailCode` varchar(6) DEFAULT NULL,
  `workPlaceName` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `workPlaceAddress` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `workPlacePhone` varchar(24) DEFAULT NULL,
  `hasJobName` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `homeAdderss` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `homePhone` varchar(24) DEFAULT NULL,
  `hukouPhone` varchar(24) DEFAULT NULL,
  `hukouAddress` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `addressInCity` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `addressInTown` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `addressInStreet` varchar(16) CHARACTER SET utf8 DEFAULT NULL,
  `hukouMailCode` varchar(6) DEFAULT NULL,
  `hasContactName` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `hasContactRelation` varchar(8) DEFAULT NULL,
  `hasContactAddress` varchar(128) CHARACTER SET utf8 DEFAULT NULL,
  `hasConfidentiality` varchar(16) DEFAULT NULL,
  `modificationTime` time(6) DEFAULT NULL,
  `modification` decimal(1,0) NOT NULL,
  `profileDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`hasFacilityCode`,`hasInternalPatientIDNumber`),
  KEY `hasMarriageStatus` (`hasMarriageStatus`),
  KEY `hasPatientJurisdiction` (`hasPatientJurisdiction`),
  KEY `hasGender` (`hasGender`),
  KEY `hasNationality` (`hasNationality`),
  KEY `birthPlace` (`hasBirthPlace`),
  KEY `hasContactRelation` (`hasContactRelation`),
  KEY `hasEthnicGroup` (`hasEthnicGroup`),
  KEY `hasInternalPatientIDNumber` (`hasInternalPatientIDNumber`),
  KEY `hasBirthPlace` (`hasBirthPlace`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`hasMarriageStatus`) REFERENCES `Marriage` (`id`),
  CONSTRAINT `patient_ibfk_4` FOREIGN KEY (`hasPatientJurisdiction`) REFERENCES `PatientJurisdiction` (`id`),
  CONSTRAINT `patient_ibfk_5` FOREIGN KEY (`hasGender`) REFERENCES `Gender` (`id`),
  CONSTRAINT `patient_ibfk_6` FOREIGN KEY (`hasNationality`) REFERENCES `Nationality` (`id`),
  CONSTRAINT `patient_ibfk_7` FOREIGN KEY (`hasBirthPlace`) REFERENCES `BirthPlace` (`id`),
  CONSTRAINT `patient_ibfk_8` FOREIGN KEY (`hasContactRelation`) REFERENCES `ContactRelation` (`id`),
  CONSTRAINT `patient_ibfk_9` FOREIGN KEY (`hasEthnicGroup`) REFERENCES `EthnicGroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `PatientJurisdiction`
-- ----------------------------
DROP TABLE IF EXISTS `PatientJurisdiction`;
CREATE TABLE `PatientJurisdiction` (
  `id` char(1) NOT NULL,
  `encodingType` varchar(255) CHARACTER SET utf8 NOT NULL,
  `encodingValue` char(1) CHARACTER SET utf8 NOT NULL,
  `encodingItem` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `PatientJurisdiction`
-- ----------------------------
BEGIN;
INSERT INTO `PatientJurisdiction` VALUES ('1', 'wuhan', '1', '本县区'), ('2', 'wuhan', '2', '本市其他县区'), ('3', 'wuhan', '3', '本省其他地市'), ('4', 'wuhan', '4', '外省'), ('5', 'wuhan', '5', '港澳台'), ('6', 'wuhan', '6', '外籍');
COMMIT;

-- ----------------------------
--  Table structure for `PersonalIDCardType`
-- ----------------------------
DROP TABLE IF EXISTS `PersonalIDCardType`;
CREATE TABLE `PersonalIDCardType` (
  `id` varchar(2) NOT NULL,
  `encodingType` varchar(45) CHARACTER SET utf8 NOT NULL,
  `encodingValue` varchar(45) CHARACTER SET utf8 NOT NULL,
  `encodingItem` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `PersonalIDCardType`
-- ----------------------------
BEGIN;
INSERT INTO `PersonalIDCardType` VALUES ('1', 'wuhan', '06', 'Exit-EntryPermitforHongKongandMacao'), ('2', 'wuhan', '07', 'Exit-EntryPermitforTaiwan'), ('3', 'wuhan', '02', 'HuKou'), ('4', 'wuhan', '04', 'MilitaryOfficerCard'), ('5', 'wuhan', '99', 'OtherLegitCertificate'), ('6', 'wuhan', '03', 'Passport'), ('7', 'wuhan', '01', 'ResidentIDCard');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
