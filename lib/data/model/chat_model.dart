class PartsModel {
  String? text;

  PartsModel({required this.text});

  factory PartsModel.fromJson(Map<String, dynamic> json) {
    return PartsModel(text: json['text']);
  }
}

class ContentModel {
  List<PartsModel>? parts;
  String? role;

  ContentModel({required this.parts, required this.role});

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    List<PartsModel> mParts = [];
    for (Map<String, dynamic> eachPart in json['parts']) {
      mParts.add(PartsModel.fromJson(eachPart));
    }
    return ContentModel(parts: mParts, role: json['role']);
  }
}

class CandidateModel {
  int? index;
  String? finishReason;
  ContentModel? content;

  CandidateModel({
    required this.index,
    required this.content,
    required this.finishReason,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return CandidateModel(
      content: json['content'],
      index: json['index'],
      finishReason: json['finishReason'],
    );
  }
}

class UsageMetaDataModel {
  int? candidatesTokenCount;
  int? promptTokenCount;
  int? thoughtsTokenCount;
  int? totalTokenCount;
  List<PromptTokensDetail>? promptTokensDetails;

  UsageMetaDataModel({
    required this.candidatesTokenCount,
    required this.promptTokenCount,
    required this.promptTokensDetails,
    required this.thoughtsTokenCount,
    required this.totalTokenCount,
  });

  factory UsageMetaDataModel.fromJson(Map<String, dynamic> json) {
    List<PromptTokensDetail> mDetails = [];
    for (Map<String, dynamic> eachTokanDetail in json['promptTokensDetails']) {
      mDetails.add(PromptTokensDetail.fromJson(eachTokanDetail));
    }

    return UsageMetaDataModel(
      candidatesTokenCount: json['candidatesTokenCount'],
      promptTokenCount: json['promptTokenCount'],
      promptTokensDetails: mDetails,
      thoughtsTokenCount: json['thoughtsTokenCount'],
      totalTokenCount: json['totalTokenCount'],
    );
  }
}

class PromptTokensDetail {
  String? modality;
  int? tokenCount;

  PromptTokensDetail({required this.modality, required this.tokenCount});

  factory PromptTokensDetail.fromJson(Map<String, dynamic> json) {
    return PromptTokensDetail(
      modality: json['modality'],
      tokenCount: json['tokenCount'],
    );
  }
}

class ChatDataModel {
  String? modelVersion;
  String? responseId;
  List<CandidateModel>? candidates;
  UsageMetaDataModel? usageMetadata;

  ChatDataModel({
    required this.modelVersion,
    required this.responseId,
    required this.candidates,
    required this.usageMetadata,
  });

  factory ChatDataModel.fromJson(Map<String, dynamic> json){
    List<CandidateModel> mCandidate = [];
    for(Map<String, dynamic> eachCmt in json['candidates']){
      mCandidate.add(CandidateModel.fromJson(eachCmt));
    }

    return ChatDataModel(
        modelVersion: json['modelVersion'],
        responseId: json['responseId'],
        candidates: mCandidate,
        usageMetadata: json['usageMetadata']);
  }
}
