
class signupModel {
  String? slug;
  String? name;
  List<SignUpStep>? step;

  signupModel({this.slug, this.name, this.step});

  signupModel.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];

    if (json['step'] != null) {
      step = <SignUpStep>[];
      json['step'].forEach((v) {
        step!.add(SignUpStep.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['name'] = name;
    if (step != null) {
      data['step'] = step!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SignUpStep {
  int? step;
  String? title;
  String? previousButtonText;
  String? nextButtonText;
  List<Fields>? fields;

  SignUpStep(
      {this.step,
        this.title,
        this.previousButtonText,
        this.nextButtonText,
        this.fields});

  SignUpStep.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    title = json['title'];
    previousButtonText = json['previous_button_text'];
    nextButtonText = json['next_button_text'];
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['step'] = step;
    data['title'] = title;
    data['previous_button_text'] = previousButtonText;
    data['next_button_text'] = nextButtonText;
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  String? name;
  String? placeholder;
  String? type;
  String? label;
  bool? required;
  Validation? validation;
  List<String>? itemList = [];

  Fields(
      {this.name,
        this.placeholder,
        this.type,
        this.label,
        this.required,
        this.validation,
        this.itemList,
      });

  Fields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    placeholder = json['placeholder'];
    type = json['type'];
    label = json['label'];
    required = json['required'];
    itemList = json['itemList'];
    validation = json['validation'] != null
        ? Validation.fromJson(json['validation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['placeholder'] = placeholder;
    data['type'] = type;
    data['label'] = label;
    data['required'] = required;
    data['itemList'] = itemList;
    if (validation != null) {
      data['validation'] = validation!.toJson();
    }
    return data;
  }
}

class Validation {
  int? minLength;
  int? maxLength;

  Validation({this.minLength, this.maxLength});

  Validation.fromJson(Map<String, dynamic> json) {
    minLength = json['min length'];
    maxLength = json['max length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min length'] = minLength;
    data['max length'] = maxLength;
    return data;
  }
}

List<signupModel> generateDummyUsers(int count) {
  List<signupModel> users = [];

  for (int i = 1; i <= count; i++) {
    users.add(signupModel(
      slug: "user-$i",
      name: "User $i",
      step: List.generate(3, (index) => SignUpStep(step: index + 1, title: "Step ${index + 1}")),
    ));
  }
  return users;
}
