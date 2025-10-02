class Contact {
  final int? id;
  final String name;
  final String email;

  Contact({
    this.id,
    required this.name,
    required this.email,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['contact_name'] ?? '',
      email: json['contact_email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contact_name': name,
      'contact_email': email,
    };
  }
}
