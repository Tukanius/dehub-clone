part of '../models/finance.dart';

Finance _$FinanceFromJson(Map<String, dynamic> json) {
  return Finance(
    count: json['count'] != null ? int.parse(json['count'].toString()) : null,
    recourseDays: json['recourseDays'] != null
        ? int.parse(json['recourseDays'].toString())
        : null,
    rows: json['rows'] != null
        ? (json['rows'] as List).map((e) => Finance.fromJson(e)).toList()
        : null,
    byProgram: json['byProgram'] != null
        ? (json['byProgram'] as List).map((e) => Finance.fromJson(e)).toList()
        : null,
    byInterval: json['byInterval'] != null
        ? (json['byInterval'] as List).map((e) => Finance.fromJson(e)).toList()
        : null,
    numberSurvey: json['numberSurvey'] != null
        ? (json['numberSurvey'] as List).map((e) => Stats.fromJson(e)).toList()
        : null,
    businessIds: json['businessIds'] != null
        ? (json['businessIds'] as List).map((e) => e as String).toList()
        : null,
    payments: json['payments'] != null
        ? (json['payments'] as List).map((e) => Finance.fromJson(e)).toList()
        : null,
    urls: json['urls'] != null
        ? (json['urls'] as List).map((e) => Urls.fromJson(e)).toList()
        : null,
    compromises: json['compromises'] != null
        ? (json['compromises'] as List).map((e) => Finance.fromJson(e)).toList()
        : null,
    requestFiles: json['requestFiles'] != null
        ? (json['requestFiles'] as List)
            .map((e) => Finance.fromJson(e))
            .toList()
        : null,
    url: json['url'] != null ? Uri.parse(json['url'.toString()]) : null,
    id: json['id'] != null ? json['id'] as String : null,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'].toString())
        : null,
    openDate: json['openDate'] != null ? json['openDate'] as String : null,
    loanStatus:
        json['loanStatus'] != null ? json['loanStatus'] as String : null,
    accountCategory: json['accountCategory'] != null
        ? json['accountCategory'] as String
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'].toString())
        : null,
    confirmedDate: json['confirmedDate'] != null
        ? DateTime.parse(json['confirmedDate'].toString())
        : null,
    invDueDate: json['invDueDate'] != null
        ? DateTime.parse(json['invDueDate'].toString())
        : null,
    invoices: json['invoices'] != null
        ? (json['invoices'] as List).map((e) => Finance.fromJson(e)).toList()
        : null,
    deletedAt: json['deletedAt'] != null
        ? DateTime.parse(json['deletedAt'].toString())
        : null,
    paymentDate: json['paymentDate'] != null
        ? DateTime.parse(json['paymentDate'].toString())
        : null,
    sentDate: json['sentDate'] != null
        ? DateTime.parse(json['sentDate'].toString())
        : null,
    suppPenaltyType: json['suppPenaltyType'] != null
        ? json['suppPenaltyType'] as String
        : null,
    buyerPenaltyType: json['buyerPenaltyType'] != null
        ? json['buyerPenaltyType'] as String
        : null,
    partnerId: json['partnerId'] != null ? json['partnerId'] as String : null,
    periodInMonths: json['periodInMonths'] != null
        ? int.parse(json['periodInMonths'].toString())
        : null,
    periodInDays: json['periodInDays'] != null
        ? int.parse(json['periodInDays'].toString())
        : null,
    participantStatus: json['participantStatus'] != null
        ? json['participantStatus'] as String
        : null,
    lbfAccount:
        json['lbfAccount'] != null ? json['lbfAccount'] as String : null,
    accountId: json['accountId'] != null ? json['accountId'] as String : null,
    nextInstallmentDueDate: json['nextInstallmentDueDate'] != null
        ? json['nextInstallmentDueDate'] as String
        : null,
    invoiceRef:
        json['invoiceRef'] != null ? json['invoiceRef'] as String : null,
    lbfProgramId:
        json['lbfProgramId'] != null ? json['lbfProgramId'] as String : null,
    clientText:
        json['clientText'] != null ? json['clientText'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    lbfProgramStatus: json['lbfProgramStatus'] != null
        ? json['lbfProgramStatus'] as String
        : null,
    phoneNumber:
        json['phoneNumber'] != null ? json['phoneNumber'] as String : null,
    lbfRequestStatus: json['lbfRequestStatus'] != null
        ? json['lbfRequestStatus'] as String
        : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    contractFile:
        json['contractFile'] != null ? json['contractFile'] as String : null,
    suppFeeRule:
        json['suppFeeRule'] != null ? json['suppFeeRule'] as String : null,
    disbursementRef: json['disbursementRef'] != null
        ? json['disbursementRef'] as String
        : null,
    buyerFeeRule:
        json['buyerFeeRule'] != null ? json['buyerFeeRule'] as String : null,
    paymentMethod:
        json['paymentMethod'] != null ? json['paymentMethod'] as String : null,
    paymentStatus:
        json['paymentStatus'] != null ? json['paymentStatus'] as String : null,
    contractFiles: json['contractFiles'] != null
        ? (json['contractFiles'] as List).map((e) => e as String).toList()
        : null,
    bankName: json['bankName'] != null ? json['bankName'] as String : null,
    shortName: json['shortName'] != null ? json['shortName'] as String : null,
    programStatus:
        json['programStatus'] != null ? json['programStatus'] as String : null,
    lbfRequestId:
        json['lbfRequestId'] != null ? json['lbfRequestId'] as String : null,
    username: json['username'] != null ? json['username'] as String : null,
    accountNumber:
        json['accountNumber'] != null ? json['accountNumber'] as String : null,
    number: json['number'] != null ? json['number'] as String : null,
    repaymentStatus: json['repaymentStatus'] != null
        ? json['repaymentStatus'] as String
        : null,
    name: json['name'] != null ? json['name'] as String : null,
    invoiceStatus:
        json['invoiceStatus'] != null ? json['invoiceStatus'] as String : null,
    icon: json['icon'] != null ? json['icon'] as String : null,
    paymentTermDesc: json['paymentTermDesc'] != null
        ? json['paymentTermDesc'] as String
        : null,
    businessRef:
        json['businessRef'] != null ? json['businessRef'] as String : null,
    settlementStatus: json['settlementStatus'] != null
        ? json['settlementStatus'] as String
        : null,
    date: json['date'] != null ? json['date'] as String : null,
    regNumber: json['regNumber'] != null ? json['regNumber'] as String : null,
    maturityDate:
        json['maturityDate'] != null ? json['maturityDate'] as String : null,
    partnerRef:
        json['partnerRef'] != null ? json['partnerRef'] as String : null,
    overdueStatus:
        json['overdueStatus'] != null ? json['overdueStatus'] as String : null,
    isRecalled: json['isRecalled'] != null ? json['isRecalled'] as bool : null,
    email: json['email'] != null ? json['email'] as String : null,
    password: json['password'] != null ? json['password'] as String : null,
    accountName:
        json['accountName'] != null ? json['accountName'] as String : null,
    profileName:
        json['profileName'] != null ? json['profileName'] as String : null,
    accessToken:
        json['accessToken'] != null ? json['accessToken'] as String : null,
    parentRefCode:
        json['parentRefCode'] != null ? json['parentRefCode'] as String : null,
    payOffAmount: json['payOffAmount'] != null
        ? double.parse(json['payOffAmount'].toString())
        : null,
    overdueAmount: json['overdueAmount'] != null
        ? double.parse(json['overdueAmount'].toString())
        : null,
    invCount: json['invCount'] != null
        ? double.parse(json['invCount'].toString())
        : null,
    subLimit: json['subLimit'] != null
        ? double.parse(json['subLimit'].toString())
        : null,
    lbfProgramLimit: json['lbfProgramLimit'] != null
        ? double.parse(json['lbfProgramLimit'].toString())
        : null,
    trxAmount: json['trxAmount'] != null
        ? double.parse(json['trxAmount'].toString())
        : null,
    buyerTerm: json['buyerTerm'] != null
        ? double.parse(json['buyerTerm'].toString())
        : null,
    smeAvailableAmount: json['smeAvailableAmount'] != null
        ? double.parse(json['smeAvailableAmount'].toString())
        : null,
    smeSubLimit: json['smeSubLimit'] != null
        ? double.parse(json['smeSubLimit'].toString())
        : null,
    suppPenaltyPercent: json['suppPenaltyPercent'] != null
        ? double.parse(json['suppPenaltyPercent'].toString())
        : null,
    buyerPenaltyPercent: json['buyerPenaltyPercent'] != null
        ? double.parse(json['buyerPenaltyPercent'].toString())
        : null,
    suppDisbursementFee: json['suppDisbursementFee'] != null
        ? double.parse(json['suppDisbursementFee'].toString())
        : null,
    buyerDisbursementFee: json['buyerDisbursementFee'] != null
        ? double.parse(json['buyerDisbursementFee'].toString())
        : null,
    suppAppFee: json['suppAppFee'] != null
        ? double.parse(json['suppAppFee'].toString())
        : null,
    buyerAppFee: json['buyerAppFee'] != null
        ? double.parse(json['buyerAppFee'].toString())
        : null,
    minInvAmount: json['minInvAmount'] != null
        ? double.parse(json['minInvAmount'].toString())
        : null,
    minOfInv: json['minOfInv'] != null
        ? double.parse(json['minOfInv'].toString())
        : null,
    maxOfInv: json['maxOfInv'] != null
        ? double.parse(json['maxOfInv'].toString())
        : null,
    confirmedAmount: json['confirmedAmount'] != null
        ? double.parse(json['confirmedAmount'].toString())
        : null,
    refCode: json['refCode'] != null ? json['refCode'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    invId: json['invId'] != null ? json['invId'] as String : null,
    invRefCode:
        json['invRefCode'] != null ? json['invRefCode'] as String : null,
    requestedBusinessId: json['requestedBusinessId'] != null
        ? json['requestedBusinessId'] as String
        : null,
    requestedBusinessSubLimit: json['requestedBusinessSubLimit'] != null
        ? double.parse(json['requestedBusinessSubLimit'].toString())
        : null,
    programLimit: json['programLimit'] != null
        ? double.parse(json['programLimit'].toString())
        : null,
    availableAmount: json['availableAmount'] != null
        ? double.parse(json['availableAmount'].toString())
        : null,
    requestedUserId: json['requestedUserId'] != null
        ? json['requestedUserId'] as String
        : null,
    responsePeriod: json['responsePeriod'] != null
        ? double.parse(json['responsePeriod'].toString())
        : null,
    responseDate: json['responseDate'] != null
        ? DateTime.parse(json['responseDate'].toString())
        : null,
    requestStatus:
        json['requestStatus'] != null ? json['requestStatus'] as String : null,
    programId: json['programId'] != null ? json['programId'] as String : null,
    productId: json['productId'] != null ? json['productId'] as String : null,
    productType:
        json['productType'] != null ? json['productType'] as String : null,
    requestedAmount: json['requestedAmount'] != null
        ? double.parse(json['requestedAmount'].toString())
        : null,
    currency: json['currency'] != null ? json['currency'] as String : null,
    finAmountAcceptable: json['finAmountAcceptable'] != null
        ? json['finAmountAcceptable'] as bool
        : null,
    finMinAmount: json['finMinAmount'] != null
        ? double.parse(json['finMinAmount'].toString())
        : null,
    finMaxAmount: json['finMaxAmount'] != null
        ? double.parse(json['finMaxAmount'].toString())
        : null,
    amountToPay: json['amountToPay'] != null
        ? double.parse(json['amountToPay'].toString())
        : null,
    balanceAcceptable: json['balanceAcceptable'] != null
        ? json['balanceAcceptable'] as bool
        : null,
    minInvBalance: json['minInvBalance'] != null
        ? double.parse(json['minInvBalance'].toString())
        : null,
    tenorAcceptable: json['tenorAcceptable'] != null
        ? json['tenorAcceptable'] as bool
        : null,
    minTenor: json['minTenor'] != null
        ? double.parse(json['minTenor'].toString())
        : null,
    paidAmount: json['paidAmount'] != null
        ? double.parse(json['paidAmount'].toString())
        : null,
    maxTenor: json['maxTenor'] != null
        ? double.parse(json['maxTenor'].toString())
        : null,
    calculatedFeePercent: json['calculatedFeePercent'] != null
        ? double.parse(json['calculatedFeePercent'].toString())
        : null,
    calculatedFeeAmount: json['calculatedFeeAmount'] != null
        ? double.parse(json['calculatedFeeAmount'].toString())
        : null,
    scfFee:
        json['scfFee'] != null ? double.parse(json['scfFee'].toString()) : null,
    scfFeeAmount: json['scfFeeAmount'] != null
        ? double.parse(json['scfFeeAmount'].toString())
        : null,
    trxFee:
        json['trxFee'] != null ? double.parse(json['trxFee'].toString()) : null,
    appFee:
        json['appFee'] != null ? double.parse(json['appFee'].toString()) : null,
    disbursementFee: json['disbursementFee'] != null
        ? double.parse(json['disbursementFee'].toString())
        : null,
    totalScfFeePercent: json['totalScfFeePercent'] != null
        ? double.parse(json['totalScfFeePercent'].toString())
        : null,
    totalScfFeeAmount: json['totalScfFeeAmount'] != null
        ? double.parse(json['totalScfFeeAmount'].toString())
        : null,
    feeRule: json['feeRule'] != null ? json['feeRule'] as String : null,
    feeAcceptable:
        json['feeAcceptable'] != null ? json['feeAcceptable'] as bool : null,
    minFeeAmount: json['minFeeAmount'] != null
        ? double.parse(json['minFeeAmount'].toString())
        : null,
    maxFeeAmount: json['maxFeeAmount'] != null
        ? double.parse(json['maxFeeAmount'].toString())
        : null,
    repaymentDate: json['repaymentDate'] != null
        ? DateTime.parse(json['repaymentDate'].toString())
        : null,
    recourseTerm:
        json['recourseTerm'] != null ? json['recourseTerm'] as bool : null,
    recourseDate: json['recourseDate'] != null
        ? DateTime.parse(json['recourseDate'].toString())
        : null,
    restrictDate: json['restrictDate'] != null
        ? DateTime.parse(json['restrictDate'].toString())
        : null,
    penaltyPercent: json['penaltyPercent'] != null
        ? double.parse(json['penaltyPercent'].toString())
        : null,
    penaltyType:
        json['penaltyType'] != null ? json['penaltyType'] as String : null,
    repaymentRule:
        json['repaymentRule'] != null ? json['repaymentRule'] as String : null,
    invConfirmedDays: json['invConfirmedDays'] != null
        ? double.parse(json['invConfirmedDays'].toString())
        : null,
    daysAcceptable:
        json['daysAcceptable'] != null ? json['daysAcceptable'] as bool : null,
    minDays: json['minDays'] != null
        ? double.parse(json['minDays'].toString())
        : null,
    maxDays: json['maxDays'] != null
        ? double.parse(json['maxDays'].toString())
        : null,
    overdueStatusAcceptable: json['overdueStatusAcceptable'] != null
        ? json['overdueStatusAcceptable'] as bool
        : null,
    invOverdueStatus: json['invOverdueStatus'] != null
        ? json['invOverdueStatus'] as String
        : null,
    requestedBusinessAccId: json['requestedBusinessAccId'] != null
        ? json['requestedBusinessAccId'] as String
        : null,
    receiverBusinessAccId: json['receiverBusinessAccId'] != null
        ? json['receiverBusinessAccId'] as String
        : null,
    isBankApproved:
        json['isBankApproved'] != null ? json['isBankApproved'] as bool : null,
    bankFeeAmount: json['bankFeeAmount'] != null
        ? double.parse(json['bankFeeAmount'].toString())
        : null,
    suppAcceptable:
        json['suppAcceptable'] != null ? json['suppAcceptable'] as bool : null,
    buyerAcceptable: json['buyerAcceptable'] != null
        ? json['buyerAcceptable'] as bool
        : null,
    invSenderUserId: json['invSenderUserId'] != null
        ? json['invSenderUserId'] as String
        : null,
    invConfirmedAmount: json['invConfirmedAmount'] != null
        ? double.parse(json['invConfirmedAmount'].toString())
        : null,
    invPaidAmount: json['invPaidAmount'] != null
        ? double.parse(json['invPaidAmount'].toString())
        : null,
    invAmountToPay: json['invAmountToPay'] != null
        ? double.parse(json['invAmountToPay'].toString())
        : null,
    invReceiverBusinessId: json['invReceiverBusinessId'] != null
        ? json['invReceiverBusinessId'] as String
        : null,
    invReceiverBusinessRegNumber: json['invReceiverBusinessRegNumber'] != null
        ? json['invReceiverBusinessRegNumber'] as String
        : null,
    invPaymentDate: json['invPaymentDate'] != null
        ? DateTime.parse(json['invPaymentDate'].toString())
        : null,
    invConfirmedUserId: json['invConfirmedUserId'] != null
        ? json['invConfirmedUserId'] as String
        : null,
    fundingInstructionStatus: json['fundingInstructionStatus'] != null
        ? json['fundingInstructionStatus'] as String
        : null,
    invStatus: json['invStatus'] != null ? json['invStatus'] as String : null,
    invCreatedAt: json['invCreatedAt'] != null
        ? DateTime.parse(json['invCreatedAt'].toString())
        : null,
    invConfirmedDate: json['invConfirmedDate'] != null
        ? DateTime.parse(json['invConfirmedDate'].toString())
        : null,
    invPaymentStatus: json['invPaymentStatus'] != null
        ? json['invPaymentStatus'] as String
        : null,
    invPaymentTermId: json['invPaymentTermId'] != null
        ? json['invPaymentTermId'] as String
        : null,
    invPaymentTermConfigType: json['invPaymentTermConfigType'] != null
        ? json['invPaymentTermConfigType'] as String
        : null,
    repaymentRefCode: json['repaymentRefCode'] != null
        ? json['repaymentRefCode'] as String
        : null,
    invPaymentTermDesc: json['invPaymentTermDesc'] != null
        ? json['invPaymentTermDesc'] as String
        : null,
    respondedDate: json['respondedDate'] != null
        ? DateTime.parse(json['respondedDate'].toString())
        : null,
    respondedUserId: json['respondedUserId'] != null
        ? json['respondedUserId'] as String
        : null,
    isDisbursed:
        json['isDisbursed'] != null ? json['isDisbursed'] as bool : null,
    toDisburseDate: json['toDisburseDate'] != null
        ? DateTime.parse(json['toDisburseDate'].toString())
        : null,
    disbursedDate: json['disbursedDate'] != null
        ? DateTime.parse(json['disbursedDate'].toString())
        : null,
    repaymentAmount: json['repaymentAmount'] != null
        ? double.parse(json['repaymentAmount'].toString())
        : null,
    repaymentInvId: json['repaymentInvId'] != null
        ? json['repaymentInvId'] as String
        : null,
    isApproved: json['isApproved'] != null ? json['isApproved'] as bool : null,
    approvedAmount: json['approvedAmount'] != null
        ? double.parse(json['approvedAmount'].toString())
        : null,
    isResponded:
        json['isResponded'] != null ? json['isResponded'] as bool : null,
    respondDesc:
        json['respondDesc'] != null ? json['respondDesc'] as String : null,
    interestStartDate: json['interestStartDate'] != null
        ? DateTime.parse(json['interestStartDate'].toString())
        : null,
    minAmountAcceptable: json['minAmountAcceptable'] != null
        ? json['minAmountAcceptable'] as bool
        : null,
    maxAmountAcceptable: json['maxAmountAcceptable'] != null
        ? json['maxAmountAcceptable'] as bool
        : null,
    remainingDays: json['remainingDays'] != null
        ? double.parse(json['remainingDays'].toString())
        : null,
    suppFee: json['suppFee'] != null
        ? double.parse(json['suppFee'].toString())
        : null,
    buyerFee: json['buyerFee'] != null
        ? double.parse(json['buyerFee'].toString())
        : null,
    suppCalculateDay: json['suppCalculateDay'] != null
        ? double.parse(json['suppCalculateDay'].toString())
        : null,
    buyerCalculateDay: json['buyerCalculateDay'] != null
        ? double.parse(json['buyerCalculateDay'].toString())
        : null,
    suppMinFee: json['suppMinFee'] != null
        ? double.parse(json['suppMinFee'].toString())
        : null,
    buyerMinFee: json['buyerMinFee'] != null
        ? double.parse(json['buyerMinFee'].toString())
        : null,
    suppMaxFee: json['suppMaxFee'] != null
        ? double.parse(json['suppMaxFee'].toString())
        : null,
    buyerMaxFee: json['buyerMaxFee'] != null
        ? double.parse(json['buyerMaxFee'].toString())
        : null,
    program: json['program'] != null
        ? Finance.fromJson(json['program'] as Map<String, dynamic>)
        : null,
    account: json['account'] != null
        ? BankAccounts.fromJson(json['account'] as Map<String, dynamic>)
        : null,
    scfProgram: json['scfProgram'] != null
        ? Finance.fromJson(json['scfProgram'] as Map<String, dynamic>)
        : null,
    scfProduct: json['scfProduct'] != null
        ? Finance.fromJson(json['scfProduct'] as Map<String, dynamic>)
        : null,
    buyerFinUser: json['buyerFinUser'] != null
        ? Finance.fromJson(json['buyerFinUser'] as Map<String, dynamic>)
        : null,
    supplierFinUser: json['supplierFinUser'] != null
        ? Finance.fromJson(json['supplierFinUser'] as Map<String, dynamic>)
        : null,
    supplierAccount: json['supplierAccount'] != null
        ? Finance.fromJson(json['supplierAccount'] as Map<String, dynamic>)
        : null,
    buyerAccount: json['buyerAccount'] != null
        ? Finance.fromJson(json['buyerAccount'] as Map<String, dynamic>)
        : null,
    financeStaff: json['financeStaff'] != null
        ? Finance.fromJson(json['financeStaff'] as Map<String, dynamic>)
        : null,
    business: json['business'] != null
        ? Finance.fromJson(json['business'] as Map<String, dynamic>)
        : null,
    buyer: json['buyer'] != null
        ? Finance.fromJson(json['buyer'] as Map<String, dynamic>)
        : null,
    supplier: json['supplier'] != null
        ? Finance.fromJson(json['supplier'] as Map<String, dynamic>)
        : null,
    lbfRequest: json['lbfRequest'] != null
        ? Finance.fromJson(json['lbfRequest'] as Map<String, dynamic>)
        : null,
    creditAcc: json['creditAcc'] != null
        ? Finance.fromJson(json['creditAcc'] as Map<String, dynamic>)
        : null,
    invReceiverBusinessAcc: json['invReceiverBusinessAcc'] != null
        ? Finance.fromJson(
            json['invReceiverBusinessAcc'] as Map<String, dynamic>)
        : null,
    invoice: json['invoice'] != null
        ? Finance.fromJson(json['invoice'] as Map<String, dynamic>)
        : null,
    actionUser: json['actionUser'] != null
        ? Finance.fromJson(json['actionUser'] as Map<String, dynamic>)
        : null,
    finUser: json['finUser'] != null
        ? Finance.fromJson(json['finUser'] as Map<String, dynamic>)
        : null,
    requestedBusinessAcc: json['requestedBusinessAcc'] != null
        ? Finance.fromJson(json['requestedBusinessAcc'] as Map<String, dynamic>)
        : null,
    receiverBusinessAcc: json['receiverBusinessAcc'] != null
        ? Finance.fromJson(json['receiverBusinessAcc'] as Map<String, dynamic>)
        : null,
    respondedUser: json['respondedUser'] != null
        ? Finance.fromJson(json['respondedUser'] as Map<String, dynamic>)
        : null,
    senderUser: json['senderUser'] != null
        ? Finance.fromJson(json['senderUser'] as Map<String, dynamic>)
        : null,
    requestedBusiness: json['requestedBusiness'] != null
        ? Finance.fromJson(json['requestedBusiness'] as Map<String, dynamic>)
        : null,
    partner: json['partner'] != null
        ? Finance.fromJson(json['partner'] as Map<String, dynamic>)
        : null,
    product: json['product'] != null
        ? Finance.fromJson(json['product'] as Map<String, dynamic>)
        : null,
    invConfirmedUser: json['invConfirmedUser'] != null
        ? Finance.fromJson(json['invConfirmedUser'] as Map<String, dynamic>)
        : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    avatar: json['avatar'] != null ? json['avatar'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    businessName:
        json['businessName'] != null ? json['businessName'] as String : null,
    invReceiverBusiness: json['invReceiverBusiness'] != null
        ? Finance.fromJson(json['invReceiverBusiness'] as Map<String, dynamic>)
        : null,
    invSenderUser: json['invSenderUser'] != null
        ? Finance.fromJson(json['invSenderUser'] as Map<String, dynamic>)
        : null,
    lbfProgram: json['lbfProgram'] != null
        ? Finance.fromJson(json['lbfProgram'] as Map<String, dynamic>)
        : null,
    payerBusiness: json['payerBusiness'] != null
        ? Finance.fromJson(json['payerBusiness'] as Map<String, dynamic>)
        : null,
    requestedUser: json['requestedUser'] != null
        ? Finance.fromJson(json['requestedUser'] as Map<String, dynamic>)
        : null,
    repaymentInv: json['repaymentInv'] != null
        ? Finance.fromJson(json['repaymentInv'] as Map<String, dynamic>)
        : null,
    requestedFinUser: json['requestedFinUser'] != null
        ? Finance.fromJson(json['requestedFinUser'] as Map<String, dynamic>)
        : null,
    payerAcc: json['payerAcc'] != null
        ? Finance.fromJson(json['payerAcc'] as Map<String, dynamic>)
        : null,
    receiverBusiness: json['receiverBusiness'] != null
        ? Finance.fromJson(json['receiverBusiness'] as Map<String, dynamic>)
        : null,
    supplierBusiness: json['supplierBusiness'] != null
        ? Finance.fromJson(json['supplierBusiness'] as Map<String, dynamic>)
        : null,
    buyerBusiness: json['buyerBusiness'] != null
        ? Finance.fromJson(json['buyerBusiness'] as Map<String, dynamic>)
        : null,
    senderBusiness: json['senderBusiness'] != null
        ? Finance.fromJson(json['senderBusiness'] as Map<String, dynamic>)
        : null,
    confirmedUser: json['confirmedUser'] != null
        ? Finance.fromJson(json['confirmedUser'] as Map<String, dynamic>)
        : null,
    senderFinUser: json['senderFinUser'] != null
        ? Finance.fromJson(json['senderFinUser'] as Map<String, dynamic>)
        : null,
    receiverFinUser: json['receiverFinUser'] != null
        ? Finance.fromJson(json['receiverFinUser'] as Map<String, dynamic>)
        : null,
    paymentTerm: json['paymentTerm'] != null
        ? Finance.fromJson(json['paymentTerm'] as Map<String, dynamic>)
        : null,
    senderAcc: json['senderAcc'] != null
        ? Finance.fromJson(json['senderAcc'] as Map<String, dynamic>)
        : null,
    receiverAcc: json['receiverAcc'] != null
        ? Finance.fromJson(json['receiverAcc'] as Map<String, dynamic>)
        : null,
    lbfProduct: json['lbfProduct'] != null
        ? Finance.fromJson(json['lbfProduct'] as Map<String, dynamic>)
        : null,
    businessSubLimit: json['businessSubLimit'] != null
        ? double.parse(json['businessSubLimit'].toString())
        : null,
    businessAvailableAmount: json['businessAvailableAmount'] != null
        ? double.parse(json['businessAvailableAmount'].toString())
        : null,
    businessUtilizedAmount: json['businessUtilizedAmount'] != null
        ? double.parse(json['businessUtilizedAmount'].toString())
        : null,
    businessDisbursePendingAmount: json['businessDisbursePendingAmount'] != null
        ? double.parse(json['businessDisbursePendingAmount'].toString())
        : null,
    businessPendingAmount: json['businessPendingAmount'] != null
        ? double.parse(json['businessPendingAmount'].toString())
        : null,
    businessUtilizedCount: json['businessUtilizedCount'] != null
        ? double.parse(json['businessUtilizedCount'].toString())
        : null,
    businessDisbursePendingCount: json['businessDisbursePendingCount'] != null
        ? double.parse(json['businessDisbursePendingCount'].toString())
        : null,
    businessPendingCount: json['businessPendingCount'] != null
        ? double.parse(json['businessPendingCount'].toString())
        : null,
    method: json['method'] != null ? json['method'] as String : null,
    creditAccountId: json['creditAccountId'] != null
        ? json['creditAccountId'] as String
        : null,
    amount:
        json['amount'] != null ? double.parse(json['amount'].toString()) : null,
    addInfo: json['addInfo'] != null ? json['addInfo'] as String : null,
    files: json['files'] != null
        ? (json['files'] as List).map((e) => e as String).toList()
        : null,
    link: json['link'] != null ? json['link'] as String : null,
    qr_image: json['qr_image'] != null ? json['qr_image'] as String : null,
    logo: json['logo'] != null ? json['logo'] as String : null,
    firstAmount: json['firstAmount'] != null
        ? double.parse(json['firstAmount'].toString())
        : null,
    firstInvCount: json['firstInvCount'] != null
        ? double.parse(json['firstInvCount'].toString())
        : null,
    lastAmount: json['lastAmount'] != null
        ? double.parse(json['lastAmount'].toString())
        : null,
    lastInvCount: json['lastInvCount'] != null
        ? double.parse(json['lastInvCount'].toString())
        : null,
    confirmedInvCount: json['confirmedInvCount'] != null
        ? double.parse(json['confirmedInvCount'].toString())
        : null,
    paidInvCount: json['paidInvCount'] != null
        ? double.parse(json['paidInvCount'].toString())
        : null,
    payerAccName:
        json['payerAccName'] != null ? json['payerAccName'] as String : null,
    payerAccNum:
        json['payerAccNum'] != null ? json['payerAccNum'] as String : null,
    accountNum:
        json['accountNum'] != null ? json['accountNum'] as String : null,
    classificationCategory: json['classificationCategory'] != null
        ? Finance.fromJson(
            json['classificationCategory'] as Map<String, dynamic>)
        : null,
    classificationPriority: json['classificationPriority'] != null
        ? Finance.fromJson(
            json['classificationPriority'] as Map<String, dynamic>)
        : null,
    classificationSetUser: json['classificationSetUser'] != null
        ? Finance.fromJson(
            json['classificationSetUser'] as Map<String, dynamic>)
        : null,
    areaRegion: json['areaRegion'] != null
        ? Finance.fromJson(json['areaRegion'] as Map<String, dynamic>)
        : null,
    areaDirection: json['areaDirection'] != null
        ? Finance.fromJson(json['areaDirection'] as Map<String, dynamic>)
        : null,
    areaSetUser: json['areaSetUser'] != null
        ? Finance.fromJson(json['areaSetUser'] as Map<String, dynamic>)
        : null,
    areaSetDate: json['areaSetDate'] != null
        ? DateTime.parse(json['areaSetDate'].toString())
        : null,
    classificationSetDate: json['classificationSetDate'] != null
        ? DateTime.parse(json['classificationSetDate'].toString())
        : null,
    classificationDesc: json['classificationDesc'] != null
        ? json['classificationDesc'] as String
        : null,
    weekAvgDebtAmount: json['weekAvgDebtAmount'] != null
        ? double.parse(json['weekAvgDebtAmount'].toString())
        : null,
    halfMonthAvgDebtAmount: json['halfMonthAvgDebtAmount'] != null
        ? double.parse(json['halfMonthAvgDebtAmount'].toString())
        : null,
    monthAvgDebtAmount: json['monthAvgDebtAmount'] != null
        ? double.parse(json['monthAvgDebtAmount'].toString())
        : null,
    monthAvgPurchaseAmount: json['monthAvgPurchaseAmount'] != null
        ? double.parse(json['monthAvgPurchaseAmount'].toString())
        : null,
    monthAvgRefundAmount: json['monthAvgRefundAmount'] != null
        ? double.parse(json['monthAvgRefundAmount'].toString())
        : null,
    monthAvgBidAmount: json['monthAvgBidAmount'] != null
        ? double.parse(json['monthAvgBidAmount'].toString())
        : null,
    debtLimitAmount: json['debtLimitAmount'] != null
        ? double.parse(json['debtLimitAmount'].toString())
        : null,
    debtLimitStartDate: json['debtLimitStartDate'] != null
        ? json['debtLimitStartDate'] as String
        : null,
    debtLimitEndDate: json['debtLimitEndDate'] != null
        ? json['debtLimitEndDate'] as String
        : null,
    earlyDiscount:
        json['earlyDiscount'] != null ? json['earlyDiscount'] as bool : null,
    countPenalty:
        json['countPenalty'] != null ? json['countPenalty'] as bool : null,
    discountType:
        json['discountType'] != null ? json['discountType'] as String : null,
    discountPercent: json['discountPercent'] != null
        ? double.parse(json['discountPercent'].toString())
        : null,
  );
}

Map<String, dynamic> _$FinanceToJson(Finance instance) {
  Map<String, dynamic> json = {};

  if (instance.debtLimitStartDate != null) {
    json['debtLimitStartDate'] = instance.debtLimitStartDate;
  }
  if (instance.loanStatus != null) {
    json['loanStatus'] = instance.loanStatus;
  }
  if (instance.periodInDays != null) {
    json['periodInDays'] = instance.periodInDays;
  }
  if (instance.periodInMonths != null) {
    json['periodInMonths'] = instance.periodInMonths;
  }
  if (instance.accountName != null) {
    json['accountName'] = instance.accountName;
  }
  if (instance.overdueAmount != null) {
    json['overdueAmount'] = instance.overdueAmount;
  }
  if (instance.payOffAmount != null) {
    json['payOffAmount'] = instance.payOffAmount;
  }
  if (instance.accountCategory != null) {
    json['accountCategory'] = instance.accountCategory;
  }
  if (instance.openDate != null) json['openDate'] = instance.openDate;
  if (instance.maturityDate != null) {
    json['maturityDate'] = instance.maturityDate;
  }
  if (instance.businessIds != null) {
    json['businessIds'] = instance.businessIds;
  }
  if (instance.debtLimitEndDate != null) {
    json['debtLimitEndDate'] = instance.debtLimitEndDate;
  }
  if (instance.earlyDiscount != null) {
    json['earlyDiscount'] = instance.earlyDiscount;
  }
  if (instance.countPenalty != null) {
    json['countPenalty'] = instance.countPenalty;
  }
  if (instance.discountType != null) {
    json['discountType'] = instance.discountType;
  }
  if (instance.discountPercent != null) {
    json['discountPercent'] = instance.discountPercent;
  }
  if (instance.classificationCategory != null) {
    json['classificationCategory'] = instance.classificationCategory;
  }
  if (instance.paymentTerm != null) {
    json['paymentTerm'] = instance.paymentTerm;
  }
  if (instance.classificationPriority != null) {
    json['classificationPriority'] = instance.classificationPriority;
  }
  if (instance.classificationSetUser != null) {
    json['classificationSetUser'] = instance.classificationSetUser;
  }
  if (instance.areaRegion != null) json['areaRegion'] = instance.areaRegion;
  if (instance.numberSurvey != null) {
    json['numberSurvey'] = instance.numberSurvey;
  }
  if (instance.nextInstallmentDueDate != null) {
    json['nextInstallmentDueDate'] = instance.nextInstallmentDueDate;
  }
  if (instance.byInterval != null) json['byInterval'] = instance.byInterval;
  if (instance.byProgram != null) json['byProgram'] = instance.byProgram;
  if (instance.areaDirection != null) {
    json['areaDirection'] = instance.areaDirection;
  }
  if (instance.areaSetUser != null) json['areaSetUser'] = instance.areaSetUser;
  if (instance.areaSetDate != null) json['areaSetDate'] = instance.areaSetDate;
  if (instance.classificationSetDate != null) {
    json['classificationSetDate'] = instance.classificationSetDate;
  }
  if (instance.classificationDesc != null) {
    json['classificationDesc'] = instance.classificationDesc;
  }
  if (instance.weekAvgDebtAmount != null) {
    json['weekAvgDebtAmount'] = instance.weekAvgDebtAmount;
  }
  if (instance.halfMonthAvgDebtAmount != null) {
    json['halfMonthAvgDebtAmount'] = instance.halfMonthAvgDebtAmount;
  }
  if (instance.monthAvgDebtAmount != null) {
    json['monthAvgDebtAmount'] = instance.monthAvgDebtAmount;
  }
  if (instance.monthAvgPurchaseAmount != null) {
    json['monthAvgPurchaseAmount'] = instance.monthAvgPurchaseAmount;
  }
  if (instance.monthAvgRefundAmount != null) {
    json['monthAvgRefundAmount'] = instance.monthAvgRefundAmount;
  }
  if (instance.monthAvgBidAmount != null) {
    json['monthAvgBidAmount'] = instance.monthAvgBidAmount;
  }
  if (instance.debtLimitAmount != null) {
    json['debtLimitAmount'] = instance.debtLimitAmount;
  }

  if (instance.payerAccName != null) {
    json['payerAccName'] = instance.payerAccName;
  }
  if (instance.participantStatus != null) {
    json['participantStatus'] = instance.participantStatus;
  }
  if (instance.payerAccNum != null) json['payerAccNum'] = instance.payerAccNum;
  if (instance.accountNum != null) json['accountNum'] = instance.accountNum;
  if (instance.firstAmount != null) json['firstAmount'] = instance.firstAmount;
  if (instance.payments != null) json['payments'] = instance.payments;
  if (instance.supplierAccount != null) {
    json['supplierAccount'] = instance.supplierAccount;
  }
  if (instance.lbfAccount != null) {
    json['lbfAccount'] = instance.lbfAccount;
  }
  if (instance.accountId != null) {
    json['accountId'] = instance.accountId;
  }
  if (instance.scfProgram != null) json['scfProgram'] = instance.scfProgram;
  if (instance.account != null) json['account'] = instance.account;
  if (instance.scfProduct != null) json['scfProduct'] = instance.scfProduct;
  if (instance.buyerAccount != null) {
    json['buyerAccount'] = instance.buyerAccount;
  }
  if (instance.buyerFinUser != null) {
    json['buyerFinUser'] = instance.buyerFinUser;
  }
  if (instance.supplierFinUser != null) {
    json['supplierFinUser'] = instance.supplierFinUser;
  }
  if (instance.firstInvCount != null) {
    json['firstInvCount'] = instance.firstInvCount;
  }
  if (instance.lastAmount != null) json['lastAmount'] = instance.lastAmount;
  if (instance.lastInvCount != null) {
    json['lastInvCount'] = instance.lastInvCount;
  }
  if (instance.confirmedInvCount != null) {
    json['confirmedInvCount'] = instance.confirmedInvCount;
  }
  if (instance.paidInvCount != null) {
    json['paidInvCount'] = instance.paidInvCount;
  }
  if (instance.lbfRequestId != null) {
    json['lbfRequestId'] = instance.lbfRequestId;
  }
  if (instance.accountNumber != null) {
    json['accountNumber'] = instance.accountNumber;
  }
  if (instance.link != null) json['link'] = instance.link;
  if (instance.subLimit != null) json['subLimit'] = instance.subLimit;
  if (instance.buyer != null) json['buyer'] = instance.buyer;
  if (instance.supplier != null) json['supplier'] = instance.supplier;
  if (instance.invoiceRef != null) json['invoiceRef'] = instance.invoiceRef;
  if (instance.qr_image != null) json['qr_image'] = instance.qr_image;
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.method != null) json['method'] = instance.method;
  if (instance.compromises != null) json['compromises'] = instance.compromises;
  if (instance.urls != null) json['urls'] = instance.urls;
  if (instance.lbfProgram != null) json['lbfProgram'] = instance.lbfProgram;
  if (instance.lbfRequestStatus != null) {
    json['lbfRequestStatus'] = instance.lbfRequestStatus;
  }
  if (instance.business != null) json['business'] = instance.business;

  if (instance.settlementStatus != null) {
    json['settlementStatus'] = instance.settlementStatus;
  }
  if (instance.lbfProgramId != null) {
    json['lbfProgramId'] = instance.lbfProgramId;
  }
  if (instance.date != null) json['date'] = instance.date;
  if (instance.lbfProgramStatus != null) {
    json['lbfProgramStatus'] = instance.lbfProgramStatus;
  }
  if (instance.lbfProgramLimit != null) {
    json['lbfProgramLimit'] = instance.lbfProgramLimit;
  }
  if (instance.creditAccountId != null) {
    json['creditAccountId'] = instance.creditAccountId;
  }
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.addInfo != null) json['addInfo'] = instance.addInfo;
  if (instance.files != null) json['files'] = instance.files;

  if (instance.businessSubLimit != null) {
    json['businessSubLimit'] = instance.businessSubLimit;
  }
  if (instance.repaymentRefCode != null) {
    json['repaymentRefCode'] = instance.repaymentRefCode;
  }
  if (instance.disbursementRef != null) {
    json['disbursementRef'] = instance.disbursementRef;
  }
  if (instance.invDueDate != null) {
    json['invDueDate'] = instance.invDueDate;
  }
  if (instance.requestFiles != null) {
    json['requestFiles'] = instance.requestFiles;
  }
  if (instance.lbfRequest != null) {
    json['lbfRequest'] = instance.lbfRequest;
  }
  if (instance.contractFile != null) {
    json['contractFile'] = instance.contractFile;
  }
  if (instance.businessAvailableAmount != null) {
    json['businessAvailableAmount'] = instance.businessAvailableAmount;
  }
  if (instance.businessUtilizedAmount != null) {
    json['businessUtilizedAmount'] = instance.businessUtilizedAmount;
  }
  if (instance.businessDisbursePendingAmount != null) {
    json['businessDisbursePendingAmount'] =
        instance.businessDisbursePendingAmount;
  }
  if (instance.businessPendingAmount != null) {
    json['businessPendingAmount'] = instance.businessPendingAmount;
  }
  if (instance.businessUtilizedCount != null) {
    json['businessUtilizedCount'] = instance.businessUtilizedCount;
  }
  if (instance.businessDisbursePendingCount != null) {
    json['businessDisbursePendingCount'] =
        instance.businessDisbursePendingCount;
  }
  if (instance.businessPendingCount != null) {
    json['businessPendingCount'] = instance.businessPendingCount;
  }
  if (instance.financeStaff != null) {
    json['financeStaff'] = instance.financeStaff;
  }
  if (instance.recourseDays != null) {
    json['recourseDays'] = instance.recourseDays;
  }
  if (instance.suppPenaltyPercent != null) {
    json['suppPenaltyPercent'] = instance.suppPenaltyPercent;
  }
  if (instance.buyerPenaltyPercent != null) {
    json['buyerPenaltyPercent'] = instance.buyerPenaltyPercent;
  }
  if (instance.suppMinFee != null) json['suppMinFee'] = instance.suppMinFee;
  if (instance.actionUser != null) json['actionUser'] = instance.actionUser;
  if (instance.smeSubLimit != null) json['smeSubLimit'] = instance.smeSubLimit;
  if (instance.clientText != null) json['clientText'] = instance.clientText;
  if (instance.smeAvailableAmount != null) {
    json['smeAvailableAmount'] = instance.smeAvailableAmount;
  }
  if (instance.buyerMinFee != null) json['buyerMinFee'] = instance.buyerMinFee;
  if (instance.invoice != null) json['invoice'] = instance.invoice;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.trxAmount != null) json['trxAmount'] = instance.trxAmount;
  if (instance.isRecalled != null) json['isRecalled'] = instance.isRecalled;
  if (instance.buyerTerm != null) json['buyerTerm'] = instance.buyerTerm;
  if (instance.suppMaxFee != null) json['suppMaxFee'] = instance.suppMaxFee;
  if (instance.buyerMaxFee != null) json['buyerMaxFee'] = instance.buyerMaxFee;
  if (instance.paymentMethod != null) {
    json['paymentMethod'] = instance.paymentMethod;
  }
  if (instance.suppFee != null) json['suppFee'] = instance.suppFee;
  if (instance.buyerFeeRule != null) {
    json['buyerFeeRule'] = instance.buyerFeeRule;
  }
  if (instance.suppFeeRule != null) json['suppFeeRule'] = instance.suppFeeRule;
  if (instance.buyerDisbursementFee != null) {
    json['buyerDisbursementFee'] = instance.buyerDisbursementFee;
  }
  if (instance.suppDisbursementFee != null) {
    json['suppDisbursementFee'] = instance.suppDisbursementFee;
  }
  if (instance.buyerFee != null) json['buyerFee'] = instance.buyerFee;
  if (instance.suppCalculateDay != null) {
    json['suppCalculateDay'] = instance.suppCalculateDay;
  }
  if (instance.buyerCalculateDay != null) {
    json['buyerCalculateDay'] = instance.buyerCalculateDay;
  }
  if (instance.senderFinUser != null) {
    json['senderFinUser'] = instance.senderFinUser;
  }
  if (instance.minOfInv != null) json['minOfInv'] = instance.minOfInv;
  if (instance.minInvAmount != null) {
    json['minInvAmount'] = instance.minInvAmount;
  }
  if (instance.maxOfInv != null) json['maxOfInv'] = instance.maxOfInv;
  if (instance.paymentStatus != null) {
    json['paymentStatus'] = instance.paymentStatus;
  }
  if (instance.contractFiles != null) {
    json['contractFiles'] = instance.contractFiles;
  }
  if (instance.invoices != null) json['invoices'] = instance.invoices;
  if (instance.creditAcc != null) json['creditAcc'] = instance.creditAcc;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.phoneNumber != null) json['phoneNumber'] = instance.phoneNumber;
  if (instance.bankName != null) json['bankName'] = instance.bankName;
  if (instance.receiverFinUser != null) {
    json['receiverFinUser'] = instance.receiverFinUser;
  }
  if (instance.senderAcc != null) json['senderAcc'] = instance.senderAcc;
  if (instance.lbfProduct != null) json['lbfProduct'] = instance.lbfProduct;
  if (instance.receiverAcc != null) json['receiverAcc'] = instance.receiverAcc;
  if (instance.icon != null) json['icon'] = instance.icon;
  if (instance.shortName != null) json['shortName'] = instance.shortName;
  if (instance.confirmedAmount != null) {
    json['confirmedAmount'] = instance.confirmedAmount;
  }
  if (instance.paymentTermDesc != null) {
    json['paymentTermDesc'] = instance.paymentTermDesc;
  }
  if (instance.confirmedUser != null) {
    json['confirmedUser'] = instance.confirmedUser;
  }
  if (instance.invoiceStatus != null) {
    json['invoiceStatus'] = instance.invoiceStatus;
  }
  if (instance.confirmedDate != null) {
    json['confirmedDate'] = instance.confirmedDate;
  }
  if (instance.paymentDate != null) json['paymentDate'] = instance.paymentDate;
  if (instance.sentDate != null) json['sentDate'] = instance.sentDate;
  if (instance.receiverBusiness != null) {
    json['receiverBusiness'] = instance.receiverBusiness;
  }
  if (instance.senderBusiness != null) {
    json['senderBusiness'] = instance.senderBusiness;
  }
  if (instance.requestedBusinessAcc != null) {
    json['requestedBusinessAcc'] = instance.requestedBusinessAcc;
  }
  if (instance.programStatus != null) {
    json['programStatus'] = instance.programStatus;
  }
  if (instance.username != null) json['username'] = instance.username;
  if (instance.receiverBusinessAcc != null) {
    json['receiverBusinessAcc'] = instance.receiverBusinessAcc;
  }
  if (instance.availableAmount != null) {
    json['availableAmount'] = instance.availableAmount;
  }
  if (instance.programLimit != null) {
    json['programLimit'] = instance.programLimit;
  }
  if (instance.senderUser != null) json['senderUser'] = instance.senderUser;
  if (instance.number != null) json['number'] = instance.number;
  if (instance.regNumber != null) json['regNumber'] = instance.regNumber;
  if (instance.repaymentStatus != null) {
    json['repaymentStatus'] = instance.repaymentStatus;
  }
  if (instance.payerAcc != null) json['payerAcc'] = instance.payerAcc;
  if (instance.overdueStatus != null) {
    json['overdueStatus'] = instance.overdueStatus;
  }
  if (instance.requestedFinUser != null) {
    json['requestedFinUser'] = instance.requestedFinUser;
  }
  if (instance.parentRefCode != null) {
    json['parentRefCode'] = instance.parentRefCode;
  }
  if (instance.invSenderUser != null) {
    json['invSenderUser'] = instance.invSenderUser;
  }
  if (instance.supplierBusiness != null) {
    json['supplierBusiness'] = instance.supplierBusiness;
  }
  if (instance.buyerBusiness != null) {
    json['buyerBusiness'] = instance.buyerBusiness;
  }
  if (instance.invCount != null) json['invCount'] = instance.invCount;
  if (instance.payerBusiness != null) {
    json['payerBusiness'] = instance.payerBusiness;
  }
  if (instance.refCode != null) json['refCode'] = instance.refCode;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.invId != null) json['invId'] = instance.invId;
  if (instance.invRefCode != null) json['invRefCode'] = instance.invRefCode;
  if (instance.requestedBusinessId != null) {
    json['requestedBusinessId'] = instance.requestedBusinessId;
  }
  if (instance.requestedBusinessSubLimit != null) {
    json['requestedBusinessSubLimit'] = instance.requestedBusinessSubLimit;
  }
  if (instance.requestedUserId != null) {
    json['requestedUserId'] = instance.requestedUserId;
  }
  if (instance.responsePeriod != null) {
    json['responsePeriod'] = instance.responsePeriod;
  }
  if (instance.responseDate != null) {
    json['responseDate'] = instance.responseDate;
  }
  if (instance.requestStatus != null) {
    json['requestStatus'] = instance.requestStatus;
  }
  if (instance.paidAmount != null) json['paidAmount'] = instance.paidAmount;
  if (instance.programId != null) json['programId'] = instance.programId;
  if (instance.productId != null) json['productId'] = instance.productId;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.productType != null) json['productType'] = instance.productType;
  if (instance.requestedAmount != null) {
    json['requestedAmount'] = instance.requestedAmount;
  }
  if (instance.currency != null) json['currency'] = instance.currency;
  if (instance.finAmountAcceptable != null) {
    json['finAmountAcceptable'] = instance.finAmountAcceptable;
  }
  if (instance.finMinAmount != null) {
    json['finMinAmount'] = instance.finMinAmount;
  }
  if (instance.finMaxAmount != null) {
    json['finMaxAmount'] = instance.finMaxAmount;
  }
  if (instance.balanceAcceptable != null) {
    json['balanceAcceptable'] = instance.balanceAcceptable;
  }
  if (instance.minInvBalance != null) {
    json['minInvBalance'] = instance.minInvBalance;
  }
  if (instance.tenorAcceptable != null) {
    json['tenorAcceptable'] = instance.tenorAcceptable;
  }
  if (instance.minTenor != null) json['minTenor'] = instance.minTenor;
  if (instance.maxTenor != null) json['maxTenor'] = instance.maxTenor;
  if (instance.calculatedFeePercent != null) {
    json['calculatedFeePercent'] = instance.calculatedFeePercent;
  }
  if (instance.calculatedFeeAmount != null) {
    json['calculatedFeeAmount'] = instance.calculatedFeeAmount;
  }
  if (instance.scfFee != null) json['scfFee'] = instance.scfFee;
  if (instance.scfFeeAmount != null) {
    json['scfFeeAmount'] = instance.scfFeeAmount;
  }
  if (instance.trxFee != null) json['trxFee'] = instance.trxFee;
  if (instance.appFee != null) json['appFee'] = instance.appFee;
  if (instance.disbursementFee != null) {
    json['disbursementFee'] = instance.disbursementFee;
  }
  if (instance.totalScfFeePercent != null) {
    json['totalScfFeePercent'] = instance.totalScfFeePercent;
  }
  if (instance.totalScfFeeAmount != null) {
    json['totalScfFeeAmount'] = instance.totalScfFeeAmount;
  }
  if (instance.feeRule != null) json['feeRule'] = instance.feeRule;
  if (instance.feeAcceptable != null) {
    json['feeAcceptable'] = instance.feeAcceptable;
  }
  if (instance.minFeeAmount != null) {
    json['minFeeAmount'] = instance.minFeeAmount;
  }
  if (instance.maxFeeAmount != null) {
    json['maxFeeAmount'] = instance.maxFeeAmount;
  }
  if (instance.repaymentDate != null) {
    json['repaymentDate'] = instance.repaymentDate;
  }
  if (instance.recourseTerm != null) {
    json['recourseTerm'] = instance.recourseTerm;
  }
  if (instance.recourseDate != null) {
    json['recourseDate'] = instance.recourseDate;
  }
  if (instance.restrictDate != null) {
    json['restrictDate'] = instance.restrictDate;
  }
  if (instance.penaltyPercent != null) {
    json['penaltyPercent'] = instance.penaltyPercent;
  }
  if (instance.penaltyType != null) json['penaltyType'] = instance.penaltyType;
  if (instance.repaymentRule != null) {
    json['repaymentRule'] = instance.repaymentRule;
  }
  if (instance.invConfirmedDays != null) {
    json['invConfirmedDays'] = instance.invConfirmedDays;
  }
  if (instance.daysAcceptable != null) {
    json['daysAcceptable'] = instance.daysAcceptable;
  }
  if (instance.finUser != null) json['finUser'] = instance.finUser;
  if (instance.amountToPay != null) json['amountToPay'] = instance.amountToPay;
  if (instance.minDays != null) json['minDays'] = instance.minDays;
  if (instance.maxDays != null) json['maxDays'] = instance.maxDays;
  if (instance.overdueStatusAcceptable != null) {
    json['overdueStatusAcceptable'] = instance.overdueStatusAcceptable;
  }
  if (instance.invOverdueStatus != null) {
    json['invOverdueStatus'] = instance.invOverdueStatus;
  }
  if (instance.requestedBusinessAccId != null) {
    json['requestedBusinessAccId'] = instance.requestedBusinessAccId;
  }
  if (instance.receiverBusinessAccId != null) {
    json['receiverBusinessAccId'] = instance.receiverBusinessAccId;
  }
  if (instance.isBankApproved != null) {
    json['isBankApproved'] = instance.isBankApproved;
  }
  if (instance.bankFeeAmount != null) {
    json['bankFeeAmount'] = instance.bankFeeAmount;
  }
  if (instance.suppAcceptable != null) {
    json['suppAcceptable'] = instance.suppAcceptable;
  }
  if (instance.buyerAcceptable != null) {
    json['buyerAcceptable'] = instance.buyerAcceptable;
  }
  if (instance.invSenderUserId != null) {
    json['invSenderUserId'] = instance.invSenderUserId;
  }
  if (instance.invConfirmedAmount != null) {
    json['invConfirmedAmount'] = instance.invConfirmedAmount;
  }
  if (instance.invPaidAmount != null) {
    json['invPaidAmount'] = instance.invPaidAmount;
  }
  if (instance.invAmountToPay != null) {
    json['invAmountToPay'] = instance.invAmountToPay;
  }
  if (instance.invReceiverBusinessId != null) {
    json['invReceiverBusinessId'] = instance.invReceiverBusinessId;
  }
  if (instance.invReceiverBusinessRegNumber != null) {
    json['invReceiverBusinessRegNumber'] =
        instance.invReceiverBusinessRegNumber;
  }
  if (instance.invPaymentDate != null) {
    json['invPaymentDate'] = instance.invPaymentDate;
  }
  if (instance.invConfirmedUserId != null) {
    json['invConfirmedUserId'] = instance.invConfirmedUserId;
  }
  if (instance.fundingInstructionStatus != null) {
    json['fundingInstructionStatus'] = instance.fundingInstructionStatus;
  }
  if (instance.invStatus != null) json['invStatus'] = instance.invStatus;
  if (instance.invCreatedAt != null) {
    json['invCreatedAt'] = instance.invCreatedAt;
  }
  if (instance.invConfirmedDate != null) {
    json['invConfirmedDate'] = instance.invConfirmedDate;
  }
  if (instance.invPaymentStatus != null) {
    json['invPaymentStatus'] = instance.invPaymentStatus;
  }
  if (instance.invPaymentTermId != null) {
    json['invPaymentTermId'] = instance.invPaymentTermId;
  }
  if (instance.invPaymentTermConfigType != null) {
    json['invPaymentTermConfigType'] = instance.invPaymentTermConfigType;
  }
  if (instance.invPaymentTermDesc != null) {
    json['invPaymentTermDesc'] = instance.invPaymentTermDesc;
  }
  if (instance.respondedDate != null) {
    json['respondedDate'] = instance.respondedDate;
  }
  if (instance.respondedUserId != null) {
    json['respondedUserId'] = instance.respondedUserId;
  }
  if (instance.isDisbursed != null) json['isDisbursed'] = instance.isDisbursed;
  if (instance.toDisburseDate != null) {
    json['toDisburseDate'] = instance.toDisburseDate;
  }
  if (instance.disbursedDate != null) {
    json['disbursedDate'] = instance.disbursedDate;
  }
  if (instance.repaymentAmount != null) {
    json['repaymentAmount'] = instance.repaymentAmount;
  }
  if (instance.repaymentInvId != null) {
    json['repaymentInvId'] = instance.repaymentInvId;
  }
  if (instance.isApproved != null) json['isApproved'] = instance.isApproved;
  if (instance.approvedAmount != null) {
    json['approvedAmount'] = instance.approvedAmount;
  }
  if (instance.invReceiverBusinessAcc != null) {
    json['invReceiverBusinessAcc'] = instance.invReceiverBusinessAcc;
  }
  if (instance.isResponded != null) json['isResponded'] = instance.isResponded;
  if (instance.respondDesc != null) json['respondDesc'] = instance.respondDesc;
  if (instance.interestStartDate != null) {
    json['interestStartDate'] = instance.interestStartDate;
  }
  if (instance.minAmountAcceptable != null) {
    json['minAmountAcceptable'] = instance.minAmountAcceptable;
  }
  if (instance.maxAmountAcceptable != null) {
    json['maxAmountAcceptable'] = instance.maxAmountAcceptable;
  }
  if (instance.remainingDays != null) {
    json['remainingDays'] = instance.remainingDays;
  }
  if (instance.program != null) json['program'] = instance.program;
  if (instance.respondedUser != null) {
    json['respondedUser'] = instance.respondedUser;
  }
  if (instance.requestedBusiness != null) {
    json['requestedBusiness'] = instance.requestedBusiness;
  }
  if (instance.partner != null) json['partner'] = instance.partner;
  if (instance.product != null) json['product'] = instance.product;
  if (instance.invConfirmedUser != null) {
    json['invConfirmedUser'] = instance.invConfirmedUser;
  }
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.avatar != null) json['avatar'] = instance.avatar;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.businessName != null) {
    json['businessName'] = instance.businessName;
  }
  if (instance.invReceiverBusiness != null) {
    json['invReceiverBusiness'] = instance.invReceiverBusiness;
  }
  if (instance.requestedUser != null) {
    json['requestedUser'] = instance.requestedUser;
  }
  if (instance.repaymentInv != null) {
    json['repaymentInv'] = instance.repaymentInv;
  }

  if (instance.profileName != null) json['profileName'] = instance.profileName;
  if (instance.businessRef != null) json['businessRef'] = instance.businessRef;
  if (instance.partnerRef != null) json['partnerRef'] = instance.partnerRef;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.password != null) json['password'] = instance.password;
  if (instance.accessToken != null) json['accessToken'] = instance.accessToken;
  if (instance.count != null) json['count'] = instance.count;
  if (instance.rows != null) json['rows'] = instance.rows;
  if (instance.id != null) json['id'] = instance.id;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.partnerId != null) json['partnerId'] = instance.partnerId;

  return json;
}
