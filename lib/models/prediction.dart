class Prediction {
  int index;
  String label;
  double confidence;

  Prediction(this.index, this.label, this.confidence);

  factory Prediction.fromMap(Map<String, dynamic> map) {
    return Prediction(
        map['index'],
        map['label'],
        map['confidence']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index' : index,
      'label' : label,
      'confidence' : confidence
    };
  }

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) => other is Prediction && index == other.index && label == other.label && confidence == other.confidence;

}